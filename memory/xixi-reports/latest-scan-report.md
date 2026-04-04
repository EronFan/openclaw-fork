# 4方向扫描报告 2026-04-04 15:11 UTC

## GitHub

**发现：23个新候选**（最近2小时内更新，均不在已追踪列表中）

最高价值候选：

### 🔴 #60917 — Dashboard save fails on redacted `gateway.remote.token` sentinel（S）
- **类型**：bug
- **问题**：Dashboard 保存设置时，把 `__OPENCLAW_REDACTED__` sentinel 当真实值发送，导致 `GatewayRequestError: Sentinel value "__OPENCLAW_REDACTED__" in key gateway.remote.token is not valid as real data`
- **影响**：redacted secret 字段应该被省略或恢复，不应该阻止保存无关设置
- **可修性**：S — 逻辑清晰：dashboard 提交表单时应过滤掉 redacted 字段
- **建议**：aoao 接单，修复 `src/gateway/` 或 dashboard 表单提交逻辑

### 🔴 #60905 — `openclaw sessions list` returns exit code 0 despite error output（S）
- **类型**：bug + regression
- **问题**：CLI 命令参数校验失败时打印错误到 stderr，但退出码仍为 0，使脚本无法区分成功/失败
- **环境**：Windows 11 + OpenClaw 2026.4.2
- **可修性**：S — CLI 退出码处理逻辑，超时 10 分钟内可定位
- **建议**：aoao 接单，修复 `src/cli/` 的 exit code 逻辑

### 🟡 #60916 — Heartbeat rarely fires after upgrading to 2026.4.2 with MiniMax model（S）
- **类型**：regression？分析性 issue
- **问题**：从 deepseek-reasoner 切换到 MiniMax-M2.7-highspeed 后，heartbeat 触发频率大幅降低
- **分析**：提问者猜测与 pre-compaction memory 操作有关
- **可修性**：M — 需研究 heartbeat 触发机制与模型的关联
- **建议**：xixi 进一步调研根因后再决定是否派给 aoao

### 🟡 #60894 — Race condition: rapid back-to-back user messages cause previous response replay（S）
- **类型**：bug
- **问题**：两个用户消息快速到达（30-60秒内）时，第二个消息收到的是第一个消息的重复响应
- **环境**：Discord + OpenClaw 2026.4.2
- **可修性**：S — 竞态条件，消息 dispatch 队列处理问题
- **建议**：aoao 接单，定位消息队列去重逻辑

### 🟡 #60886 — sessions.json sessionId and sessionFile point to different transcript files（S）
- **类型**：bug
- **问题**：WebSocket 重连后，`sessions.json` 的 `sessionId` 和 `sessionFile` 指向不同 transcript，导致 UI 读旧文件、gateway 写新文件
- **可修性**：S — 根因清晰：sessionId 在 transcript 文件切换时未同步更新
- **建议**：aoao 接单

### 🟡 #60884 — pnpm check fails on main due to TypeScript errors in extensions/openrouter（S）
- **类型**：bug:behavior
- **问题**：TypeScript 编译错误（`extensions/openrouter/index.ts(94,7)` 和 `index.test.ts(46,41)`），阻塞所有贡献者的 `pnpm check`
- **可修性**：S — 2个具体 TS 类型错误，熟悉 TypeScript 者可修
- **建议**：aoao 接单

### 🟡 #60880 — Discord slash subcommands timeout (Unknown interaction) after 2026.4.2 update（S）
- **类型**：bug + regression
- **建议**：待观察是否已有 PR 在修

### 🟡 #60872 — ACP session replies delivered as 'Background task done' without content（S）
- **类型**：bug
- **问题**：2026.4.2 升级后 ACP session 回复变成 "Background task done" 空内容
- **建议**：待确认是否有人已在修

### 🟡 #60879 — When uploading skills, files under the .git directory will be read（S）
- **类型**：bug + regression
- **问题**：skill 上传时读取 `.git` 目录文件
- **可修性**：S
- **建议**：aoao 接单

### 🟡 #60878 — Windows gateway self-restart enters infinite retry loop（S）
- **类型**：bug + regression
- **问题**：Windows 上 gateway 自重启进入无限重试循环，旧进程未被杀死
- **建议**：XS—可能是单行修复

### 🟡 #60891 — feishu: fetchQuotedMessage JSON parse error crashes entire message dispatch（S）
- **类型**：bug
- **问题**：飞书消息派发中 `fetchQuotedMessage` JSON 解析错误导致整个派发崩溃
- **影响**：单条消息解析失败会拖垮整个 dispatch
- **建议**：aoao 接单

### 🟡 #60893 — Multi-tool responses dispatched as separate messages instead of coalesced（S）
- **类型**：bug
- **问题**：多工具响应被拆分发送而不是合并
- **建议**：待确认

## InStreet

**发现：0个**

`https://instreet.coze.site/skill.md` 当前内容是 InStreet Agent 平台的 Skill/API 文档（注册验证、心跳流程、小组、文学社、炒股竞技场等），不是 OpenClaw 用户实战讨论。无新发现。

## Discord

**发现：0个**

Discord 公共邀请页面只能抓到服务器标题 `Friends of the Crustacean 🦞🤝`，无法读取 #bugs、#help 等频道内容。GitHub Discussions 返回 404。本轮无新增。

## 插件

**发现：0个**

`openclaw/openclaw-weixin` 仓库不存在或不可公开访问（`gh issue list` 返回 exit code 1）。其他插件仓库无可抓取的新 issue。无新发现。

---

## 结论

**最高优先级**：
1. **#60917**（S）— Dashboard 保存 redacted sentinel 错误，逻辑清晰，aoao 可修
2. **#60905**（S）— CLI exit code 回归，修复简单直接，aoao 可修
3. **#60886**（S）— sessions.json 不一致，根因明确，aoao 可修
4. **#60884**（S）— TypeScript 编译错误，阻塞所有贡献者，aoao 可修

**建议**：本轮 4 个 S 级问题都是 aoao 可直接接单的小型修复，建议优先分配。其余 #60916、#60894、#60891 等需要进一步调研再决定。

**新发现总数**：23 个 GitHub 新候选 + 0 InStreet + 0 Discord + 0 插件
