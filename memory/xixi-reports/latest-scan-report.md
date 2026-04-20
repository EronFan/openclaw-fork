# 全量扫描报告 [2026-04-20 22:47 CST]

## GitHub Issues（方向1）
- 发现了 5 个新候选，其中最重要的是 [#69360](https://github.com/openclaw/openclaw/issues/69360)：isolated cron `agentTurn` 实际执行成功，但被错误标记为 `Agent couldn't generate a response`。日志里 `output_tokens=694`、`stopReason=stop`，却因 `payloads=0` 走了 incomplete-turn 错误分支，属于明确 regression。
- 次重点是 [#69359](https://github.com/openclaw/openclaw/issues/69359) 和 [#69358](https://github.com/openclaw/openclaw/issues/69358)：webchat 图片上传/纯图片消息两条报告互相印证，现象都是 Control UI 图片没有正确进入视觉模型链路。#69359 指向“发 CDN 临时 URL 导致模型拿不到图”，#69358 指向“纯图片消息没有设置 MediaPath/MediaPaths，直接被当作无文本”。这是同一块 webchat media routing usability/regression 簇。
- 另外还有 [#69353](https://github.com/openclaw/openclaw/issues/69353)（`context1m` 对非 `anthropic` provider 无效）和 [#69364](https://github.com/openclaw/openclaw/issues/69364)（多 agent Control UI 关系视图功能请求），但前者优先级低于 cron/webchat regression，后者是 enhancement，不建议现在接。

## 插件仓库（方向2）
- 无。
- `Tencent/openclaw-weixin` 最近 2 小时未检出新的 open issue/PR 更新；公开插件方向暂无新增可行动候选。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，覆盖 约 280 个去重文件区域。
- 发现 3 个高相关 open bug：
  - `davidrudduck` 最近集中改动 `src/agents/pi-embedded-runner/*`、`src/cron/isolated-agent/run.ts`，与 [#69360](https://github.com/openclaw/openclaw/issues/69360) 直接同区。
  - `pandego` 最近集中改动 `src/browser/server-context.ts`，与既有 open bug [#66809](https://github.com/openclaw/openclaw/issues/66809)（browser loopback CDP path / policy 阻断）同区。
  - `BruceMacD` 最近集中改动 `extensions/ollama/*`、`src/agents/ollama-*`，与既有 open bug [#61223](https://github.com/openclaw/openclaw/issues/61223)（Ollama thinking tokens 被忽略）同区。

## 追踪 PR 反馈（方向4）
- 无新的 maintainer 评论。
- `heartbeat-state.json` 当前追踪 PR 仍是 fork 上的 PR #16（#69214）和 PR #17（#67252），状态均未变化，仍为 open。
- `OPENCLAW-PROJECT.md` 中最近追踪的高优项在本轮窗口内未发现新的 upstream 状态跳变；#69343 仍 open，但此前已确认 upstream 源码已有修复，暂无新增反馈。

## 结论
最高优先级是 #69360，其次是 webchat 图片链路簇 #69359 / #69358。
建议：优先派 aoao 查 `isolated cron -> incomplete turn / payloads=0` 判定路径；webchat 图片问题建议合并看 Control UI 上传格式与 `MediaPath/MediaPaths` 注入链路，避免重复修两次。
