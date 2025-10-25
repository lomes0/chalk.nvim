-- Harmonious Chalky Earth - A sophisticated color scheme designed for visual harmony
-- Based on perceptual color theory with earth tones and refined jewel accents
-- Each color family provides 5 shades from lightest (1) to darkest (5)
-- Designed with mathematical precision for optimal visual balance

-- Import types for LSP support
require("chalk.types")

---@type chalk.Palette
return {

	-- Normal = "#010e29",

	-- === EMERALD FAMILY (Sophisticated sage greens) - Nature harmony ===
	-- === EMERALD FAMILY (Sophisticated sage greens) - Nature harmony ===
	emerald_1 = "#b7d0ae", -- Light sage mist - gentle natural (from tpm)
	emerald_2 = "#b3e082", -- Base sage - vibrant sophisticated green (from tpm)
	emerald_3 = "#88b177", -- Medium forest - balanced green depth (from tpm)
	emerald_4 = "#6c9632", -- Dark forest - rich natural depth (from tpm)
	emerald_5 = "#529661", -- Darkest pine - deep forest shadow (from tpm)

	-- === LIME FAMILY (Bright vibrant greens) - Fresh energy ===
	lime_1 = "#c3e88d", -- Light lime - fresh bright green (from tpm)
	lime_2 = "#abcf74", -- Base lime - vibrant spring green (from tpm)
	lime_3 = "#9fe044", -- Medium lime - energetic green (from tpm)
	lime_4 = "#9fe044", -- Dark lime - muted forest green (from tpm)
	lime_5 = "#8ac537", -- Darkest lime - deep natural green (from tpm)

	-- === TURQUOISE FAMILY (Vibrant blue-greens) - Ocean elegance ===
	turquoise_1 = "#b4f9f8", -- Light aqua mist - gentle ocean breeze (from tpm)
	turquoise_2 = "#93dddc", -- Base turquoise - vibrant ocean sophistication (from tpm)
	turquoise_3 = "#5cc0b3", -- Medium teal - balanced aquatic depth (from tpm)
	turquoise_4 = "#1abc9c", -- Dark teal - rich ocean depth (from tpm)
	turquoise_5 = "#269b84", -- Darkest sea green - deep ocean shadow (from tpm)

	-- === CYAN FAMILY (Bright blue-cyan tones) - Electric ocean ===
	cyan_1 = "#86e1fc", -- Light cyan - bright electric blue (from tpm)
	cyan_2 = "#61c4e2", -- Base cyan - vibrant sky blue (from tpm)
	cyan_3 = "#2ac3de", -- Medium cyan - energetic ocean blue (from tpm)
	cyan_4 = "#1fb2cc", -- Dark cyan - rich electric blue (from tpm)
	cyan_5 = "#2595a8", -- Darkest cyan - deep ocean blue (from tpm)

	-- === SEAFOAM FAMILY (Soft green-blue tones) - Ocean breeze elegance ===
	seafoam_1 = "#A3D4D5", -- Light seafoam - gentle ocean mist (from tpm)
	seafoam_2 = "#85c4c5", -- Base seafoam - sophisticated aqua green (from tpm)
	seafoam_3 = "#85c4c5", -- Medium seafoam - balanced ocean depth (from tpm)
	seafoam_4 = "#53b4a7", -- Dark seafoam - rich aqua elegance (from tpm)
	seafoam_5 = "#449694", -- Darkest seafoam - deep ocean shadow (from tpm)

	-- === VIOLET FAMILY (Soft purple tones) - Creative elegance ===
	violet_1 = "#c7a9ff", -- Light violet - gentle purple glow (from tpm)
	violet_2 = "#a689da", -- Base violet - sophisticated purple (from tpm)
	violet_3 = "#9376c2", -- Medium violet - balanced purple depth (from tpm)
	violet_4 = "#8356c2", -- Dark violet - rich purple tone (from tpm)
	violet_5 = "#6d5d97", -- Darkest violet - deep purple shadow (from tpm)

	-- === TEAL FAMILY (Balanced blue-greens) - Calm clarity ===
	teal_1 = "#b8ebe6", -- Light aqua foam - gentle teal
	teal_2 = "#8dd7cf", -- Base teal - balanced blue-green
	teal_3 = "#56c2b8", -- Medium teal - calm clarity
	teal_4 = "#319e97", -- Dark teal - focused cool depth
	teal_5 = "#237a74", -- Darkest teal - deep aquatic shadow

	-- === AMETHYST FAMILY (Rich purple tones) - Luxury elegance ===
	amethyst_1 = "#b97898", -- Light amethyst - bright purple glow (from tpm)
	amethyst_2 = "#a56585", -- Base amethyst - rich royal purple (from tpm)
	amethyst_3 = "#8f5572", -- Medium amethyst - balanced purple depth (from tpm)
	amethyst_4 = "#6b3d54", -- Dark amethyst - deep royal purple (from tpm)
	amethyst_5 = "#532b3f", -- Darkest amethyst - profound purple shadow (from tpm)

	-- === MAUVE FAMILY (Soft purple-gray tones) - Gentle sophistication ===
	mauve_1 = "#f0c0f0", -- Light mauve mist - gentle purple-gray
	mauve_2 = "#c4a4c4", -- Base mauve - sophisticated purple-gray
	mauve_3 = "#b394b3", -- Medium mauve - balanced purple depth
	mauve_4 = "#a284a2", -- Dark mauve - rich purple-gray
	mauve_5 = "#8f618f", -- Darkest mauve - deep sophisticated purple

	-- === INDIGO FAMILY (Deep sophisticated blues) - Rich navy elegance ===
	indigo_1 = "#9ab8ff", -- Light periwinkle - gentle deep blue (from tpm)
	indigo_2 = "#89a5e6", -- Base indigo - sophisticated deep blue (from tpm)
	indigo_3 = "#7687c2", -- Medium midnight - balanced indigo depth (from tpm)
	indigo_4 = "#5a71ad", -- Dark midnight - rich navy depth (from tpm)
	indigo_5 = "#425381", -- Darkest navy - profound blue shadow (from tpm)

	-- === SAGE FAMILY (Muted herb greens) - Subtle warmth ===
	sage_1 = "#cfdac6", -- Light sage - airy herbal tint
	sage_2 = "#b9cbb0", -- Base sage - muted natural green
	sage_3 = "#9db495", -- Medium sage - grounded harmony
	sage_4 = "#7e9b79", -- Dark sage - warm earthy green
	sage_5 = "#5c7458", -- Darkest sage - deep herbal shadow

	-- === ROYAL FAMILY (Bright electric blues) - Vibrant sophistication ===
	royal_1 = "#8fd0fc", -- Light royal - bright sky blue (from tpm)
	royal_2 = "#5baae6", -- Base royal - vibrant electric blue (from tpm)
	royal_3 = "#3f86e9", -- Medium royal - energetic blue (from tpm)
	royal_4 = "#4066be", -- Dark royal - rich electric depth (from tpm)
	royal_5 = "#405f83", -- Darkest royal - deep electric shadow (from tpm)

	-- === EARTH FAMILY (Rich soil browns) - Grounded depth ===
	earth_1 = "#cdb49e", -- Light clay soil - soft warm tan
	earth_2 = "#b79780", -- Base earth - natural brown
	earth_3 = "#9e7c66", -- Medium earth - grounded warmth
	earth_4 = "#7f624f", -- Dark earth - sturdy soil depth
	earth_5 = "#5d4738", -- Darkest earth - deep fertile shadow

	-- === AZURE FAMILY (Enhanced ocean blues) - Better visibility ===
	azure_1 = "#92c2dd", -- Light powder blue - gentle sky (from tpm)
	azure_2 = "#76bbc9", -- Base steel blue - enhanced visibility (from tpm)
	azure_3 = "#66a1d1", -- Medium ocean - balanced blue depth (from tpm)
	azure_4 = "#3a7c96", -- Dark ocean - rich depth with better contrast (from tpm)
	azure_5 = "#23697c", -- Darkest navy - professional depth (from tpm)

	-- === MIST FAMILY (Cool airy grays) - Morning haze ===
	mist_1 = "#e8ecf1", -- Light mist - airy cool veil
	mist_2 = "#d8dee7", -- Base mist - calm soft gray-blue
	mist_3 = "#c7cfdb", -- Medium mist - gentle clarity
	mist_4 = "#b1bac8", -- Dark mist - balanced haze
	mist_5 = "#98a1b0", -- Darkest mist - subdued cool shadow

	-- === CLAY FAMILY (Soft red-browns) - Ceramic warmth ===
	clay_1 = "#d9b4a3", -- Light clay - soft rosy tan
	clay_2 = "#c59787", -- Base clay - warm red-brown
	clay_3 = "#ab7b6d", -- Medium clay - kiln warmth
	clay_4 = "#8c6257", -- Dark clay - baked earth
	clay_5 = "#6d4b43", -- Darkest clay - earthen shadow

	-- === POWDER FAMILY (Soft dusty blue tones) - Gentle sophistication ===
	powder_1 = "#c6d1db", -- Light powder - gentle dusty blue
	powder_2 = "#b8c8d8", -- Base powder - sophisticated dusty blue
	powder_3 = "#b1bbc5", -- Medium powder - balanced dusty depth
	powder_4 = "#a0afbd", -- Dark powder - rich dusty blue
	powder_5 = "#818b97", -- Darkest powder - deep dusty shadow

	-- === ROSE FAMILY (Warm red-pink tones) - Sophisticated rose elegance ===
	rose_1 = "#ff899d", -- Light rose mist - gentle warm red-pink (from tpm)
	rose_2 = "#eb6f92", -- Base rose - sophisticated warm red (from tpm)
	rose_3 = "#D27E99", -- Medium rose - balanced red-pink depth (from tpm)
	rose_4 = "#b35b79", -- Dark rose - rich warm red (from tpm)
	rose_5 = "#6d3641", -- Darkest rose - deep red shadow (from tpm)

	-- === CHERRY FAMILY (Vibrant red-pink tones) - Bright elegance ===
	cherry_1 = "#ec6788", -- Light cherry - bright pink glow (from tpm)
	cherry_2 = "#e45679", -- Base cherry - vibrant pink-red (from tpm)
	cherry_3 = "#d64b6e", -- Medium cherry - energetic pink (from tpm)
	cherry_4 = "#cc4d6d", -- Dark cherry - rich fuchsia (from tpm)
	cherry_5 = "#be3f5f", -- Darkest cherry - deep pink shadow (from tpm)

	-- === RUBY FAMILY (Vibrant true reds) - Bold energy ===
	ruby_1 = "#ff757f", -- Light ruby - gentle red glow (from tpm)
	ruby_2 = "#E46876", -- Base ruby - vibrant true red (from tpm)
	ruby_3 = "#c64343", -- Medium ruby - energetic red (from tpm)
	ruby_4 = "#a4364d", -- Dark ruby - rich red depth (from tpm)
	ruby_5 = "#914c54", -- Darkest ruby - deep red shadow (from tpm)

	-- === CRIMSON FAMILY (Deep true reds) - Classic red elegance ===
	crimson_1 = "#ff5d62", -- Light crimson - bright red glow (from tpm)
	crimson_2 = "#e74c51", -- Base crimson - pure vibrant red (from tpm)
	crimson_3 = "#c5363b", -- Medium crimson - balanced red depth (from tpm)
	crimson_4 = "#a4364d", -- Dark crimson - rich red (from tpm)
	crimson_5 = "#a01f3b", -- Darkest crimson - deep red shadow (from tpm)

	-- === PINK FAMILY (Bright magenta-pinks) - Playful vibrancy ===
	pink_1 = "#fcade2", -- Light pink - gentle cotton candy
	pink_2 = "#e478b5", -- Base pink - vibrant bright pink
	pink_3 = "#eb56a8", -- Medium pink - energetic magenta-pink
	pink_4 = "#cf369c", -- Dark pink - rich fuchsia depth
	pink_5 = "#aa3388", -- Darkest pink - deep magenta shadow

	-- === CORAL FAMILY (Warm orange-pinks) - Tropical elegance ===
	coral_1 = "#d38782", -- Light coral blush - gentle tropical warmth (from tpm)
	coral_2 = "#c4746e", -- Base coral - sophisticated warm pink-orange (from tpm)
	coral_3 = "#b8605a", -- Medium salmon - balanced coral depth (from tpm)
	coral_4 = "#ac5164", -- Dark salmon - rich warm coral (from tpm)
	coral_5 = "#9c3f53", -- Darkest coral - deep tropical shadow (from tpm)

	-- === PEACH FAMILY (Soft orange-pink tones) - Gentle warmth ===
	peach_1 = "#d7a8a8", -- Light peach - soft coral glow (from tpm)
	peach_2 = "#d69999", -- Base peach - warm orange-pink (from tpm)
	peach_3 = "#ce8282", -- Medium peach - balanced warmth (from tpm)
	peach_4 = "#c56e6e", -- Dark peach - rich coral depth (from tpm)
	peach_5 = "#aa5555", -- Darkest peach - deep warm shadow (from tpm)

	-- === COPPER FAMILY (Burnished orange-browns) - Metallic warmth ===
	copper_1 = "#e7b493", -- Light copper - soft metal glow
	copper_2 = "#d59b77", -- Base copper - warm orange-brown
	copper_3 = "#bd7f5d", -- Medium copper - burnished shine
	copper_4 = "#9e6647", -- Dark copper - forged depth
	copper_5 = "#7c4c34", -- Darkest copper - patina shadow

	-- === ORANGE FAMILY (Vibrant citrus tones) - Energetic warmth ===
	orange_1 = "#fda751", -- Light peach - gentle citrus glow (from tpm)
	orange_2 = "#FF9E3B", -- Base orange - vibrant citrus energy (from tpm)
	orange_3 = "#e98a00", -- Medium tangerine - balanced orange depth (from tpm)
	orange_4 = "#cc6d00", -- Dark burnt orange - rich citrus depth (from tpm)
	orange_5 = "#b15c00", -- Darkest rust orange - deep citrus shadow (from tpm)

	-- === TANGERINE FAMILY (Bright orange tones) - Zesty energy ===
	tangerine_1 = "#f6c177", -- Light tangerine - bright citrus glow (from tpm)
	tangerine_2 = "#faba4a", -- Base tangerine - vibrant orange (from tpm)
	tangerine_3 = "#e9aa3e", -- Medium tangerine - energetic orange (from tpm)
	tangerine_4 = "#ce9431", -- Dark tangerine - rich orange depth (from tpm)
	tangerine_5 = "#b17d24", -- Darkest tangerine - deep orange shadow (from tpm)

	-- === AMBER FAMILY (Warm honey golds) - Primary warm accent ===
	amber_1 = "#f9d791", -- Light champagne - soft golden glow (from tpm)
	amber_2 = "#DCA561", -- Base honey - sophisticated gold (from tpm)
	amber_3 = "#d6974a", -- Medium brass - warm metallic gold (from tpm)
	amber_4 = "#c48437", -- Dark brass - rich metallic (from tpm)
	amber_5 = "#af7023", -- Darkest bronze - deep earthy gold (from tpm)

	-- === GOLD FAMILY (Bright metallic yellows) - Luxurious shine ===
	gold_1 = "#f2ecbc", -- Light gold - gentle metallic glow (from tpm)
	gold_2 = "#dcd7ba", -- Base gold - classic bright gold (from tpm)
	gold_3 = "#d5cea3", -- Medium gold - vibrant metallic (from tpm)
	gold_4 = "#bfb3a3", -- Dark gold - rich golden depth (from tpm)
	gold_5 = "#9b967e", -- Darkest gold - deep bronze gold (from tpm)

	-- === YELLOW FAMILY (Bright sunshine tones) - Cheerful energy ===
	yellow_1 = "#ffd8ab", -- Light yellow - bright sunshine (from tpm)
	yellow_2 = "#f1d088", -- Base yellow - vibrant golden yellow (from tpm)
	yellow_3 = "#ebd86c", -- Medium yellow - energetic sunshine (from tpm)
	yellow_4 = "#ffe15e", -- Dark yellow - rich golden warmth (from tpm)
	yellow_5 = "#fcf947", -- Darkest yellow - deep golden shadow (from tpm)

	-- === BRONZE FAMILY (Muted metallic browns) - Regal depth ===
	bronze_1 = "#d6c0a5", -- Light bronze - gentle metallic beige
	bronze_2 = "#c2a88a", -- Base bronze - muted metal brown
	bronze_3 = "#a88d70", -- Medium bronze - aged metal
	bronze_4 = "#8a7258", -- Dark bronze - rich patina
	bronze_5 = "#6b5844", -- Darkest bronze - deep antique shadow

	-- === STONE FAMILY (Cool sophisticated grays) - Modern elegance ===
	stone_1 = "#b3b8d1", -- Light stone - cool elegance (from tpm)
	stone_2 = "#9ca2bd", -- Base cool stone - sophisticated cool (from tpm)
	stone_3 = "#74798f", -- Medium pewter - balanced stone depth (from tpm)
	stone_4 = "#545c7e", -- Dark pewter - refined cool depth (from tpm)
	stone_5 = "#484f61", -- Darkest steel - deep cool shadow (from tpm)

	-- === CREAM FAMILY (Warm light neutrals) - Soft highlight ===
	cream_1 = "#faf4e8", -- Light cream - near-paper warmth
	cream_2 = "#f3ebdc", -- Base cream - soft ivory
	cream_3 = "#ece1cf", -- Medium cream - gentle parchment
	cream_4 = "#e0d2bb", -- Dark cream - mellow beige
	cream_5 = "#cbbca4", -- Darkest cream - warm muted sand

	-- === TAUPE FAMILY (Warm gray-browns) - Soft neutrality ===
	taupe_1 = "#cfc6be", -- Light taupe - soft warm gray
	taupe_2 = "#bdb2a9", -- Base taupe - cozy neutral
	taupe_3 = "#a4988f", -- Medium taupe - gentle balance
	taupe_4 = "#877c75", -- Dark taupe - refined warmth
	taupe_5 = "#6b635d", -- Darkest taupe - deep neutral shadow

	-- === SLATE FAMILY (Neutral gray tones) - Professional balance ===
	slate_1 = "#8ea4a2", -- Light slate - balanced neutral (from tpm)
	slate_2 = "#769b98", -- Base slate - sophisticated gray (from tpm)
	slate_3 = "#618d89", -- Medium slate - balanced gray depth (from tpm)
	slate_4 = "#46817c", -- Dark slate - rich gray depth (from tpm)
	slate_5 = "#2e5857", -- Darkest slate - deep shadow (from tpm)

	-- === SHADOW FAMILY (Cool near-neutrals) - Depth and contrast ===
	shadow_1 = "#c4c7d4", -- Light shadow - misted cool gray
	shadow_2 = "#a9aebf", -- Base shadow - neutral cool tone
	shadow_3 = "#8d93a8", -- Medium shadow - balanced depth
	shadow_4 = "#6f768d", -- Dark shadow - controlled contrast
	shadow_5 = "#585e73", -- Darkest shadow - deep cool focus

	-- === BACKGROUND FAMILY (Sophisticated dark chalkboard) ===
	bg_1 = "#959dbd", -- Base background - elegant chalkboard
	bg_2 = "#7d84a1", -- Base background - elegant chalkboard
	bg_3 = "#697088", -- Base background - elegant chalkboard
	bg_4 = "#51576b", -- Base background - elegant chalkboard
	bg_5 = "#333644", -- Base background - elegant chalkboard

	-- === FOREGROUND PROGRESSION (Enhanced readability chalk whites) ===
	fg_darker = "#424140", -- Darkest foreground - improved contrast (gray_3)
	fg = "#b3b0ac", -- Main foreground - brighter refined chalk white
	fg_light = "#f0ebe4", -- Light foreground - crisp sophisticated chalk

	-- === PRIMARY COLORS (Harmonious and sophisticated) ===
	primary = "#7E9CD8", -- Base indigo - sophisticated primary (from tpm)
	secondary = "#6CAF95", -- Base seafoam - elegant secondary (from tpm)
	accent = "#9ece6a", -- Base emerald - refined accent (from tpm)

	-- === STATUS COLORS (Sophisticated and clear) ===
	error = "#E46876", -- Base ruby - sophisticated error (from tpm)
	warning = "#DCA561", -- Base amber - elegant warning (from tpm)
	info = "#7E9CD8", -- Base indigo - sophisticated info (from tpm)
	hint = "#6CAF95", -- Base seafoam - elegant hints (from tpm)
	success = "#9ece6a", -- Base emerald - refined success (from tpm)

	-- === SEMANTIC COLORS (Enhanced visibility) ===
	purple = "#9d7cd8", -- Base violet - sophisticated purple (from tpm)
	blue = "#7E9CD8", -- Base indigo - better visibility (from tpm)
	red = "#E46876", -- Base ruby - elegant red (from tpm)
	green = "#9ece6a", -- Base emerald - sophisticated green (from tpm)
	orange = "#FF9E3B", -- Base orange - refined orange (from tpm)
	yellow = "#f6c177", -- Base yellow - sophisticated gold (from tpm)
	cyan = "#73daca", -- Base turquoise - elegant cyan (from tpm)
	comment = "#8087a9", -- Enhanced stone - better comment visibility (from tpm)

	-- === SPECIAL COLORS ===
	pure_white = "#ffffff",
	pure_black = "#000000",
	transparent = "NONE",

	-- === GIT COLORS (Harmonious and clear) ===
	git_add = "#b7d0ae", -- Light emerald - sophisticated addition (from tpm)
	git_change = "#f6c177", -- Base yellow - elegant modification (from tpm)
	git_delete = "#ff757f", -- Light ruby - refined deletion (from tpm)
	git_text = "#65bcff", -- Base royal - sophisticated text changes (from tpm)

	-- === DIFF COLORS (Consistent with git colors) ===
	diff_add = "#97ca95", -- Medium emerald - sophisticated addition (from tpm)
	diff_delete = "#ff899d", -- Light rose - refined deletion (from tpm)
	diff_change = "#f9d791", -- Light amber - elegant modification (from tpm)
	diff_text = "#4f7ab6", -- Medium royal - sophisticated text (from tpm)

	-- === DIFF BACKGROUND COLORS (Derived from palette) ===
	diff_add_bg = "#488154", -- emerald_5 - subtle green background for additions
	diff_change_bg = "#cc9364", -- Standard git diff change background
	diff_delete_bg = "#ad6069", -- ruby_5 - subtle red background for deletions
	diff_text_bg = "#444d5e", -- royal_5 - subtle blue background for text changes

	-- === SELECTION AND UI COLORS (Sophisticated interaction) ===
	-- selection = "#525970", -- Warm sophisticated selection
	selection = "#464b5f", -- Warm sophisticated selection
	search = "#f9d791", -- Light amber - elegant search highlight (from tpm)
	match = "#9d7cd8", -- Base violet - sophisticated matching (from tpm)

	-- Refined colors (enhanced visibility)
	cursor = "#65bcff", -- Base royal - better cursor visibility (from tpm)
	cursor_line = "#332f2b", -- Elegant warm cursor line
	line_number = "#8087a9", -- Enhanced stone - better line number visibility (from tpm)
	line_number_current = "#b3b8d1", -- Light stone - current line emphasis (from tpm)

	-- === MENU AND COMPLETION COLORS (Sophisticated UI) ===
	menu_bg = "#2f2b26", -- Warm sophisticated menu background
	menu_sel = "#3a3530", -- Refined menu selection
	menu_border = "#57534e", -- Darkest slate - elegant borders

	-- === FLOAT AND POPUP COLORS (Consistent elegance) ===
	float_bg = "#2f2b26", -- Matching sophisticated float background
	float_border = "#57534e", -- Consistent elegant borders

	-- === DIAGNOSTIC COLORS (Sophisticated feedback) ===
	diagnostic_error = "#E46876", -- Base ruby - refined error indication (from tpm)
	diagnostic_warning = "#DCA561", -- Base amber - sophisticated warning (from tpm)
	diagnostic_info = "#7E9CD8", -- Base indigo - elegant information (from tpm)
	diagnostic_hint = "#6CAF95", -- Base seafoam - sophisticated hints (from tpm)
}
