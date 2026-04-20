# 全量扫描报告 [2026-04-20 21:37 CST]

## GitHub Issues（方向1）
- 发现了 6 个新候选，其中最重要的是 [#69343](https://github.com/openclaw/openclaw/issues/69343): Telegram CLI `message thread create` 仍下发 `thread-create`，没有转成 Telegram 原生 `topic-create`，导致 forum topic 创建 100% 失败。根因清晰，在 CLI bridge 层做 action normalization 即可。
- 其次是 [#69341](https://github.com/openclaw/openclaw/issues/69341): `openclaw channels status` 的 help/tip 一直提示 `--deep`，但 CLI 实际不接受该 flag，属于 docs/CLI gap。
- 另外 4 个本轮窗口内活跃候选是：[#67335](https://github.com/openclaw/openclaw/issues/67335) macOS LaunchAgent 被移出 launchd domain、[#68766](https://github.com/openclaw/openclaw/issues/68766) Feishu WS token refresh 后不自恢复、[#67793](https://github.com/openclaw/openclaw/issues/67793) collect/debounce 不批量、[#44533](https://github.com/openclaw/openclaw/issues/44533) cron `delivery.mode=none` telemetry 误报。它们本轮主要是补充评论，不是全新 issue。

## 插件仓库（方向2）
- 无。
- `Tencent/openclaw-weixin` 最近 2 小时内无新的 open issue / PR 更新。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors（排除 EronFan，其中 `clawdinator[bot]` 最近 20 commits 为 0），共覆盖约 36 个近期活跃文件区域。
- 发现 1 个值得继续盯的相关 open bug：`pandego` 最近改动集中在 `src/browser/server-context.ts` / `remote-tab-ops`，与 [#66809](https://github.com/openclaw/openclaw/issues/66809) 的 browser loopback CDP policy block 高度同区，仍 open 未认领。
- 其余末位 contributors 的近期文件区主要落在 matrix、qqbot、ollama docs/defaults、gateway maintenance、pi-embedded-runner、channel setup 等，未挖到比现有追踪项更强的新高优先级命中。

## 追踪 PR 反馈（方向4）
- 未发现已追踪 upstream PR 的 maintainer 新人工评论。
- `OPENCLAW-PROJECT.md` 已追踪 upstream issue/PR 在本轮窗口内没有新的关键状态跳变。
- `heartbeat-state.json` 显示：`#69296` 仍在运行，`#69300` 的 fork PR#18 已存在，但 upstream 侧暂无新状态。

## 结论
最高优先级是 [#69343](https://github.com/openclaw/openclaw/issues/69343)，因为它是根因明确、100% 可复现、改动面很小的 Telegram CLI 可用性缺口。建议优先派修这个，其次顺手收掉 [#69341](https://github.com/openclaw/openclaw/issues/69341) 这种低成本 docs/CLI gap。