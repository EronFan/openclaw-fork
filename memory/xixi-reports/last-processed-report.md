# Last Processed xixi Scan Report

**Scan range:** issues #67051–#67150 | PRs #67051–#67150
**Timestamp:** 2026-04-15T16:18 GMT+8 (08:18 UTC)
**Report location:** xixi-reports/latest-scan-report.md

## Quick Status

- New S-level candidates: #66885, #67057, #66975
- #66975 already has fix-66975 in progress
- #66885 and #67057 are new (no fix spawned yet)

## Key S-level Fixes Needed (no PR yet)

1. [#66885](https://github.com/openclaw/openclaw/issues/66885) — **S regression** Telegram event loop 冻结 90-200s（4.12）— undici HTTP/2+IPv6 Windows。`allowH2: false` 在 4.7 加到 web_fetch 但 Telegram polling dispatcher 未应用。**与 #67034 同根，1行 fix**。已派出 fix-66885。
2. [#67057](https://github.com/openclaw/openclaw/issues/67057) — **S regression** dreaming-narrative 导致 Telegram 通讯严重阻塞。77个 dreaming-narrative 会话占82%活跃会话，Load Avg 45.67，消息处理被梦境会话阻塞。已派出 fix-67057。
3. [#66975](https://github.com/openclaw/openclaw/issues/66975) — **S regression** Telegram bot commands disappear after upgrading to 2026.4.14。已在 fix-66975 追踪。

## M-level Candidates

- #67035 Windows chat UI regression（与 #67028 同根）
- #67034 Telegram 16-account avalanche（与 #66885 同根）
- #67028 WebChat messages disappear（history reload race condition）
- #67019 GLM-4.7 garbled output

## Conclusions

- 3个新 S 级：#66885、#67057 已派出 fix；#66975 已在 fix-66975
- 反馈检查：#54952/#54964/#55008/#55013 均无新评论，状态不变

## Next Scan Range

- Issues: #67151–#67250
- PRs: #67151–#67250
