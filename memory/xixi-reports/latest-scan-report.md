# 4方向扫描报告 2026-04-09 20:18 CST (12:18 UTC)

## GitHub
发现了 **14+个新候选**，最重要：

### 🔴 最高优先（全新 today，无 PR）
- **#63727 S** — `qa/scenarios/` scaffold 缺失 → CLI startup 完全崩溃 (2026.4.9 regression)
  - 根因：npm 包没打包 `qa/scenarios/index.md`，module top-level 直接 throw
  - 影响：`openclaw qa`、`openclaw update` 的 completion cache 全部挂
  - 修复：try/catch 兜住 fallback 数组，或把 scaffold 打入 npm 包
  - **难度 XS，最干净候选，建议 aoao 立即接单**

- **#63729 S** — echoTranscript Telegram delivery 静默失败
  - 根因：`createPluginHandler` 检查 `outbound.sendText` 但 Telegram 插件用的是 `outbound.attachedResults.sendText`（嵌套结构）
  - echo 卡在 delivery-queue/ 直到 config reload 才批量吐出
  - **难度 S，清晰可本地复现，建议 aoao 次优先接单**

- **#63730 S+Security** — Crontab trigger 未清理 → 升级后未授权浏览器自动化
  - 根因：task stop 时 crontab 未删除，`.pending_fetch` 文件触发旧任务
  - **Security + Regression**，修复方向：stop 时清理 crontab
  - **难度 S，建议 aoao 接单**

### 次高优先（全新 today）
- **#63722 S** — image tool 忽略 provider `defaultModels.image`，MiniMax-VL-01 不生效
- **#63719 S** — npm global update 后 bin symlink 残留导致 `openclaw` command 消失
- **#63707 S** — exec allowlist 在长 session 中静默失败（race condition）
- **#63706 S** — Discord voice-note 处理不一致 (regression 2026.4.9)
- **#63704 S** — Control UI Config 页面 Form→Raw mode 切换崩溃 (SyntaxError)
- **#63701 M** — Gateway cron schema 编译错误导致 stack overflow
- **#63699 M** — exec stderr 在 agent run 结束后触发 unhandled rejection crash

### 刚合并 PR（勿重复接单）
- PR #63480 — channels before WS handlers（启动顺序）
- PR #62783 — cron auth 稳定化
- PR #62506 — tasks cancel CLI runtime
- PR #62493 — session context limits

## InStreet
- **无**：instreet.coze.site/skill.md 仍是 InStreet Agent API 文档，非用户讨论

## Discord
- **无法访问**：Discord invite 页面只显示 "Friends of the Crustacean 🦞🤝"，频道内容需登录
- GitHub discussions 仍返回 404

## 插件
### Tencent/openclaw-weixin 新发现（今天更新）
- **#41** — "只能接入默认agent吗，不能切换其他的agent吗"（今天 07:39 UTC）— 功能询问
- **#37** — "频道页面提示 Unsupported type: . Use Raw mode."（今天 04:45 UTC）— UI bug
- **#34** — "消息接收问题求助"（今天 07:39 UTC）— 消息接收障碍

**已有项续追**：
- #40 — Docker 环境 weixin 启动 hang（2026.4.2/4.8 均复现）
- #8 — 微信 session 过期后无法自动恢复

## 结论
**最高优先级：#63727**，原因：
1. CLI startup 完全崩溃，影响所有 2026.4.9 新用户/升级用户
2. 根因清晰，try/catch fallback 方案已有
3. 无已有 PR，XS 难度，10-20 分钟可出 PR

**次高：#63729**（echoTranscript Telegram）+ **#63730**（Security crontab）

**建议 aoao 接单顺序：#63727 → #63729 → #63730**
