# 4方向扫描报告 2026-04-08 15:37 UTC

## GitHub
- 发现了**17个**新候选（过去2小时）
- **最重要：#63225** — brew install 仍报 `Cannot find module '@buape/carbon'`，regression，crash 级别。这和 #62748 是同类问题但发生在 brew 路径，且覆盖到 2026.4.7 版本。说明修复不完整或只在 npm 路径修了。
- **次高：#63214** — memory-core dreaming 报错 `must have required property idempotencyKey`，regression，2026.4.8。根因清晰：新版 agent params 加了 idempotencyKey 必填，但 dreaming 代码路径没传。XS 修复：在调用处补上 idempotencyKey 字段即可。
- **#63212** — Matrix 用户验证 SAS 不匹配，regression，2026.4.8。Element 显示 emoji 匹配但 openclaw 报失败。需要熟悉 Matrix protocol 的人。
- **#63223** — Gateway 成为 zombie：系统 CA 轮换后 TLS 缓存不刷新导致 Discord 连接永久失效。详细日志、复现步骤完备，但修复涉及 TLS 刷新机制，属于 M 难度。
- **#63221** — sessions_spawn 报告 modelApplied:true 但实际跑 stale model，和 #62755 是同类。文档有 sister issues。
- **#63211** — 2026.4.5 回归：isolated cron session 的 tools.exec ask=off 仍弹审批，和 #62569 可能同根因但影响的是 isolated session 而非 cron agentTurn。
- **#63200** — idle-stream timeout 导致大 context 本地模型无法响应，v3.31+ regression，#41371 的 tracking ticket。
- **已有人修：** #63207 (EronFan, timeoutSeconds), #63202 (multipart FormData), #63206 (symlink), #63222 (maintainer), #63199 (maintainer, android)

## InStreet
- **无**：内容为 InStreet Agent Skill API 文档（注册/心跳/发帖流程），非用户实战讨论

## Discord
- **无法访问**：Discord 需要登录认证，web_fetch 返回 404；GitHub discussions 已关闭

## 插件
- openclaw/openclaw-weixin：仓库不存在（404）
- EronFan/openclaw-fork：仅3个已处理 PR，无新 issues

## 结论
**最高优先级：#63214**，原因：
1. 2026.4.8 regression，根因精确（缺 idempotencyKey）
2. 修复路径清晰（dreaming 调用处加字段）
3. 难度 XS，可在 10 分钟内提 PR
4. 涉及 memory-core，aoao 修完可顺带了解 memory 系统

**次高：#63225** — 和 #62748 同根因但 brew 路径仍报，说明要么修的不全要么有遗漏路径。值得确认。

**建议 aoao 优先接：**
1. **#63214**（XS，5分钟可提PR）
2. **#63225**（XS，确认修复完整性）
