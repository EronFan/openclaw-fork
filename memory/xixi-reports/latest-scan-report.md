# 全量扫描报告 2026-04-11 20:08 CST

## GitHub Issues（方向1）

发现了 **10+ 个新候选**，其中最重要的是：

### 🔴 最高优先级新候选

**#64745 macOS 2026.4.8 无限自复制崩溃**（CRITICAL）
- bug 标签，2 条评论
- 用户报告下载 v2026.4.8 后 Mac mini M4 不断生成 OpenClaw 图标直到系统冻结，强制断电才停止
- 用户因此抹掉了整台 Mac 的数据
- 这是极其严重的 regression，maintainer 已在跟进
- **建议**：确认根因（是否是某进程 fork 循环？自动更新机制触发？）
- 可修性：M（需 macOS 环境复现）

**#64793 Agent timeout 不返回错误给 UI，Web UI 无限挂起**（S）
- bug+bug:behavior，0 评论，0 分配
- 清晰复现步骤：配置慢 LLM → 超时 → Web UI spinner 无限转
- Gateway 日志显示 `decision=surface_error reason=timeout` 但 UI 从未收到最终事件
- **建议 aoao 接单**，超时有明确日志，fix 在 gateway → web UI 事件传播层
- 可修性：S

**#64767 444MB session jsonl 导致 gateway 事件循环阻塞**（M）
- 无标签，0 评论，Prof. Dr. Paul Pronobis 提交
- 单个 session 文件膨胀到 444MB / 157,879 行 → `String.prototype.replace` 阻塞主线程
- 诊断技术新颖（`sample` + `lsof`），可本地验证
- 影响：gateway 完全无响应，`health` 超时，`SIGTERM` 被忽略，只能 `kill -9`
- **建议 aoao 接单**，先确认 session 大小 guard 在哪里失效
- 可修性：M

**#64783 Feishu 群聊 @Bot 触发 ReferenceError: Cannot access 'utils_1' before initialization**（S）
- bug 标签，0 评论
- TDZ（Temporal Dead Zone）问题，模块初始化顺序 bug
- **建议 aoao 接单**，根因在 `utils_1` 变量提升问题，feishu 插件加载顺序相关
- 可修性：S

**#64762 SSRF guard 破坏 FormData multipart，导致音频转录 400 失败**（S）
- bug:behavior，0 评论，GodsBoy 提交
- `fetchWithTimeoutGuarded` 的 pinned DNS dispatcher 破坏 multipart body
- **PR #64766 已在修**（`fix(media): disable pinned DNS dispatcher for FormData transcription requests`）
- 关注 #64766 是否可 merge 覆盖

**#64750 WhatsApp message.send 返回成功但附件被丢弃**（S）
- bug，0 评论
- 与 #63816（WhatsApp outbound media 同源）相关
- v2026.4.9，WhatsApp 附件路径 false-success bug
- **建议 aoao 接单**

**#64752 Telegram reaction 事件不触发 agent turn**（S）
- bug，0 评论
- 配置 `messages.reactions.triggerAgentTurn: true` 但 reaction 事件被记录但不唤醒 agent
- 可修性：S

**#64751 Cron jobs 标记 error 但实际运行成功**（S）
- bug，0 评论
- Telegram announce delivery 的状态标记 bug
- 可修性：S

### 其他值得关注的候选

- **#63968** (S) 打包 regression：v2026.4.9 缺失 `qa/scenarios/index.md` → `openclaw qa` 完全失效，bug+regression 标签
- **#64302** (S) Compaction 设置被忽略，context overflow，bug:behavior
- **#64777** (S) `tools.profile` 默认值不应用到 channel sessions，CLI 全工具集 vs Signal 受限工具集
- **#64774** (S) Readiness checker 硬编码 `staleEventThreshold`（30min）忽略 `gateway.channelStaleEventThresholdMinutes` 配置
- **#64771** (M) Control UI 聊天空闲后断开，v2026.4.10 regression
- **#64778** (S) FTS5 index 在 `memory index --force` 后未重建，导致 `memory_search` 返回 0 结果
- **#64788** Browser plugin: Chrome CDP via launchd 连接失败（bug，launchd cdpHttp:false）
- **#64764** Remote CDP WSL2→Windows Edge 在 v2026.4.10 报告 unreachable（WSL2/Edge MCP 用户）

### PR 动态（今日新活跃 PR）

20 个 open PR 在过去 2 小时内有更新，重点关注：
- **#64790** (XS) `fix(security): redact secrets in exec approval prompts` — feiskyer，size:XS，覆盖 #61077
- **#64787** (XS) `fix: ignore auto-filled streamTo for subagent spawns` — agents size:XS
- **#64779** (XS) `fix(config): resolve CLI command aliases against parent plugin in plugins.allow` — 覆盖 #64748
- **#64766** (S) `fix(media): disable pinned DNS dispatcher for FormData transcription requests` — 覆盖 #64762，同步确认
- **#64768** (S) `fix(discord): disconnect gateway before missing-id startup throw`
- **#64758** (S) `fix: unblock steer-mode followups when active runs stop streaming`
- **#64747** (XS) `fix(gateway): install env HTTP proxy dispatcher at startup`
- **#64746** (S) `Improve subagent start notices with resolved model info`

---

## 插件仓库（方向2）

**无新发现。**

`openclaw/openclaw-weixin` 仓库无公开新增 issue；代码不可见。已有追踪项：
- #55994（weixin regression: message action=send 被误判为 poll，代码不可见）
- #58738（ClawBot 微信服务号无响应，代码不可见）
- #60416（OpenClaw 2026.4.2 移除 `resolvePreferredOpenClawTmpDir` 导致 weixin SDK 兼容性破裂）

---

## Discord / GitHub Discussions（方向3）

**无新发现。**

Discord 频道内容无法直接抓取；GitHub Discussions 返回 404。本轮 Fallback 到 GitHub issues 扫描已覆盖 Discord 相关 bug（如 #64752 Telegram reaction）。

---

## InStreet 社区（方向4）

**无 OpenClaw 实战问题。**

`https://instreet.coze.site/skill.md` 当前内容是 InStreet Agent 平台的 API/Skill 文档（注册认证、心跳流程、小组/文学社/炒股竞技场接口），不是用户讨论区。未发现可转 GitHub issue 的新用户故障讨论。

---

## 贡献者文件区域（方向5）

**本轮跳过。** `gh api repos/openclaw/openclaw/contributors` 返回空（无 token 认证或速率限制）。方向 5 暂缓。

---

## 追踪 PR 反馈（方向6）

**需人工确认：** 以下已追踪 PR 可能有新评论或状态变化（本轮未获取到具体内容）：
- #56203、#56234、#56247（安全审计/PR 相关）
- #62850（Docker HEALTHCHECK fix，PR #62866 已创建）
- #62781/#62808（notifyActiveTaskWaiters TypeError）
- #62691（message send crash，PR #62734 已合并）

**建议 main 安排时间确认以上 PR 状态。**

---

## 结论

**最高优先级：**

| 优先级 | issue | 原因 |
|--------|-------|------|
| 🥇 P1 | **#64745** macOS 无限自复制崩溃 | Critical regression + 数据丢失，2 条评论，maintainer 已在跟进 |
| 🥈 P2 | **#64793** Agent timeout UI 无限挂起 | bug:behavior，清晰复现，S 级 fix |
| 🥉 P3 | **#64767** 444MB session jsonl 阻塞 gateway | M 级，诊断详尽，影响 gateway 稳定性 |
| P4 | **#64783** Feishu TDZ ReferenceError | S 级，模块初始化顺序 bug |
| P5 | **#64762/#64766** SSRF FormData 破坏 | PR #64766 已在修，同步确认 merge 状态 |

**建议：**
- **aoao** 优先接 #64793（超时 UI 挂起，S 级，1-2h 可 PR）
- **aoao** 同步关注 #64766 是否可 merge，覆盖 #64762
- **xixi** 继续调研 #64745 根因（macOS 进程自复制机制）
- **main** 确认 #62850（Docker HEALTHCHECK）和 #62781/#62808 状态
