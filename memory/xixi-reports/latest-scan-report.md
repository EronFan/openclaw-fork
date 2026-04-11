# 全量扫描报告 2026-04-12 01:03 (CST)

## GitHub Issues（方向1）
- 发现了 30 个近 2 小时更新的 open issues/PR 候选。
- 最重要的是：
  - #64925 Silent agent errors never surface to TUI/Telegram，错误被静默吞掉，用户只看到 typing 超时，属于高优先级 UX/可靠性问题。
  - #64917 sessions_send from visible webchat leaks internal replies via announce path，高优先级隐私/路由问题。
  - #64921 textTransforms from plugins never applied，主进程插件 runtime 返回 null，已有修复 PR #64924 可跟进。
  - #64910 Agent response gets stuck，输出框无限闪烁不结束，属于核心交互 regression。
- 另外观察到 #64922（Minimax reasoning level 被拒）、#64916（WebUI 图片发出但 Agent 收到空消息）、#64894（Codex OAuth invalid_scope 回归）也值得继续盯。
- 已有覆盖项 #54952 #54964 #55008 #55013 #55153 #55137 #55466 #55458 #55479 本轮未重复立项。

## 插件仓库（方向2）
- 发现了 1 个新候选。
- Tencent/openclaw-weixin #55：Support ACP thread binding so mode="session" works on WeChat channel。
- 这是明确的能力缺口，不是 bug 修复，但和 thread-bound persistent session 直接相关，值得长期追踪。
- openclaw 主仓库近 2 小时未看到新的 plugin label 高优先级 issue 候选。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors：BruceMacD、davidrudduck、pandego、joaohlisboa、pejmanjohn、joe2643、mneves75、lml2468、clawdinator[bot]、Whoaa512。
- 抽样查看其最近 commit 文件区域，主要落在：
  - `src/agents/pi-embedded-runner/*`
  - `src/browser/server-context*`
  - `src/acp/translator*`
  - `src/mcp/plugin-tools-serve.ts`
  - `src/commands/configure.ts` / `src/commands/onboard-auth.ts`
  - `src/gateway/server-maintenance*`
  - `src/security/external-content*`
- 关联 open bug 搜索后，发现 7 个相关 open bug 方向，但本轮没有看到明确“未认领且可立刻抢修”的新高优先级小修点；更像已有问题簇延续：
  - compaction / pi-embedded-runner：#64604 #61441 #53468
  - ACP translator：#62552 #44294
  - plugin-tools serve：#64536 #63881
  - web-tools / external-content：#53185 #62973
- 结论：方向3已执行，暂未挖出比方向1更强的新切入点。

## 追踪 PR 反馈（方向4）
- 已检查当前追踪 PR：
  - #55008：无新 maintainer 评论，状态仍 open，最后有效更新停留在 2026-03-30，可 merge 判断不变。
  - #55013：无新 maintainer 评论，仍是 open，最后关键状态仍为 safe-to-merge，不变。
  - #55153：已 closed，无新增动作。
  - #55137：已 merged，无新增动作。
  - #55466：仍 open，最近更新 2026-04-10 23:03 UTC，本轮未看到新的 maintainer review 反馈。
- 另外本轮新活跃 PR 里，最值得跟的是：
  - #64924 fix: textTransforms from plugins now applied in main process，直接对应新 issue #64921。
  - #64920 fix(feishu): route topic-group messages through per-thread sequential lanes，Feishu 线程顺序性修复，值得关注。
  - #64918 fix(auto-reply): preserve image attachment notes，和多模态/附件体验相关。

## 结论
最高优先级是 #64925，其次是 #64917 和 #64910。

建议：
1. aoao 优先看 #64925，属于用户直接感知的静默失败。
2. 然后看 #64917，隐私和错误路由风险更大。
3. #64921 可直接跟 PR #64924，属于低成本快收割项。
4. weixin 方向本轮只有 #55，先记账，不急着投入。