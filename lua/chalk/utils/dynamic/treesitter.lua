-- TreeSitter analysis utilities for chalk.nvim dynamic features
-- Handles cursor inspection and TreeSitter token analysis

local M = {}
local shared = require("chalk.utils.shared")

---Get TreeSitter capture at cursor position
---@param bufnr? number Buffer number (default: current buffer)
---@param row? number Row position (0-indexed, default: cursor row)
---@param col? number Column position (0-indexed, default: cursor col)
---@return string|nil capture TreeSitter capture name or nil
function M.get_ts_capture_at_cursor(bufnr, row, col)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if not row or not col then
		local cursor = vim.api.nvim_win_get_cursor(0)
		row = cursor[1] - 1 -- Convert to 0-indexed
		col = cursor[2]
	end

	-- Get TreeSitter parser
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return nil
	end

	-- Parse and get syntax tree
	local trees = parser:parse()
	if not trees or #trees == 0 then
		return nil
	end

	local root = trees[1]:root()

	-- Find the node at cursor position
	local node = root:descendant_for_range(row, col, row, col)
	if not node then
		return nil
	end

	-- Get captures for this node
	local query_ok, query = pcall(vim.treesitter.query.get, parser:lang(), "highlights")
	if not query_ok or not query then
		return nil
	end

	-- Find captures that match this node
	for capture_id, capture_node in query:iter_captures(root, bufnr, row, row + 1) do
		if capture_node:id() == node:id() then
			local capture_name = query.captures[capture_id]
			return "@" .. capture_name
		end
	end

	-- Fallback: try to infer from node type
	local node_type = node:type()
	if node_type then
		-- Common TreeSitter node type to semantic token mappings
		local type_mappings = {
			["identifier"] = "@variable",
			["function_identifier"] = "@function",
			["type_identifier"] = "@type",
			["field_identifier"] = "@property",
			["string"] = "@string",
			["number"] = "@number",
			["comment"] = "@comment",
			["keyword"] = "@keyword",
		}

		return type_mappings[node_type] or ("@" .. node_type)
	end

	return nil
end

---Enhanced TreeSitter dump with better token mapping
---@param bufnr? number Buffer number (default: current buffer)
---@return string dump TreeSitter dump text
function M.dump_treesitter_structure(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return "TreeSitter parser not available for this buffer"
	end

	local trees = parser:parse()
	if not trees or #trees == 0 then
		return "No syntax tree available"
	end

	-- Get buffer content
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Get highlight query
	local query_ok, query = pcall(vim.treesitter.query.get, parser:lang(), "highlights")

	local dump_lines = {}
	local unique_tokens = {}

	-- Process all captures if query is available
	if query_ok and query then
		for capture_id, node in query:iter_captures(trees[1]:root(), bufnr) do
			local capture_name = query.captures[capture_id]
			local semantic_token = "@" .. capture_name

			-- Get node text
			local start_row, start_col, end_row, end_col = node:range()
			if start_row == end_row and start_row < #lines then
				local line_text = lines[start_row + 1] or ""
				local node_text = string.sub(line_text, start_col + 1, end_col)

				if node_text and node_text:match("%S") then -- Non-whitespace
					unique_tokens[semantic_token] = true
					table.insert(dump_lines, string.format("[%s] %s", semantic_token, node_text))
				end
			end
		end
	else
		-- Fallback: walk the tree manually
		local function walk_node(node, depth)
			if depth > 10 then
				return
			end -- Prevent deep recursion

			local node_type = node:type()
			local start_row, start_col, end_row, end_col = node:range()

			if start_row == end_row and start_row < #lines then
				local line_text = lines[start_row + 1] or ""
				local node_text = string.sub(line_text, start_col + 1, end_col)

				if node_text and node_text:match("%S") then
					-- Enhanced mapping function
					local semantic_token = M.map_node_type_to_semantic_token(node_type, node_text, node)
					if semantic_token then
						unique_tokens[semantic_token] = true
						table.insert(dump_lines, string.format("[%s] %s", semantic_token, node_text))
					end
				end
			end

			for child in node:iter_children() do
				walk_node(child, depth + 1)
			end
		end

		walk_node(trees[1]:root(), 0)
	end

	-- Add summary
	local token_summary = {}
	for token in pairs(unique_tokens) do
		table.insert(token_summary, token)
	end
	table.sort(token_summary)

	local summary = string.format(
		"TreeSitter Analysis (%d unique tokens): %s\n\n",
		#token_summary,
		table.concat(token_summary, ", ")
	)

	return summary .. table.concat(dump_lines, "\n")
end

---Map node type to semantic token with enhanced logic
---@param node_type string TreeSitter node type
---@param node_text string Text content of the node
---@param node table TreeSitter node object
---@return string|nil semantic_token Semantic token or nil
function M.map_node_type_to_semantic_token(node_type, node_text, node)
	-- Direct mappings
	local direct_mappings = {
		["string"] = "@string",
		["string_literal"] = "@string",
		["number"] = "@number",
		["integer"] = "@number",
		["float"] = "@number",
		["comment"] = "@comment",
		["line_comment"] = "@comment",
		["block_comment"] = "@comment",
		["true"] = "@boolean",
		["false"] = "@boolean",
		["null"] = "@constant.builtin",
		["nil"] = "@constant.builtin",
	}

	if direct_mappings[node_type] then
		return direct_mappings[node_type]
	end

	-- Keyword detection
	if
		node_type:match("keyword")
		or node_type == "let"
		or node_type == "const"
		or node_type == "var"
		or node_type == "if"
		or node_type == "else"
		or node_type == "for"
		or node_type == "while"
		or node_type == "return"
	then
		return "@keyword"
	end

	-- Function detection with context awareness
	if node_type:match("function") then
		-- Check if it's a function call vs declaration
		local parent = node:parent()
		if parent and parent:type():match("call") then
			return "@function.call"
		else
			return "@function"
		end
	end

	-- Type-related
	if
		node_type:match("type")
		or node_type == "struct"
		or node_type == "enum"
		or node_type == "class"
		or node_type == "interface"
	then
		return "@type"
	end

	-- Identifier context analysis
	if node_type == "identifier" then
		-- Analyze context to determine semantic meaning
		local parent = node:parent()
		if parent then
			local parent_type = parent:type()

			-- Function contexts
			if parent_type:match("function") or parent_type:match("call") then
				return "@function"
			end

			-- Type contexts
			if parent_type:match("type") then
				return "@type"
			end

			-- Property/field contexts
			if parent_type:match("field") or parent_type:match("property") or parent_type:match("member") then
				return "@property"
			end
		end

		-- Default to variable
		return "@variable"
	end

	-- Operator detection
	if
		node_type:match("operator")
		or node_type == "="
		or node_type == "+"
		or node_type == "-"
		or node_type == "*"
		or node_type == "/"
	then
		return "@operator"
	end

	-- Punctuation
	if
		node_type:match("punctuation")
		or node_type == "("
		or node_type == ")"
		or node_type == "{"
		or node_type == "}"
		or node_type == "["
		or node_type == "]"
		or node_type == ";"
		or node_type == ","
	then
		return "@punctuation"
	end

	-- Property/field detection
	if node_type:match("field") or node_type:match("property") or node_type:match("member") then
		return "@property"
	end

	-- Generic fallback for unknown types
	if node_text and node_text:match("^[A-Z][a-zA-Z0-9_]*$") then
		-- Looks like a type/constant
		return "@type"
	elseif node_text and node_text:match("^[a-z_][a-zA-Z0-9_]*$") then
		-- Looks like a variable/function
		return "@variable"
	end

	return nil
end

---Get highlight group color for a TreeSitter capture
---@param capture string TreeSitter capture (e.g., "@function")
---@return string|nil color Hex color or nil if not found
function M.get_capture_color(capture)
	local hl_group = capture:gsub("^@", "")

	-- Try common TreeSitter highlight group patterns
	local possible_groups = {
		capture, -- Direct match (e.g., "@function")
		hl_group, -- Without @ prefix
		"TS" .. hl_group, -- TreeSitter legacy format
		"@" .. hl_group .. ".builtin",
		"@" .. hl_group .. ".call",
	}

	for _, group_name in ipairs(possible_groups) do
		local hl = shared.chalk_integration().get_highlight_group(group_name)
		if hl and hl.fg then
			if type(hl.fg) == "number" then
				return string.format("#%06x", hl.fg)
			elseif type(hl.fg) == "string" then
				return hl.fg
			end
		end
	end

	return nil
end

return M
