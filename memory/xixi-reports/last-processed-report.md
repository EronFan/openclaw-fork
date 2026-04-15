# Last Processed xixi Scan Report

**Scan range:** issues #67251–#67350 | PRs #67251–#67350
**Timestamp:** 2026-04-16T00:01 GMT+8 (2026-04-15T16:01 UTC)
**Report location:** xixi-reports/latest-scan-report.md

## Quick Status

- New S-level candidates: #67267, #67270, #67264, #67261, #67257, #67256, #67260, #67250
- **#67267** → dispatched to aoao (fix-67267, system message feedback loop web UI)
- #67270 → pending (Exec preflight scanner false positives)
- #67264 → pending (Gateway tilde-expands browser executablePath)
- #67261 → pending (Venice model crash)
- #67257 → pending (Telegram plugin load 2026.4.14)

## Key S-level Candidates (this scan)

1. [#67267](https://github.com/openclaw/openclaw/issues/67267) **🔴 S regression** — System message feedback loop in web UI chat. 2026.4.14 regression; system internal message 被错误标记为 "you"，导致 exec completion 错误路由到 web UI session，Agent 陷入死循环。**aoao dispatched**
2. [#67270](https://github.com/openclaw/openclaw/issues/67270) **🔴 S** — Exec preflight scanner false positives (python3 -c blocked)
3. [#67264](https://github.com/openclaw/openclaw/issues/67264) **🔴 S crash** — Gateway tilde-expands browser executablePath → ENOENT
4. [#67261](https://github.com/openclaw/openclaw/issues/67261) **🔴 S crash** — Venice model responses missing id/status cause crash
5. [#67257](https://github.com/openclaw/openclaw/issues/67257) **🔴 S regression** — Telegram plugin fails to load on 2026.4.14 (register/activate export missing)
6. [#67260](https://github.com/openclaw/openclaw/issues/67260) **🟡 B** — Native Ollama primary falls back in long-lived Telegram session
7. [#67272](https://github.com/openclaw/openclaw/issues/67272) **🟡 B Feature** — Session trigger metadata, exclude cron sessions from Dreaming

## Plugin Candidates

- Tencent/openclaw-weixin #70: IMA Knowledge Base get_doc_content returns 210005 not author error (S级)

## Maintainer PRs to Watch

- **PR #67280** fix(acp): reuse existing session key for persistent spawns with same label — WayChan, XS
- **PR #67279** fix(whatsapp): harden creds saves during reconnects — qualiobra, L
- **PR #67277** Tighten context limits and bound memory excerpts — Takhoffman (maintainer), XL
- **PR #67268** fix: clear recovered auto fallback overrides — soloclz, L

## This Cycle Deliveries

- PR #67271 (feishu pagination + streaming) ✅ merge
- PR #67274 (Windows CLI SIGKILL) ✅ completed
- PR #67273 (heartbeat exec leaks) ✅ completed, Greptile approved
- **fix-67173-v2 TIMEOUT**: subagent ran 29m48s without PR产出; PR #67258 (maintainer drain fix) still open — needs re-dispatch or confirm #67258 sufficient

## Feedback Check (this cycle)

- #54952: 0 comments (no change)
- #54964: 0 comments (no change)
- #55008: 5 comments — Greptile regression caught, EronFan fixed, **PR ready to merge**
- #55013: 2 comments — Greptile 5/5 Safe to merge + maintainer corrected groupPolicy, **PR ready to merge**

## OPENCLAW-PROJECT.md Updated

Added P60198–P60208 to「当前优先级」table (round 134, 00:01 CST).

## Next Scan Range

- Issues: #67351–#67450
- PRs: #67351–#67450
