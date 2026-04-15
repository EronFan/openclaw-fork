# Last Processed xixi Scan Report

**Scan range:** issues #67251–#67350 | PRs #67251–#67350
**Timestamp:** 2026-04-15T22:54 GMT+8 (14:54 UTC)
**Report location:** xixi-reports/latest-scan-report.md

## Quick Status

- New S-level candidates: #67252, #67251, #67250, #67248, #67247, #67241
- #67252 → dispatched to aoao (fix-67252, runId b986d601)
- #67251 → dispatched to aoao (fix-67251, runId 927cbca0)
- #67250 → dispatched to aoao (fix-67250, runId cf3c82bf)
- #67248 → pending dispatch (sessions_spawn subagent regression, 2026.4.14)
- #67247 → pending dispatch (Telegram command menu regression, 4.14)
- #67241 → pending dispatch (BlueBubbles Node 22.20+ silent fail)

## Key S-level Candidates (this scan)

1. [#67252](https://github.com/openclaw/openclaw/issues/67252) **S** — feishu_doc write missing pagination, `clearDocumentContent` doesn't loop all block pages. **aoao dispatched**
2. [#67251](https://github.com/openclaw/openclaw/issues/67251) **S regression** — Windows CLI subcommand hang + SIGKILL (2026.4.14). **aoao dispatched**
3. [#67250](https://github.com/openclaw/openclaw/issues/67250) **S regression** — Control UI streaming text disappears when tool calls hidden (4.14). **aoao dispatched**
4. [#67248](https://github.com/openclaw/openclaw/issues/67248) **S** — sessions_spawn runtime=subagent still failing (2026.4.14, ACP-only streamTo)
5. [#67247](https://github.com/openclaw/openclaw/issues/67247) **S regression** — Telegram native command menu disappears after 4.14 upgrade
6. [#67241](https://github.com/openclaw/openclaw/issues/67241) **S** — BlueBubbles attachment downloads fail silently on Node 22.20+

## Plugin Candidates

- Tencent/openclaw-weixin #49 vs #63: both fix voice message ref_msg preservation, different authors. Need consolidation confirmation.
- Tencent/openclaw-weixin #62: new feat (voice messages SILK/MP3/OGG) by lemoncat7

## Maintainer PRs to Watch

- **PR #67200** fix(plugins): stabilize bundled setup runtimes — maintainer 4 comments, close to merge
- **PR #67254** fix(google): respect allowPrivateNetwork config for SSRF — Joel-Clary, 5 min old
- **PR #67255** feat: add yuanbao extension plugin — loongfay, brand new

## Feedback Check (this cycle)

- #54952: 0 comments (no change)
- #54964: 0 comments (no change)
- #55008: 5 comments — Greptile regression caught, EronFan fixed (bb2ea2f7e4 + b14be82db1), **PR ready to merge**
- #55013: 2 comments — Greptile 5/5 Safe to merge + maintainer corrected groupPolicy, **PR ready to merge**

## OPENCLAW-PROJECT.md Updated

Added P60187–P60197 to「当前优先级」table.

## Next Scan Range

- Issues: #67351–#67450
- PRs: #67351–#67450
