# 全量扫描报告 [2026-04-12 11:33 CST]

## GitHub Issues（方向1）
- 发现了 6 个新候选，其中最重要的是 #65141，iMessage 在 `default` 与命名 account 并存时会启动双 watcher，导致同一条消息被回复两次。
- 其次是 #65136，gateway restart 或 `/reset` 杀掉子代理后，task 记录仍长期停留在 `running`，`openclaw tasks maintenance --apply` 不会回收，属于 crash recovery 缺口。
- 同时间窗内还出现了 #65135（Control UI cron 展示错误）、#65142（skill 扫描启动慢的 feature request）等，但优先级明显低于前两项。

## 插件仓库（方向2）
- 无。
- `Tencent/openclaw-weixin` 最近 2 小时未检出新的 open issue 或 PR 更新，公开可见的最新仍是 #55 / #54 / #53，更新时间都早于本轮窗口。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，实际拿到 8 个贡献者最近 20 条 commit 涉及的文件区域。
- 最有价值的命中有 2 个：
  - `lml2468` 最近活跃在 `src/gateway/control-plane-rate-limit*`，与 #64911（gateway 提前 ready，但 WS control plane 还不可用，CLI RPC/cron run 握手超时）直接同区。
  - `lml2468` 还活跃在 `src/gateway/server-maintenance.ts` / `src/gateway/server-methods/nodes.ts`，与 #64984（gateway reconnect 后 MCP 子进程不清理，长期累积 OOM）高度相关。
- 另外，上一轮已追踪的 `davidrudduck` 文件区 ↔ #64962（timeout-compaction 不升级）仍然有效，但本轮不是新增。

## 追踪 PR 反馈（方向4）
- 已追踪 PR 本轮未发现 maintainer 新评论。
- 状态检查结果：
  - PR #64681 仍 open，updated 23:43 UTC
  - PR #65016 仍 open，updated 22:06 UTC
  - PR #65012 仍 open，updated 21:45 UTC
- 已追踪新问题状态也无反转：#65043 / #65067 / #65076 / #65078 / #65082 / #65086 均仍 open。

## 结论
最高优先级是 #65141，其次是 #65136。
建议：优先把 #65141 丢给 aoao 看 iMessage account watcher 去重/启动判重逻辑；#65136 可并行检查 gateway startup crash recovery 和 tasks maintenance reconcile 路径。