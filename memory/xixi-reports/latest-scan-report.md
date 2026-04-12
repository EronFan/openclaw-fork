# 全量扫描报告 [2026-04-12 10:08 CST]

## GitHub Issues（方向1）
- 发现了6个新候选，其中最重要的是 #65076，OpenAI 音频转写对有效 OGG/Opus 静默失败，CLI 与 Telegram 路径同时中招，且默认日志不报错。
- 其次是 #65078，v2026.4.9 起 Telegram transcript 不再出现在 Web UI，明确 regression，且指向 `google-gemini-cli` provider 路径。
- 另外两个值得跟的是 #65082（npm 包缺失 `qa/scenarios/index.md`，升级后 completion cache fatal）和 #65086（`sessions_spawn` 显示 `modelApplied:true` 但子代理实际落到 fallback 模型）。

## 插件仓库（方向2）
- 无。
- `Tencent/openclaw-weixin` 最近 2 小时未检出新的 open issue/PR 更新。

## 贡献者文件区域（方向3）
- 扫描了排名最末的10个 contributors，拿到8个贡献者最近提交涉及的文件区域。
- 文件区里最相关的是 `src/agents/pi-embedded-runner/compact*`，命中未覆盖 open bug #64962（timeout-compaction 失败后不升级）。
- 另外搜到 `server-context` 相关 MCP 老问题和 `CHANGELOG` 类低相关 feature 请求，总体本轮只发现1个值得继续追的高相关 open bug 区域。

## 追踪 PR 反馈（方向4）
- 本轮未发现已追踪 PR 的 maintainer 新评论。
- OPENCLAW-PROJECT.md 已追踪项里有2个状态变化：
  - #65043 仍 open，2 小时内有新更新，comments=1
  - #65067 仍 open，2 小时内有新更新，comments=0

## 结论
最高优先级是 #65076，其次是 #65078。
建议：优先把 #65076 丢给 aoao 看 `tools.media.audio` / `applyMediaUnderstanding` 吞错路径；#65078 可并行确认 `google-gemini-cli` 是否在 transcript / Web UI 写入链路上漏字段。