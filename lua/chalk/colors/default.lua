---@type chalk.Palette
return {
	-- ============================================================================
	-- BACKGROUND & FOREGROUND (Kanagawa-inspired progressions)
	-- ============================================================================
	-- Background progression: darker to lighter (sumi ink series)
	bg_m3 = "#16161D", -- Deepest (kanagawa sumiInk0)
	bg_m2 = "#1a1a22", -- Very dark (kanagawa sumiInk2)
	bg_m1 = "#1F1F28", -- Dark (kanagawa sumiInk3)
	bg = "#2A2A37", -- Main background (kanagawa sumiInk4)
	bg_p1 = "#363646", -- Light (kanagawa sumiInk5)
	bg_p2 = "#424856", -- Lighter (original chalk bg)
	bg_1 = "#959dbd", -- Lightest background
	bg_2 = "#7d84a1", -- Light background

	-- Foreground progression: darker to lighter
	fg_darker = "#424140", -- Darkest foreground - improved contrast
	fg_dim = "#727169", -- Dimmed foreground (kanagawa fujiGray)
	fg = "#b3b0ac", -- Main foreground - refined chalk white
	fg_light = "#DCD7BA", -- Light foreground (kanagawa fujiWhite)
	fg_lighter = "#f0ebe4", -- Lightest foreground - crisp sophisticated chalk

	-- ============================================================================
	-- REDS (Kanagawa dragon series integration)
	-- ============================================================================
	crimson = "#ff5d62", -- Light crimson - bright red glow
	ruby = "#ff757f", -- Light ruby - gentle red glow
	cherry = "#ec6788", -- Light cherry - bright pink glow
	rose = "#eb6f92", -- Base rose - sophisticated warm red
	dragon_red = "#c4746e", -- Kanagawa dragonRed - muted sophisticated red
	samurai_red = "#E82424", -- Kanagawa samuraiRed - error/urgent

	-- ============================================================================
	-- PINKS (Kanagawa integration)
	-- ============================================================================
	pink = "#fcade2", -- Light pink - gentle cotton candy
	dragon_pink = "#a292a3", -- Kanagawa dragonPink - muted sophisticated pink
	sakura_pink = "#D27E99", -- Kanagawa sakuraPink - special highlight
	coral = "#c4746e", -- Base coral - sophisticated warm pink-orange
	peach = "#c56e6e", -- Dark peach - rich coral depth

	-- ============================================================================
	-- ORANGES (Kanagawa integration)
	-- ============================================================================
	copper = "#e7b493", -- Light copper - soft metal glow
	dragon_orange = "#b6927b", -- Kanagawa dragonOrange - muted warm
	orange = "#fda751", -- Light peach - gentle citrus glow
	tangerine = "#f6c177", -- Light tangerine - bright citrus glow
	ronin_yellow = "#FF9E3B", -- Kanagawa roninYellow - warning

	-- ============================================================================
	-- YELLOWS (Kanagawa integration)
	-- ============================================================================
	yellow = "#ffd8ab", -- Light yellow - bright sunshine
	dragon_yellow = "#c4b28a", -- Kanagawa dragonYellow - muted gold
	amber = "#f9d791", -- Light champagne - soft golden glow
	gold = "#f2ecbc", -- Light gold - gentle metallic glow
	old_white = "#C8C093", -- Kanagawa oldWhite - warm muted

	-- ============================================================================
	-- GREENS (Kanagawa integration)
	-- ============================================================================
	lime = "#c3e88d", -- Light lime - fresh bright green
	spring_green = "#98BB6C", -- Kanagawa springGreen - nature inspired
	dragon_green = "#699469", -- Kanagawa dragonGreen - muted sophisticated
	emerald = "#b7d0ae", -- Light sage mist - gentle natural
	sage = "#cfdac6", -- Light sage - airy herbal tint

	-- ============================================================================
	-- CYANS/TEALS (Kanagawa integration)
	-- ============================================================================
	turquoise = "#93dddc", -- Base turquoise - vibrant ocean sophistication
	wave_aqua = "#6A9589", -- Kanagawa waveAqua1 - info diagnostic
	dragon_aqua = "#8ea49e", -- Kanagawa dragonAqua - muted teal
	seafoam = "#A3D4D5", -- Light seafoam - gentle ocean mist
	teal = "#b8ebe6", -- Light aqua foam - gentle teal
	cyan = "#86e1fc", -- Light cyan - bright electric blue

	-- ============================================================================
	-- BLUES (Kanagawa integration)
	-- ============================================================================
	azure = "#92c2dd", -- Light powder blue - gentle sky
	crystal_blue = "#7E9CD8", -- Kanagawa crystalBlue - clear accent
	dragon_blue = "#658594", -- Kanagawa dragonBlue - muted sophisticated
	steel_blue = "#76bbc9", -- Base steel blue - enhanced visibility
	ocean_blue = "#5aa8b5", -- Medium ocean - balanced blue depth
	royal = "#8fd0fc", -- Light royal - bright sky blue
	indigo = "#89a5e6", -- Base indigo - sophisticated deep blue
	periwinkle = "#89a5e6", -- Periwinkle blue - soft blue-violet

	-- ============================================================================
	-- PURPLES/VIOLETS (Kanagawa integration)
	-- ============================================================================
	violet = "#c7a9ff", -- Light violet - gentle purple glow
	dragon_violet = "#8992a7", -- Kanagawa dragonViolet - muted sophisticated
	spring_violet = "#9CABCA", -- Kanagawa springViolet1 - soft purple
	amethyst = "#b97898", -- Light amethyst - bright purple glow
	mauve_light = "#f0c0f0", -- Light mauve mist - gentle purple-gray
	mauve = "#c4a4c4", -- Base mauve - sophisticated purple-gray
	mauve_medium = "#b394b3", -- Medium mauve - balanced purple depth
	mauve_dark = "#a284a2", -- Dark mauve - rich purple-gray

	-- ============================================================================
	-- NEUTRALS/BROWNS/GRAYS (Kanagawa integration)
	-- ============================================================================
	bronze = "#d6c0a5", -- Light bronze - gentle metallic beige
	earth = "#cdb49e", -- Light clay soil - soft warm tan
	clay = "#d9b4a3", -- Light clay - soft rosy tan
	cream = "#cbbca4", -- Darkest cream - warm muted sand
	taupe = "#cfc6be", -- Light taupe - soft warm gray
	
	-- Kanagawa dragon black series (borders, UI elements)
	dragon_black0 = "#0d0c0c", -- Deepest
	dragon_black1 = "#12120f", -- Very dark
	dragon_black2 = "#1D1C19", -- Dark
	dragon_black3 = "#181616", -- Medium dark
	dragon_black4 = "#282727", -- Medium
	dragon_black5 = "#393836", -- Light
	dragon_black6 = "#625e5a", -- Lightest (borders)
	
	-- Stone/gray series
	slate = "#8ea4a2", -- Light slate - balanced neutral
	stone_1 = "#b3b8d1", -- Light stone - cool elegance
	stone_2 = "#9ca2bd", -- Base cool stone - sophisticated cool
	stone_3 = "#74798f", -- Medium pewter - balanced stone depth
	stone_4 = "#545c7e", -- Dark pewter - refined cool depth
	powder = "#c6d1db", -- Light powder - gentle dusty blue
	shadow = "#c4c7d4", -- Light shadow - misted cool gray
	mist = "#e8ecf1", -- Light mist - airy cool veil
	ash = "#a6a69c", -- Ash gray - neutral warm gray
	fuji_gray = "#727169", -- Kanagawa fujiGray - comments

	-- ============================================================================
	-- SEMANTIC COLORS (Kanagawa-inspired)
	-- ============================================================================
	purple = "#9d7cd8", -- Base violet - sophisticated purple
	blue = "#7E9CD8", -- Kanagawa crystalBlue - clear visibility
	red = "#E46876", -- Base ruby - elegant red
	green = "#9ece6a", -- Base emerald - sophisticated green
	orange = "#FF9E3B", -- Kanagawa roninYellow - refined orange
	yellow = "#f6c177", -- Base yellow - sophisticated gold
	cyan = "#73daca", -- Base turquoise - elegant cyan
	comment = "#727169", -- Kanagawa fujiGray - muted natural comments

	-- ============================================================================
	-- PRIMARY COLORS (Kanagawa-inspired mode colors)
	-- ============================================================================
	primary = "#7E9CD8", -- Kanagawa crystalBlue - sophisticated primary
	secondary = "#6CAF95", -- Base seafoam - elegant secondary
	accent = "#98BB6C", -- Kanagawa springGreen - refined accent

	-- ============================================================================
	-- STATUS COLORS (Kanagawa semantic colors)
	-- ============================================================================
	error = "#E82424", -- Kanagawa samuraiRed - urgent error
	warning = "#FF9E3B", -- Kanagawa roninYellow - warning
	info = "#7E9CD8", -- Kanagawa crystalBlue - info
	hint = "#6A9589", -- Kanagawa waveAqua1 - subtle hints
	success = "#98BB6C", -- Kanagawa springGreen - success

	-- ============================================================================
	-- DIAGNOSTIC COLORS (Kanagawa diagnostic system)
	-- ============================================================================
	diagnostic_error = "#c4746e", -- Kanagawa dragonRed - muted error
	diagnostic_warning = "#c4b28a", -- Kanagawa dragonYellow - muted warning
	diagnostic_info = "#658594", -- Kanagawa dragonBlue - muted info
	diagnostic_hint = "#8ea49e", -- Kanagawa dragonAqua - muted hint

	-- ============================================================================
	-- GIT COLORS
	-- ============================================================================
	git_add = "#b7d0ae", -- Light emerald - sophisticated addition
	git_change = "#f6c177", -- Base yellow - elegant modification
	git_delete = "#ff757f", -- Light ruby - refined deletion
	git_text = "#65bcff", -- Base royal - sophisticated text changes

	-- ============================================================================
	-- DIFF COLORS
	-- ============================================================================
	diff_add = "#97ca95", -- Medium emerald - sophisticated addition
	diff_delete = "#ff899d", -- Light rose - refined deletion
	diff_change = "#f9d791", -- Light amber - elegant modification
	diff_text = "#4f7ab6", -- Medium royal - sophisticated text
	diff_add_bg = "#488154", -- Subtle green background for additions
	diff_change_bg = "#cc9364", -- Standard git diff change background
	diff_delete_bg = "#ad6069", -- Subtle red background for deletions
	diff_text_bg = "#444d5e", -- Subtle blue background for text changes

	-- ============================================================================
	-- UI COLORS (Kanagawa-inspired UI elements)
	-- ============================================================================
	selection = "#363646", -- Kanagawa sumiInk5 - muted selection
	search = "#9CABCA", -- Kanagawa springViolet1 - soft search
	match = "#9d7cd8", -- Base violet - sophisticated matching
	cursor = "#DCD7BA", -- Kanagawa fujiWhite - clear cursor
	cursor_line = "#2A2A37", -- Kanagawa sumiInk4 - subtle line
	line_number = "#54546D", -- Kanagawa sumiInk6 - muted line numbers
	line_number_current = "#DCD7BA", -- Kanagawa fujiWhite - current line emphasis
	border = "#625e5a", -- Kanagawa dragonBlack6 - subtle borders

	-- ============================================================================
	-- SPECIAL COLORS
	-- ============================================================================
	pure_white = "#ffffff",
	pure_black = "#000000",
	transparent = "NONE",
}
