# 全量扫描报告 [2026-04-20 20:26 CST]

## GitHub Issues（方向1）
- 近 2 小时共扫到 89 个更新项，筛出 5 个值得 action 的新候选。
- 最重要的是 [#69327](https://github.com/openclaw/openclaw/issues/69327)：sandboxed subagent 看不到 `sandbox.docker.env`、`setupCommand` 变更和最新 workspace 状态，`openclaw sandbox recreate --agent ...` 后仍疑似复用 stale runtime/bootstrap，直接阻断 sandbox 编排。
- 其他高价值项：
  - [#69326](https://github.com/openclaw/openclaw/issues/69326) WeChat session 从 webchat 发起时回复不回投微信，疑似 `origin.provider` 抢过 `deliveryContext`。
  - [#69320](https://github.com/openclaw/openclaw/issues/69320) Dreaming cron 被硬编码 600s timeout 误标 error，systemEvent 无法配置 timeout。
  - [#69304](https://github.com/openclaw/openclaw/issues/69304) Telegram polling 在 restart/update 后陷入 `getUpdates 409` 自冲突，评论指向跨 IM 渠道 recovery-aware restart 缺口。
  - [#69303](https://github.com/openclaw/openclaw/issues/69303) inbound dedupe 在 error path 只 release 不 durable commit，导致同一 `message_id` 可重放进入 transcript。

## 插件仓库（方向2）
- 无。
- 本轮扫描 `Tencent/openclaw-weixin` 最近 2 小时内无新的 open issue / PR 更新。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，共覆盖最近 20 条 commit 去重后的 289 个文件区域。
- 发现 2 个强相关 open bug：
  - `davidrudduck` 最近集中改 `src/agents/pi-embedded-runner/*`、`src/cron/isolated-agent/run.ts`，对应 [#69320](https://github.com/openclaw/openclaw/issues/69320) Dreaming cron timeout。
  - `lml2468` 最近集中改 `src/gateway/*`、`src/auto-reply/reply/agent-runner-memory.ts`，对应 [#69303](https://github.com/openclaw/openclaw/issues/69303) inbound dedupe replay。

## 追踪 PR 反馈（方向4）
- 无。
- 已提 PR 最近 2 小时未见 maintainer 新评论。
- `OPENCLAW-PROJECT.md` 已追踪项本轮无新的 open/close/merge 状态跳变。
- `heartbeat-state.json` 中 `inProgressFixes` 仍为 #69214(PR#16)、#67252(PR#17)，状态未变。

## 结论
最高优先级是 [#69327](https://github.com/openclaw/openclaw/issues/69327)，因为它直接破坏 sandboxed subagent 的环境传播与重建可信度，影响编排链路本身。其次是 [#69303](https://github.com/openclaw/openclaw/issues/69303) 和 [#69320](https://github.com/openclaw/openclaw/issues/69320)。建议优先按“sandbox runtime 失效 → dedupe replay → dreaming timeout”顺序处理。