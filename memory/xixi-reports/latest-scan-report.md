# 全量扫描报告 [2026-04-12 05:23 CST]

## GitHub Issues（方向1）
- 发现了2个新候选:
  - **#65016** `fix(cron): normalize malformed persisted job state on load`（size S，最新 updated 21:48 UTC）— cron 持久化状态畸形导致加载时行为异常；P35/#55935 的 announce 路径修复相关，建议跟进
  - **#65012** `fix(memory-core): preserve public artifact visibility through loader cache restore`（size L，docs+extensions:memory-core，updated 21:45 UTC）— memory-wiki bridge mode 的 artifact 可见性问题；与 P333/#64510（bridge mode 0 artifacts）可能相关，建议 aoao 确认是否为同一人修
  - 其他近 3 小时活跃 PR（#64989 You.com plugin feature，#65013 ACP child-session banners，#64485 Docker config defaults）无 regression/bug 标签，暂不列为高优先级

## 插件仓库（方向2）
- 发现了4个 Tencent/openclaw-weixin 近 2 小时更新的 issue:
  - **#54** Bug: 图片查看功能完全不可用（sharp模块缺失），updated=14:03 UTC
  - **#53** Bug: AI承诺设置定时提醒后，实际未创建cron任务，且无法通过聊天记录回忆，updated=12:01 UTC
  - **#50** openclaw定时推送无法在微信触发，updated=05:22 UTC（早于扫描窗口，但仍在同天内）
  - #55 ACP thread binding feature request 已追踪（P342）
  - ⚠️ weixin 插件代码不可见，无法定位根因；建议仅标记为"外部追踪"

## 贡献者文件区域（方向3）
- 扫描了排名最末的10个贡献者的文件区域，发现0个相关未认领 open bug
- 注：bottom10 贡献者主要触及 rate-limit、ws-connection、compact、browser/server-context、acp/translator、Dockerfile 等文件；均未在这些文件中发现新的 open bug

## 追踪 PR 反馈（方向4）
- **#64921**（textTransforms plugin bug，open）：maintainer 已给详细根因分析，`loadPluginRuntime()`在 main process 返回 null；**已有 PR #64924**，Greptile 5/5；**P340 状态更新为"PR #64924 可 merge"**
- **#64924**（fix: textTransforms + /new session overrides）：Greptile 5/5，包含4个独立修复；最新评论 17:51 UTC
- **#64835**（memory_search vec0 bug）：**已 closed**；maintainer 确认根因不是 vec0
- **#64845**（Memory dreaming narrative fails）：open，comments=2，最新 17:04 UTC 有用户反馈 v2026.4.11-beta.1 仍有问题
- **#64810**（Heartbeat interrupts Telegram topic replies）：open，comments=2；fix 已以 #64823 提交（Greptile 5/5，13:34 UTC）

## 结论
**最高优先级**: #64924（textTransforms + related fixes，Greptile 5/5，建议 Approve 推 merge）；#65012（memory-core artifact visibility，L fix，建议 aoao 确认是否与 #64510 相关）；#65016（cron 状态规范化，S fix，无风险可 quick Approve）
**weixin #54**（sharp 图片功能）和 #53（cron 记忆缺失）为可用性缺口，虽代码不可见但可关注是否蔓延到主仓
