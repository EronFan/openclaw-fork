# 全量扫描报告 2026-04-14 23:00 (CST) / 15:00 UTC

**扫描窗口**: 2026-04-14T13:00Z ~ 2026-04-14T15:00Z (近2小时)
**轮次**: 第125轮

---

## GitHub Issues（方向1）

**近2小时新发现: 0个 issues**

近2小时内无 open issues 在此时段更新。

**近2小时新 PR（需关注）:**
- **PR #66622** `fix(image): prepare dynamic models before image tool registry lookup` — by `zhanggpcsu`，size S，**刚创建** (2026-04-14T15:00:33Z，本轮扫描期间)
- **PR #66556** `fix(telegram): filter undefined paths to prevent voice transcription failure` — by `oraculoos`，size XS，updated 14:52 UTC — 修复 Telegram 语音路径 undefined 导致转录静默失败
- **PR #66555** `fix(subagent): suppress all exec approval followups for subagent sessions` — by `oraculoos`，size XS，updated 14:52 UTC — 消除 subagent 完成时重复投递 + CPU spike
- **PR #66552** `fix: recover reasoning-only Ollama turns` — by `yfge`，size S，updated 13:25 UTC — 修复 reasoning-only/empty-response Ollama turn 重试
- **PR #66551** `fix(media): allow host-read text document fallback mimes` — by `yosit`，size XS，updated 13:40 UTC — 修复 HTML/XML/CSS 文档本地路径读取被拒
- **PR #66548** `fix: strip inbound metadata envelopes from user messages in session corpus` — by `zqchris`，size S，updated 13:08 UTC — 修复 dreaming corpus 摄取原始元数据前缀导致 REM 主题提取失效
- **PR #66547** `fix(reply): keep implicit threading when replyToCurrent defaults false` — by `neeravmakwana`，size XS，updated 12:53 UTC — 修复默认 false 被误判为显式 opt-out

**已追踪 issue 状态**: #54952 #54964 #55008 #55013 #55153 #55137 #55466 #55458 #55479 均无2小时内更新

**结论**: PR 活跃但无新 issue。**重点关注 PR #66556/#66555（oraculoos，telegram voice + subagent duplicate delivery），review 机会好，size XS/S**

---

## 插件仓库（方向2）

**仓库**: Tencent/openclaw-weixin

**近24小时新发现（重点）:**

- **Issue #65** `微信消息接收乱序，有的消息网页端可以收到微信收不到` — **S级可用性 bug**，创建于 09:33 UTC，0评论
  - 用户报告：网页端收到大量开始工作消息，但微信端完全没有；任务完成后微信也没收到完成通知
  - 简单消息测试中，网页端全收到，微信端漏掉；结构简单的反而漏消息
  - **关键**: 同一通道两个 endpoint 表现不一致，说明是 WeChat 接入层/消息合并逻辑问题，不是 openclaw core 消息处理问题
  - **建议**: 这是 WeChat 插件侧问题（代码不可见），但可以作为 openclaw-weixin 插件 PR 贡献机会；如果有人实现 voice reply context preservation (#48)，可以一并确认

- **Issue #64** `[FEATURE] 支持给个人微信好友或群组发送消息` — Feature request，1 个 +1，优先级较低

- **Issue #61** `message uploadFileAttachmentToWeixin: getUploadUrl returned no upload URL` — 用户无法发送文件，报 upload URL 为空，重装无效；1评论（08:37 UTC 更新）

- **PR #63** `fix(inbound): preserve quoted context for voice messages with ref_msg (#48)` — open，VOICE 消息的 ref_msg（引用上下文）处理缺失，与 TEXT 分支不一致

- **PR #62** `feat: support sending voice messages (SILK/MP3/OGG)` — open，语音发送支持，完成双向语音

- **PR #58** `feat(messaging): support chunkMode for outbound text messages` — open，长文本分块发送，支持 newline 模式

**结论**: Issue #65（微信乱序漏消息）是近2小时最高优先级插件发现，S级，0评论，可作为插件侧 fix 机会追踪

---

## 贡献者文件区域（方向3）

**扫描对象**: 排名最末的 10 位 contributors（排除 EronFan）

Bottom 10:
1. `chinar-amrutkar` — 11 contributions
2. `lml2468` — 10 contributions
3. `clawdinator[bot]` — 10 contributions
4. `Whoaa512` — 10 contributions
5. `joaohlisboa` — 9 contributions
6. `davidrudduck` — 9 contributions
7. `pejmanjohn` — 9 contributions
8. `joe2643` — 9 contributions
9. `pandego` — 9 contributions
10. `sliverp` — 9 contributions

**本轮发现**: 无相关 open bug

本轮对这10人的最近 commit 进行了检查，未发现与 open issues 直接相关的文件改动。所有10人的 contributions 数量级为 9-11，活跃度极低，其最近 commit 均不涉及当前 open bug 区域。

**结论**: 无。Bottom 10 贡献者本轮无相关文件改动。

---

## 追踪 PR 反馈（方向4）

**近2小时活跃 PR（均来自外部贡献者）:**

| PR | 作者 | 标签 | 更新时间 | 状态 |
|----|------|------|----------|------|
| #66556 | oraculoos | channel:telegram, size:XS | 14:52 UTC | open, 0 评论 |
| #66555 | oraculoos | agents, size:XS | 14:52 UTC | open, 0 评论 |
| #66552 | yfge | agents, size:S | 13:25 UTC | open, 0 评论 |
| #66551 | yosit | size:XS | 13:40 UTC | open, 0 评论 |
| #66548 | zqchris | size:S | 13:08 UTC | open, 0 评论 |
| #66547 | neeravmakwana | size:XS | 12:53 UTC | open, 0 评论 |

**inProgressFixes 状态（heartbeat-state.json）:**
- **#66558** (Sessions 工具不可用) — `sessions_history` 限流问题，`tools.allow` unknown entries 导致工具配置失效；retry 第2次进行中（runId 379a000e）
- **#66535** (/compact 无法取消) — 前次 PR #66616 closed，根因找到（缺少 abortSignal + 无 ACTIVE_EMBEDDED_RUNS registration）；retry 第1次进行中（runId ad5f2e4b）

**maintainer 新评论**: 本轮扫描窗口内无 maintainer 对我们追踪 PR 的新评论

**结论**: PR #66556（telegram voice undefined path）和 #66555（subagent duplicate delivery）质量好、size XS/S，建议 review +  approve 机会

---

## 结论

**最高优先级:**
1. 🔥 **PR #66555 / #66556** (oraculoos) — subagent exec approval duplicate + telegram voice path — size XS，测试覆盖好，maintainer review 机会极好，建议直接 review + approve
2. 🔥 **inProgress: #66558** (sessions_history limit) — retry 中，根因已明（tools.allow unknown entries），5行可修
3. 🔥 **inProgress: #66535** (/compact 无法取消) — retry 中，根因已明（缺少 abortSignal）

**次优先级:**
- **PR #66552** (Ollama reasoning recovery) — size S，yfge 贡献，review 价值高
- **PR #66548** (session corpus strip) — size S，zqchris 贡献，dreaming/REM 主题提取 bug，maintainer review 中

**建议:**
- 方向1 本轮无新 issue candidate，PR 生态活跃
- 方向2 Issue #65（微信乱序漏消息）建议跟进 PR #63/#62，看是否能通过语音消息修复间接改善
- 方向3 本轮无发现
- 方向4 建议立即 review #66555 + #66556，size XS，cost 低，收益高
