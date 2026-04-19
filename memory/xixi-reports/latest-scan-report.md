# 全量扫描报告 [2026-04-19 20:37 CST]

## GitHub Issues（方向1）
- 近 2 小时主仓 open issues/PRs 共扫描 68 条更新。
- 发现了 4 个值得动作的新候选，其中最重要的是：
  - `#68931` Webchat 用户消息发送后短暂出现又消失。报告已给出高置信根因：前端 `up()` 用服务端历史全量覆盖本地 `chatMessages`，而 gateway 的 `emitUserTranscriptUpdate()` 是异步写入，形成 race；模型报错/重连时更容易触发。这个问题会直接让用户怀疑消息没发出去，优先级最高。
  - `#68944` CLI 所有依赖 gateway 的命令卡死在 WebSocket handshake。Windows + Node 24.13.1 环境下，CLI 收到 `connect.challenge` 却不发 `connect.reply`，`sessions/cron/status/models/agents` 全挂，属于明显可操作的 transport/签名路径 bug。
  - `#68921` browser `refs=aria` 路径仍依赖 Playwright 私有 `_snapshotForAI`，在 1.53+ / 1.59.1 下直接失效，还把依赖不兼容误导成“重启 gateway”。
- 另外两条：
  - `#68945` Telegram `humanDelay` 不生效，根因清晰；但已在扫描窗口内被 PR `#68956` 直接覆盖，不重复列为新优先级。
  - `#68938` Web UI 语音按钮失效 + 图片上传失败，证据尚浅，先观察，不压过上面 3 条。

## 插件仓库（方向2）
- 扫描 `Tencent/openclaw-weixin` 最近更新项 1 条。
- 新发现：`openclaw-weixin #78` 请求支持发送微信原生语音消息（绿色语音条）。
- 结论：这是 feature gap，不是 bug。issue 已给出精确实现路径：`send-media.ts` 缺少 voice route，现有 API/types 与 silk 依赖都已具备。已记录为低优先级 XS，不建议挤占 core bug 修复窗口。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，共收集最近 20 条 commit 去重后 324 个文件区域。
- 从这些文件区搜索到了 19 组相关 open bug 线索，但本轮没有发现比当前优先级表更强的新高置信未认领项。
- 本轮最接近可行动的重叠区：
  - `README.md` / docs 区继续映射到 `#68797`、`#63815` 等已有 open 项；
  - `apps/macos` / `apps/shared` / `apps/android` 区有旧问题簇，但没有新近 2h 内更新且根因更清晰的目标；
  - 结论：方向3 本轮 **无新增高优先级候选**，但文件区重叠仍说明 docs / app / packaging 区存在持续积压。

## 追踪 PR 反馈（方向4）
- 本轮未发现当前追踪 PR 的 maintainer 新评论，方向4 的“新反馈”结论是：**无**。
- 但状态变化有 3 个：
  - `#67277` 已 closed（不再是“接近 merge”状态）。
  - `#67281` 已 closed（不再是“security review 待确认”状态）。
  - `#67279` 仍 open，`mergeable=false`，最近更新时间停在 `2026-04-15T16:23:06Z`，窗口明显变冷。
- `OPENCLAW-PROJECT.md` 当前高优先级 issue 中：
  - `#68838` 仍 open，heartbeat-state.json 显示已在 12:00 UTC 重新派出修复；
  - `#67314`、`#67323`、`#67288` 仍 open，无本轮新动态。

## 结论
- 最高优先级是 `#68931`。这是直接伤用户信任的 webchat regression，而且根因已经被 reporter 说透，值得 main/aoao 优先接单。
- 第二优先级是 `#68944`。它让整条 CLI→gateway 管理链半瘫痪，影响面大。
- 第三优先级是 `#68921`。browser `refs=aria` 失效属于明显 regression，修复路径也很清楚。
- 插件方向本轮只有功能缺口，没有比 core 主仓更值得立即动手的 bug。
