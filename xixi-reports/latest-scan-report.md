# xixi Scan Report
**Scan range:** issues #66700–#66800 | PRs #66700–#66800
**Timestamp:** 2026-04-15T05:02 GMT+8
**Scanner:** xixi-subagent

---

## Summary

- Issues scanned: 120 (open, unassigned, latest-updated)
- PRs scanned: 50 (open)
- Top Candidates identified: **11 issues + 2 already-covered**
- Security bugs: **3 unassigned** (no PR yet)

---

## ✅ Already Covered by Open PRs

| Issue | Title | PR | Status |
|-------|-------|----|--------|
| #66773 | device.token.rotate returns plaintext device tokens | [#66794](https://github.com/openclaw/openclaw/pull/66794) | fix: redact device token from rotate response — **READY TO MERGE** |
| #66769 | skills.update echoes raw apiKey and env secrets | [#66793](https://github.com/openclaw/openclaw/pull/66793) | fix: redact apiKey and env secrets — **READY TO MERGE** |
| #66766 | Session context limit shows 200k instead of 1M for Opus/Sonnet 4 | [#66790](https://github.com/openclaw/openclaw/pull/66790) | fix: return 1M context tokens — **READY TO MERGE** |
| #66691 | allowPrivateNetwork not applied for audio transcription | [#66777](https://github.com/openclaw/openclaw/pull/66777) | fix(media): honor allowPrivateNetwork — **READY TO MERGE** |
| #66695 | pre-commit hook assumes bare pnpm | [#66776](https://github.com/openclaw/openclaw/pull/66776) | fix(pre-commit): fall back to corepack-managed pnpm — **READY TO MERGE** |
| #66744 | provider?.models?.some is not a function | [#66761](https://github.com/openclaw/openclaw/pull/66761) | fix(models): guard against non-array models — **READY TO MERGE** |

---

## 🔴 Top Candidates — Fix Immediately

### 1. [#66799](https://github.com/openclaw/openclaw/issues/66799) — SECURITY: agents.files.get allows operator.read callers to read arbitrary workspace files

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Security |
| **Labels** | `bug`, `bug:behavior` |
| **Author** | ai-hpc (NVIDIAN) |
| **Updated** | 2026-04-14T20:42:10Z |
| **PR Coverage** | ❌ None |

**Assessment:** Critical security bug. `agents.files.get` exposed to `operator.read` scope allows reading any file inside the agent workspace (`.env`, `config/private.json`, etc.). Path traversal is blocked but no allowlist. Fix: require stronger scope or restrict to safe allowlist. **Root cause clear — fix is straightforward scope check.**

---

### 2. [#66797](https://github.com/openclaw/openclaw/issues/66797) — Group natural-language messages silently dropped in 2026.4.11 (regression)

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Regression |
| **Labels** | *(none — needs `regression` label)* |
| **Author** | kpiyush88 |
| **Updated** | 2026-04-14T20:50:39Z |
| **PR Coverage** | ❌ None |

**Assessment:** Long-standing regression chain (refs #29637, #30591, #28307, #24262, #6165). Group messages reach `sessions.json` registration but never create JSONL file or invoke agent. Slash commands work fine. Still broken in **2026.4.14** per latest comment. Filter is between session registration and agent dispatch. **Root cause clearly narrowed by reporter — high priority.**

---

### 3. [#66768](https://github.com/openclaw/openclaw/issues/66768) — Empty completed turns in ghcr.io/openclaw/openclaw:2026.4.14 (OpenRouter regression)

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | tyzoid |
| **Updated** | 2026-04-14T19:41:33Z |
| **PR Coverage** | ❌ None |

**Assessment:** OpenRouter models return `content: []`, `usage: {input:0,output:0}`. Works in 2026.4.12, broken in 2026.4.14. Probe reports OK but actual chat returns empty. Classic regression pattern — likely a stream-handling or response-parsing change in the openai-completions adapter. **Clear repro steps + working baseline — good candidate.**

---

### 4. [#66752](https://github.com/openclaw/openclaw/issues/66752) — ERR_MODULE_NOT_FOUND audit-Cb4RZuLD.js on ARM64 npm global install

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | dongkl |
| **Updated** | 2026-04-14T19:16:51Z |
| **PR Coverage** | ❌ None |

**Assessment:** ARM64-specific build artifact mismatch. `channel-CJUAgRQR.js` imports `audit-Cb4RZuLD.js` but that file doesn't exist in the npm package. Similar to root cause fixed in PR #65471. Blocks all channel operations on Raspberry Pi. **Clear evidence + known root cause family.**

---

### 5. [#66804](https://github.com/openclaw/openclaw/issues/66804) — Active Memory timeout with MiniMax-M2.7: model fails to respond within 15s timeout

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Behavior |
| **Labels** | *(none)* |
| **Author** | kumikoda110 |
| **Updated** | 2026-04-14T20:51:27Z |
| **PR Coverage** | ❌ None |

**Assessment:** Active Memory runs in fts-only mode, MiniMax-M2.7 times out at 15s, total wait 57s, returns `summaryChars=0`. `reasoning: true` may cause long reasoning loops. No fallback model configured. FTS-only mode + model timeout interaction needs investigation. High impact for MiniMax users.

---

### 6. [#66800](https://github.com/openclaw/openclaw/issues/66800) — Dashboard WebSocket disconnects with token_mismatch after gateway restart

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Behavior |
| **Labels** | *(none)* |
| **Author** | tahaqaqbot |
| **Updated** | 2026-04-14T20:42:18Z |
| **PR Coverage** | ❌ None |

**Assessment:** After gateway restart, Control UI reconnects with stale token → `token_mismatch` → retry loop → rate limit lockout. Dashboard inaccessible until rate limit expires. Token refresh mechanism broken. User must hard-refresh. Impacts all remote/dashboard users.

---

### 7. [#66786](https://github.com/openclaw/openclaw/issues/66786) — System Prompt doesn't respect OPENCLAW_WORKSPACE_DIR

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | scottburton11 |
| **Updated** | 2026-04-14T20:31:41Z |
| **PR Coverage** | ❌ None |

**Assessment:** On headless Linux with `OPENCLAW_WORKSPACE_DIR` set to EFS volume path, system prompt injects `/home/node/.openclaw/workspace` instead. Agent file/memory ops go to wrong path. Clear root cause: workspaceDir resolved from config default before env var is applied.

---

### 8. [#66784](https://github.com/openclaw/openclaw/issues/66784) — Comfy provider config rejected: plugin configSchema not merged

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Behavior |
| **Labels** | `bug`, `bug:behavior` |
| **Author** | eX4c7 |
| **Updated** | 2026-04-14T20:34:32Z |
| **PR Coverage** | ❌ None |

**Assessment:** Config validation rejects all comfy plugin keys (`mode`, `baseUrl`, `music`, etc.) as "Unrecognized". `additionalProperties: false` prevents plugin's `configSchema` from being merged. Bundled plugin effectively unusable. Reporter suggests merging plugin `configSchema` into provider validator or using `passthrough()`. Affects image/video/music workflows.

---

### 9. [#66756](https://github.com/openclaw/openclaw/issues/66756) — Telegram group slash commands stop working on 2026.4.14 (2026.4.12 works)

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Regression |
| **Labels** | *(none)* |
| **Author** | n_haener |
| **Updated** | 2026-04-14T20:19:41Z |
| **Confirmed by** | jx-grxf (same symptoms) |
| **PR Coverage** | ❌ None |

**Assessment:** Confirmed regression (2026.4.12 works → 2026.4.14 breaks → rollback fixes). Affects slash command picker/autocomplete and manual commands in Telegram groups. Privacy mode already disabled. Same root cause family as #66714 (setMyCommands not called on restart). **Likely fixable alongside #66714.**

---

### 10. [#66714](https://github.com/openclaw/openclaw/issues/66714) — Telegram setMyCommands not called on gateway restart in 2026.4.14

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Regression |
| **Labels** | *(none)* |
| **Author** | Non-Zero-AI |
| **Updated** | 2026-04-14T20:52:20Z |
| **Confirmed by** | jx-grxf |
| **PR Coverage** | ❌ None |

**Assessment:** After gateway restart, `setMyCommands` is never called (earlier same-session restarts DID call it). `getMyCommands` returns empty. Commands disappear from Telegram bot menu. Earlier restarts in same session worked — suggests a timing/init order issue. Related to #66756 (same channel, same version).

---

### 11. [#66681](https://github.com/openclaw/openclaw/issues/66681) — Health-monitor causes gateway crash: TypeError Cannot read properties of undefined

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Behavior |
| **Labels** | *(none)* |
| **Author** | WhiteGiverMa (若梦) |
| **Updated** | 2026-04-14T16:51:10Z |
| **PR Coverage** | ❌ None |

**Assessment:** `log?.info?.()` pattern is wrong — should be `log?.info?.()` but `log` itself is undefined. Correct fix is `log?.info?.()` (optional chaining on `log`). Root cause line pinpointed by reporter. Gateway crashes when health-monitor tries to restart a channel with missing log entry. Simple one-line fix.

---

## 🟡 Medium Priority (Notable but less urgent)

| Issue | Title | Notes |
|-------|-------|-------|
| #66626 | config.get leaks raw secrets via sourceConfig/runtimeConfig | Closed by maintainer (@steipete said "Fixed") — needs verification |
| #66688 | memory index fails with Unknown memory embedding provider: ollama | Maintainer confirmed fix on main in 37f449d — mark as covered |
| #66701 | NO_REPLY detection fails when model prepends reasoning blocks | Covered by PR #66755 (fix(auto-reply): detect silent NO_REPLY wrapped in model reasoning) |

---

## 📋 Fix Queue (Recommended Order)

| Priority | Issue | Why |
|----------|-------|-----|
| 1 | #66799 | Security — arbitrary file read via operator.read |
| 2 | #66797 | P1 regression — group messages dropped |
| 3 | #66768 | P1 regression — empty turns with OpenRouter |
| 4 | #66752 | P1 regression — ARM64 broken install |
| 5 | #66756 / #66714 | P2 regression — Telegram slash commands |
| 6 | #66800 | P2 — WebSocket token_mismatch after restart |
| 7 | #66786 | P2 regression — wrong workspace dir in system prompt |
| 8 | #66784 | P2 — Comfy plugin unusable (image/video/music) |
| 9 | #66804 | P2 — Active Memory timeout MiniMax-M2.7 |
| 10 | #66681 | P2 — health-monitor gateway crash |

---

*Report generated by xixi-subagent — 2026-04-15*
