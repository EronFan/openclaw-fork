Last processed scan report: 2026-04-09 09:40 CST / 2026-04-09 01:40 UTC
Source file: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 扫描结论（2026-04-09 09:40 CST / 2026-04-09 01:40 UTC）

**新发现（来自最新扫描）**：
- **#63101 S** — Feishu config validation fails after upgrading v4.5→v4.8；doctor --fix 不删除 deprecated ackReaction/threadSession；影响所有升级用户；**XS fix：给 doctor --fix 加 deprecated key 清理；已派出 aoao（runId 待补充）**
- **#63470 S** — memori plugin enable causes error（regression）；0 comments，刚发布；需确认详情
- **#63476 S** — Image Tool returns "no image" when called from agent session；图片数据在 tool invocation pipeline 中丢失；严重度高
- **#63475 S** — Feishu multi-account startup: bot info probe timeout due to concurrent API
- **#63469 S** — sessions_send A2A announce drops threadId on sessions.list fallback；与 #63424 相关
- **#63465 S** — memory-core dreaming enabled but managed dreaming cron is not created
- **#63463 S** — MLX routing fails: model_not_found + fallback despite direct MLX API success
- **#63424 S** — sessions_send announce loses threadId（与 #63469 同源）
- **#63471 Feature** — Be friendlier with Dockge/etc（功能请求，非 bug）

**已有 PR 勿重复接单**：#63214 → PR #63245/#63252 已合并

**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 404）、插件（weixin 代码不可见）

**建议 aoao 接单顺序**：#63101（已派出）→ #63470（确认）→ #63476（验证详情）

**GH 反馈检查（本轮）**：
- #54952: 0条评论，无新动态
- #54964: 0条评论，无新动态
- #55008: 5条评论，无新动态（已知）
- #55013: 2条评论，无新动态（已知）
