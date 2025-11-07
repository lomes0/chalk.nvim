# Production Readiness TODO

This document outlines critical tasks for preparing chalk.nvim for production release after the Kanagawa integration.

## 🎯 Production Readiness Recommendations

### 1. **Add Comprehensive Test Suite**
**Priority: Critical** | **Effort: High** | **Impact: Quality Assurance**

Currently, there's only a test file (`test_selection_color.lua`) in the root directory. For production:

#### Required Actions:
- **Create proper test infrastructure** using Plenary.nvim or busted
- **Test coverage needed for:**
  - Color palette generation across all variants (default, light, oled)
  - Plugin auto-detection logic
  - Dynamic color adjustment system
  - Configuration merging and validation
  - Transparency and terminal color handling
  - Highlight group application

**Rationale:** The Kanagawa integration introduced significant color changes. Automated tests prevent regressions and ensure color consistency across variants.

---

### 2. **Add Missing LICENSE File**
**Priority: Critical** | **Effort: Low** | **Impact: Legal Compliance**

The README mentions "MIT License - see [LICENSE](LICENSE)" but no LICENSE file exists in the repository.

#### Required Actions:
- **Action Required:** Create a LICENSE file with proper MIT license text
- **Include:** Copyright year and author name
- **Legal requirement:** Essential for users and potential contributors

**Rationale:** Without a license file, the legal status is ambiguous. This blocks adoption by enterprises and FOSS projects.

---

### 3. **Complete the Caching System Implementation**
**Priority: High** | **Effort: Medium** | **Impact: User Confusion**

Found TODO in `config.lua` line 39:
```lua
-- TODO: Not yet implemented - placeholder for future feature
cache = true,
```

#### Required Actions:
For production:
- **Either implement caching** to improve performance (compile highlights once, reuse)
- **Or remove the option** and document it as a future feature
- **Don't ship with non-functional config options** - confusing for users

**Suggested approach:** Look at how TokyoNight implements caching via compiled Lua files.

**Rationale:** Non-functional configuration options confuse users and create support burden.

---

### 4. **Create Proper Documentation Structure**
**Priority: High** | **Effort: Medium** | **Impact: User Experience**

#### Current State:
- README references `ARCHITECTURE.md` and `lua/chalk/types.lua` that don't exist
- No `:help` documentation (vimdoc)
- Kanagawa integration docs are in `kanagawa/` folder (temporary)

#### Required Actions:
- **Create `doc/chalk.txt`** - proper Neovim help documentation
- **Add LuaLS type definitions** (`lua/chalk/types.lua`) for better IDE support
- **Create migration guide** from Kanagawa integration
- **Clean up temporary docs** in `kanagawa/` folder
- **Add CHANGELOG.md** to track version history

**Rationale:** Users expect `:help chalk` to work. Type definitions improve developer experience.

---

### 5. **Remove Development Artifacts & Add Version Management**
**Priority: Medium** | **Effort: Low** | **Impact: Professional Polish**

#### Current Issues:
- `test_selection_color.lua` in root directory (should be in `tests/`)
- No version numbering system
- No `.gitignore` content visible (need to verify what's excluded)
- Deprecation warnings mention "v1.0.0" and "v2.0.0" but no actual versioning

#### Required Actions:
- **Move test files** to proper `tests/` directory structure
- **Add version constant** to `lua/chalk/init.lua` (e.g., `M.version = "1.0.0"`)
- **Create Git tags** for releases
- **Document migration path** for deprecated features
- **Set up CI/CD** for automated testing and releases

**Rationale:** Professional projects need clear versioning for dependency management and upgrade paths.

---

## 📋 Summary Priority Matrix

| Task | Priority | Effort | Impact | Status |
|------|----------|--------|--------|--------|
| Add LICENSE file | 🔴 Critical | Low | Legal compliance | ⬜ Todo |
| Test suite | 🔴 Critical | High | Quality assurance | ⬜ Todo |
| Fix/remove cache option | 🟡 High | Medium | User confusion | ⬜ Todo |
| Vimdoc documentation | 🟡 High | Medium | User experience | ⬜ Todo |
| Version management | 🟢 Medium | Low | Professional polish | ⬜ Todo |

---

## 🚀 Recommended Implementation Order

1. **LICENSE file** - Quick win, removes legal blocker
2. **Documentation** - Creates proper help system and type definitions
3. **Test suite** - Ensures quality and prevents regressions
4. **Caching** - Either implement or remove, don't leave half-done
5. **Cleanup** - Professional polish and version management

---

## 📝 Additional Notes

- These tasks transform chalk.nvim from a feature-complete development project into a production-ready, maintainable Neovim colorscheme
- Focus on user trust and contributor experience
- Post-Kanagawa integration: ensure color consistency is validated through tests

---

**Last Updated:** 7 November 2025
