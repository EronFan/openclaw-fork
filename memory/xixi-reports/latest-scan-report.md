# 全量扫描报告 [2026-04-13 19:08 CST / 第120轮]

## GitHub Issues（方向1）

发现 **18 个** 近 2 小时内更新的 open issues，其中 **5 个** 新候选值得 action（未追踪）：

### 🔥 TOP 候选（未追踪）

1. **#65847** `Bug: agents.defaults.heartbeat.to corrupts deliveryContext` — **严重路由 bug**
   - 配置 `agents.defaults.heartbeat.to` 后，**所有普通消息** 都被错误路由到 heartbeat target channel
   - 用户 DM 全部泄漏到心跳目标渠道，隐私 + 功能双重失效
   - 0 评论，无标签，刚上报；可修性 S-M；**建议 aoao 优先接单**

2. **#65899** `Hook error: Cannot access 'group' before initialization in message:sent` — **S 级 ReferenceError**
   - `message:sent` 内置 hook 每次发消息都抛 `ReferenceError: Cannot access 'group' before initialization`
   - 不是用户代码，是 managed/built-in hook 内部 bug
   - 0 评论，无标签；**建议 aoao 接单**

3. **#65890** `QMD backend falls back to builtin on live openclaw memory search` — **bug+regression**
   - `memory.backend = "qmd"` 时，live CLI search 回退到 builtin
   - 已有 bug+regression 标签，0 评论；需要调研 CLI 侧 backend resolution 路径

4. **#65867** `Gemini <final> tags leak into delivered messages` — **bug+regression**
   - 与历史 #48587 同源 regression；Gemini 思考标签漏出到交付消息
   - 已有 bug 标签，0 评论；MoerAI 的文件区（assistant-visible-text.ts）与此直接相关

5. **#65883** `webchat: queued user message vanishes from chat history after being dequeued` — **UX bug**
   - Gateway streaming 期间发第二条消息，dequeue 后消息从 UI 消失（agent 实际有处理）
   - 0 评论，无标签；UX 问题，影响 webchat 体验

### 已有追踪但近期有更新
- **#62178** web_fetch FakeIP blocked（仍 open，已在追踪列表）
- **#59228** command-dispatch skill routing strips args（bug+regression，2 评论）
- **#48479** google-vertex ADC auth（仍 open，9 评论，regression）

### 其他近期 issues（低优先级）
- #65903 Docs runbook 结构请求（feature）
- #65897 npm audit 12 vulnerabilities（0评论，无标签）
- #65869 Control UI Dreaming tab 调用不存在的 wiki API
- #65870 Brave Search docs URL 过期
- #65868/#65866/#65865 功能请求（低优先级）

## 插件仓库（方向2）

Tencent/openclaw-weixin 近 2 小时更新 3 条，均为新内容：

- **#59** `【咨询】鸿蒙系统微信连接支持情况` — 0评论，咨询性质，不可直接 action（代码不可见）
- **#60** `Feature: 支持多人同时扫码建立微信连接` — 0评论，功能请求，低优先级
- **PR #58** `feat(messaging): support chunkMode for outbound text messages` — 刚开，open 状态

已追踪的 PR #56 (ACP thread binding)、#49 (voice ref_msg)、#47 (register 重入) 仍 open 未 merge。
**无新的高优先级 weixin bug**。

## 贡献者文件区域（方向3）

扫描排名最末的 10 个贡献者（排除 EronFan），贡献量 9-11 次：
`davidrudduck、joaohlisboa、pejmanjohn、joe2643、sliverp、BruceMacD、lml2468、clawdinator[bot]、Whoaa512、MoerAI`

各贡献者最近活跃文件区及关联 open bug：

| 贡献者 | 最近文件区 | 关联 open bug |
|--------|-----------|--------------|
| lml2468 | `src/gateway/control-plane-rate-limit.ts`、`server-maintenance.ts`、`server-methods/nodes.ts` | #65834 memory cron reconciliation crash（已追踪） |
| MoerAI | `src/shared/text/assistant-visible-text.ts` | **#65867** Gemini <final> tags leak（新发现，直接命中！） |
| Whoaa512 | `src/security/external-content.ts`、`web-tools.fetch.e2e.test.ts` | #62178 web_fetch FakeIP（已追踪） |
| sliverp | `extensions/qqbot/src/utils/file-utils.ts` | 无直接匹配的 open bug |
| BruceMacD | CHANGELOG.md（主要）| 无直接匹配 |

发现 **1 个** 新的高相关 open bug（#65867 与 MoerAI 文件区直接重叠）。

## 追踪 PR 反馈（方向4）

| PR | 状态变化 |
|----|---------|
| **#65577** Outbound payload centralization | ✅ **已 MERGE**（merged at 2026-04-13T00:52）|
| #65574 fix(mcp-stdio): proxy env vars | 仍 open；@mjamiv 生产环境确认修复有效；@KeWang0622 感谢回复；接近 merge |
| #65511 gateway timeout attribution+QA restart | 仍 open；@100yenadmin 在 2026-04-12T20:27 呼吁 @steipete @vincentkoc review；需等 maintainer |
| #65206 fix: cron persisted state on load | **已关闭（未 merge）**；此前 P59904 追踪的 cron state fix PR 被关闭 |
| #65016 Fix/cron announce no reply | 仍 open；@obviyus 发出 CHANGES_REQUESTED；需关注 |
| #65021 fix(telegram): interrupt delivery | **已关闭（未 merge）** |

**关键变化：**
- #65577 merge 是本轮最大进展
- #65206 关闭需要注意：cron state fix 被关闭，#65193 根因修复仍需跟进（有没有其他 PR 替代？）
- #65016 有 CHANGES_REQUESTED，需要关注 author 是否响应

## 结论

**最高优先级**：
1. **#65847** heartbeat.to 路由污染（所有消息被错误转发，隐私 + 功能双重失效，S-M 级可修）
2. **#65899** message:sent 内置 hook ReferenceError（影响所有用户，S 级）

**次优先级**：
3. **#65867** Gemini <final> tags leak（bug+regression，MoerAI 文件区直接命中）
4. **#65883** webchat queued message vanishes（UX bug，S 级）

**建议**：
- aoao 优先接 #65847 和 #65899
- #65577 已 merge，可以更新项目状态
- 持续盯 #65574 merge 时机（生产确认，接近就绪）
- #65206 关闭后需确认是否有替代 PR 覆盖 cron state fix
