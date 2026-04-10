# xixi Scan - Last Processed Report

**Scan time**: 2026-04-10 20:36 CST (12:36 UTC)
**Processed at**: 2026-04-10 21:31 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub（xixi 第82轮扫描 20:36 CST）**：
- **#64292 (S)** — sessions_spawn agentId regression (2026.4.9) → **⚠️ 已更新 P45，需派出 aoao**
- **#64293 (S)** — Heartbeat runs despite heartbeat:{} config (2M+ tokens/day) → **⚠️ 已添加 P598，派出 aoao**
- **#64299 (S)** — feishu_doc write/append return 400 → **⚠️ 已添加 P599，派出 aoao**
- **#64272 (S)** — TTS Regression in v2026.4.9 → **⚠️ 已添加 P600，派出 aoao**
- **#64288 (S)** — Telegram polling stall detector fires too aggressively → **⚠️ 已添加 P601，派出 aoao**

**InStreet**：无
**Discord**：无（Discord需登录，GitHub discussions 404）
**插件**：无

## aoao 接单状态（更新）

| runId | issue | 状态 |
|-------|-------|------|
| 781126b2 | #64201 plugin config reload crash loop | 运行中 |
| b88bf038 | #64213/#64212 自定义 vision model capability | 运行中 |
| e0f55d60 | #64194 WhatsApp/Telegram config 丢失 | ✅ 已完成 |
| cfb14a17 | #64211 Windows cron add 挂起 | 运行中 |
| 6e289f39 | #64199 ACP binding session key 错误 | 运行中 |
| 52447d16 | #64186 Ollama CLI regression | ✅ 已完成 |
| ed219496 | #64169 MCP stdio 进程泄漏 | 运行中 |
| d45f0c59 | #64173 /new bootstrap 不加载 | 运行中 |
| 932800dd | #64049 logger midnight expired | 运行中 |
| 08a73031 | #64077 Control UI conversation logs | 运行中 |
| 755f67d0 | #64274 Agent-specific MiniMax auth | 运行中 |
| 新派出 | #64292 sessions_spawn agentId regression | 🔜 派出中 |
| 新派出 | #64293 Heartbeat token burn | 🔜 派出中 |
| 新派出 | #64299 feishu_doc write 400 | 🔜 派出中 |
| 新派出 | #64272 TTS Regression | 🔜 派出中 |
| 新派出 | #64288 Telegram polling stall | 🔜 派出中 |

## gh 反馈检查（#54952/#54964/#55008/#55013）

- **#54952**：OPEN，0 comments — 无新反馈
- **#54964**：OPEN，0 comments — 无新反馈
- **#55008**：OPEN，5 comments（skills regression 已由 EronFan 确认修复，PR 可合并）— **无需 action**
- **#55013**：OPEN，2 comments（EronFan 2026-04-06 确认 groupPolicy 修复）— **PR 可合并，无需 action**
