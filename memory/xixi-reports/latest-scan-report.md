# 全量扫描报告 2026-04-13 14:23 CST (06:23 UTC)

## GitHub Issues（方向1）
- 发现了 **7个** 新候选（近2小时内 open 且 updated）
- 最重要的：
  - **#65721** `[Bug]: Beta blocker: core - OpenClaw Agents Can Self-Destruct Through Configuration Modification` — 安全+crash，beta-blocker 标签，需立即关注
  - **#65740** `[Bug]: Chrome CDP websocket unreachable after start - macOS ARM64` — regression，macOS ARM64 Chrome CDP 连接失败，0评论未认领
  - **#65733** `[Bug]: Plugin discovery via safeRealpathSync takes ~20 minutes during gateway startup on Windows` — bug:behavior，Windows 启动 20 分钟延迟，影响严重
  - **#65744** `[Bug]: Feishu DM response truncated and leaked to group chat — similar to #55019` — 飞书 DM 回复被截断并泄露到群聊，类似历史问题 #55019
  - **#65747** `[Bug]: 钉钉官方插件无法工作 - Stream 模式接入失败` — 钉钉插件 Stream 模式失败
  - **#65748** `macOS gateway service install and doctor disagree on gateway entrypoint` — macOS launchd 与 doctor 对 entrypoint 描述不一致
  - **#65728** `[Bug]: always get unauthorized when I start openclaw gateway run` — regression，认证失败

## 插件仓库（方向2）
- Tencent/openclaw-weixin 发现 **3个** 新公开 issue/PR
- 最重要的：
  - **PR #58** `feat(messaging): support chunkMode for outbound text messages` (2026-04-13 05:54 UTC) — chunkMode 出站文本支持，新的出站消息分块功能
  - **#57** `unable to uninstall` — 用户无法卸载插件，Error: Cannot find module 'zod' + duplicate plugin id（上次已追踪）
  - **#58** `feat(messaging): support chunkMode for outbound text messages` — 新功能
- 无 openclaw-weixin 相关 regression 新发现；主仓最新 regression 集中在 Chrome CDP、Telegram、WhatsApp 等

## 贡献者文件区域（方向3）
- 扫描了排名最末的 **10个** 贡献者（huntharo, mcaxtr, bmendonca3, onutc, jalehman, osolmaz, Glucksberg, altaywtf, eleqtrizit, quotentiroler）
- 其中 **mcaxtr** 的最近 20 条 commit 集中在 `extensions/whatsapp/src/` 目录（login-qr.ts、connection-controller.ts 等），与当前已知 WhatsApp 相关 regression 区域高度吻合
- 其余 9 人本轮未检出活跃 commit 或活跃文件区与当前 open bugs 的高相关匹配
- 发现 **0个** 需要追加追踪的新高优先级 open bug

## 追踪 PR 反馈（方向4）
- 本轮扫描到 **30+ 个新 open PR**（过去 2 小时内），无 maintainer 新评论增量信息
- 关键 PR 状态：
  - **PR #65574** (MCP stdio proxy, size:M) — KeWang0622 持续 5 个 fix commit，接近可 merge
  - **PR #65577** (OutboundPayloadPlan centralization, size:L) — maintainer，测试覆盖好，等 review
  - **PR #65750** `fix(control-ui): stop reloading history after clear (#65719)` — 与 Control UI `/clear` race condition 相关，XS 级 fix
  - **PR #65752** `qa: prefer Codex auth for live defaults` — maintainer+qa-lab，最新更新时间 06:23 UTC
- 已追踪 PR 无本轮 maintainer 人工新反馈；状态稳定，持续跟进

## 结论
**最高优先级：**
1. **#65721** 安全+crash beta-blocker（OpenClaw Agents 可通过配置修改自我销毁）— 建议 aoao 立即排查代码路径
2. **#65740** Chrome CDP websocket unreachable — macOS ARM64 regression，与已知 CDP 问题簇重叠
3. **#65733** Windows 插件发现 20 分钟启动延迟 — 影响所有 Windows 用户，严重可用性 bug

**建议：**
- #65721 安全+crash 属性 → 优先派给 aoao
- PR #65750 与 PR #65752 为最新 fix，建议快速 review 后 Approve
- mcaxtr 的 WhatsApp 文件区与已知 WhatsApp regression 区域重叠，继续监控