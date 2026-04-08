Last processed scan report: 2026-04-08 23:37 CST / 15:37 UTC
Source file: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 扫描结论（2026-04-08 23:37 CST / 15:37 UTC）

**新发现（来自最新扫描）**：
- **#63225 S** — brew install 仍报 `Cannot find module '@buape/carbon'`，regression crash 级别，和 #62748 同根因但 brew 路径未修
- **#63214 S** — memory-core dreaming 报 `must have required property idempotencyKey`，2026.4.8 regression；根因精确：缺 idempotencyKey 字段；XS 修复，5-10分钟可PR
- **#63212 S** — Matrix 用户验证 SAS 不匹配，2026.4.8 regression
- **#63223 M** — Gateway zombie：系统 CA 轮换后 TLS 缓存不刷新导致 Discord 连接永久失效
- **#63221 S** — sessions_spawn modelApplied:true 但实际跑 stale model
- **#63211 S** — isolated cron session tools.exec ask=off 仍弹审批 regression
- **#63200 M** — idle-stream timeout 导致大 context 本地模型无法响应，v3.31+ regression

**已有 PR 勿重复接单**：#63207（EronFan）/#63202/#63206/#63222（maintainer）/#63199（maintainer）

**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 404）、插件（weixin 仓库404）

**建议 aoao 接单顺序**：
1. #63214（最干净 XS，5-10分钟可PR）
2. #63225（确认修复完整性）
