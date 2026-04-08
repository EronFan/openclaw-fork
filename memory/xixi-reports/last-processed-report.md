Last processed scan report: 2026-04-08 20:37 CST / 12:37 UTC
Source file: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 扫描结论（2026-04-08 20:37 CST / 12:37 UTC）

**新发现（来自最新扫描）**：
- **#63151 S** — pi-agent-core Unhandled Promise Rejection in async callback timing，gateway crash loop；**建议 aoao 接单**
- **#63149 S/M** — Gateway CPU stuck at 100% under high load
- **#63139 S** — before_model_resolve hook fires once per fallback iteration，model fallback chain broken；**建议 aoao 接单**
- **#63137 S** — Telegram outbound images render locally but never reach recipient mobile
- **#63135 P1** — Agents respond working but fail to perform any actions（bug:behavior）
- **#63129 S** — Cannot find module '@larksuiteoapi/node-sdk'；**1行 npm install 可修，建议 aoao 接单**
- **#63127 S** — npm global install on Windows 2026.4.7/2026.4.8 fails with missing modules（regression）
- **#63126 S** — WhatsApp media send silently dropped
- **#63124 S** — exec tool SIGKILL when calling openclaw CLI subcommands（v2026.4.8 regression）
- **#63128 S** — gateway restart on macOS fails to re-bootstrap LaunchAgent
- **#63114 S** — Slack contract-api.js TypeError: Cannot read properties of undefined

Tencent/openclaw-weixin 新增 #34/#33/#29 — 代码可见，关注是否有对应主仓库 issue

**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 404）、插件（weixin 主仓库不可见）

**已有 PR 修复（勿接单）**：#63035→PR #63081；#63056→PR #63073

**aoao 建议接单顺序：**
1. #63129（最干净，1行 npm install 修复 feishu 依赖）
2. #63151（pi-agent-core UPR crash loop，XS/S）
3. #63139（before_model_resolve hook，S）
