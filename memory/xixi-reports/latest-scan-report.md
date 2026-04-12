# 全量扫描报告 [2026-04-12 08:24 CST]

## GitHub Issues（方向1）
- 发现了 20 个近 2 小时内更新的 open issue/PR 候选，其中最重要的是 #65043，Slack thread 内 subagent completion 现在会同时发一条正确 thread 消息和一条泄露到频道顶层的重复消息，明显是 announce/delivery 双路径残留回归。
- 次高优先级候选：#65067（Windows `openclaw onboard` 在 2026.4.5 因 `ERR_UNSUPPORTED_ESM_URL_SCHEME` 直接崩）、#65042（Gmail watcher 重复启动导致 8788 端口冲突并阻断邮件自动化）。
- 另外看到 #65050 / #65052 是同一类 Codex vision stall 问题的重复提报，可跟但不值得重复投入。

## 插件仓库（方向2）
- 无。
- 本轮 `Tencent/openclaw-weixin` 近 2 小时未检出新的 open issue/PR 更新。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，覆盖最近 257 个去重文件区域，关联搜到了 20 个相关 open bug。
- 最像可行动候选的是 #64973，落在低贡献 contributor 最近活跃的 `apps/macos` 区域，问题是 Talk Mode 触发 stale config.set、token mismatch 和 local gateway restart。
- 其次是文档/打包簇问题 #64945、#63541、#63768，集中落在 `CHANGELOG.md`、`docs/.i18n`、`docs/help` 一带，说明低贡献区当前更偏 packaging/docs 断裂而不是全新核心 bug。

## 追踪 PR 反馈（方向4）
- 检查到 1 个已追踪 PR 在近 2 小时有新 maintainer 反馈。
- PR #64681 收到 `100yenadmin` recheck 评论，说明最新 head `f33f6cbf37` 下 `extensions/qa-lab/src/scenario-catalog.test.ts` 已 7/7 通过，状态继续偏正向。
- `OPENCLAW-PROJECT.md` 已补记本轮新增候选与该 PR 状态变化。

## 结论
最高优先级是 #65043，因为它是 2026.4.10 之后仍存在的 Slack thread delivery 回归，而且会直接把 subagent 完成消息泄露到频道顶层，影响路由正确性和用户观感。

建议：
1. 先让 aoao 看 #65043 的 `subagent-announce` / `reply-delivery` / Slack outbound 双路径。
2. Windows 首配链路 #65067 作为第二顺位，属于新用户阻断问题。
3. Gmail watcher #65042 继续观察是否迅速形成可复现修复窗口。