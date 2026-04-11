# 全量扫描报告 2026-04-11 18:18 UTC (2026-04-12 02:18 CST)

## GitHub Issues（方向1）

发现了 **4 个新候选**（近2小时内更新，全部0评论）：

### 最重要候选

**[#64966](https://github.com/openclaw/openclaw/issues/64966) Model Routing Timeout Issue — Premature Fallback Due to Short Default Timeout** | S + regression
- 2026-04-11T18:27:37Z
- **核心问题**：`idleTimeoutSeconds` 默认值 60s 太短，ollama/glm-5.1:cloud 等大模型响应超过 60s 就被判定为超时，触发不必要的模型切换
- **影响**：cron 任务、长任务用户被静默降级到 fallback 模型
- **根因**：默认超时硬编码，未读取用户配置的 `agents.defaults.timeoutSeconds`
- **建议**：优先跟进 #63207（timeoutSeconds 配置已修复但有 P0 compile error 未合入主分支）；**建议 aoao 确认 #63207 覆盖范围后接单**

**[#64971](https://github.com/openclaw/openclaw/issues/64971) Control UI replies to externally-backed sessions delivered to webchat instead of underlying channel** | S + bug:behavior
- 2026-04-11T18:37:13Z
- **核心问题**：Telegram-backed session 在 Control UI 内回复时，消息被路由到 webchat 而非 Telegram
- **触发路径**：Telegram 建 session → Control UI 打开同一 session → Control UI 回复 → 消息丢失到 webchat
- **影响**：用户以为消息发出去了，实际没到 Telegram
- **建议**：aoao 接单（S 级路由逻辑问题）

**[#64959](https://github.com/openclaw/openclaw/issues/64959) agent:\<id\>:main persistent main session can become zombie/relock after restart** | M/S + bug:crash
- 2026-04-11T18:17:12Z
- **核心问题**：无显式 sessionKey 的 agent 运行被路由到 agent:\<id\>:main，restart 后该 main session 保持 "running" 状态 + .jsonl.lock 不释放，导致后续运行报 session file locked / timeout
- **影响**：使用 main session 的 agent 反复失败
- **建议**：xixi 调研 agent:\<id\>:main 的 session 生命周期管理逻辑

**[#64939](https://github.com/openclaw/openclaw/issues/64939) Groq audio transcription returns no transcript on 2026.4.10 unless multipart body is manually serialized** | S + regression
- 2026-04-11T17:47:10Z
- **核心问题**：Groq 语音转录 v2026.4.10 失败，workaround 是手动序列化 FormData 为 multipart 并设置正确 content-type
- **根因**：undici fetch 路径未正确发送 multipart upload，导致 Groq 返回空 transcript（而非 HTTP 错误）
- **建议**：aoao 接单（S 级，workaround 已给出）

### 已有覆盖确认（勿重复追踪）
#54952 #54964 #55008 #55013 #55153 #55137 #55466 #55458 #55479 等已追踪项本轮无新活动。

---

## 插件仓库（方向2）

发现了 **1 个新候选**：

**Tencent/openclaw-weixin [#55](https://github.com/Tencent/openclaw-weixin/issues/55) Support ACP thread binding so mode="session" works on WeChat channel** | Feature Request
- 2026-04-11T16:59:47Z
- **核心问题**：WeChat 渠道不支持 ACP `mode="session"`（需要 `thread=true`），导致 WeChat 内的 ACP session 无法持久绑定，每次都是冷启动
- **根因已定位**：`openclaw-weixin` 未注册 session binding adapter，导致 `bindingService.getCapabilities({channel: "openclaw-weixin"}).adapterAvailable === false`
- **影响**：WeChat 用户无法用 ACP claude/codex 做多轮对话（每次冷启动 10-20s）
- **代码不可见**：weixin 插件代码不公开，只能参考主仓库 `src/agents/acp-spawn.ts:599-608` 的 adapter 注册机制
- **已在 P342 追踪**：本轮确认为新发布 issue，与 thread-bound persistent session 直接相关；长期追踪价值高

---

## 贡献者文件区域（方向3）

**gh API 返回空（全部 null）**：无法获取 bottom 10 contributors 的 commit 历史
- 可能原因：GitHub API 对低贡献量用户的 commits 数据同步有延迟，或这些用户只有自动化/非标准 commit 记录
- 尝试的 contributor：`quotentiroler(45), eleqtrizit(53), altaywtf(54), Glucksberg(59), onutc(61), osolmaz(61), jalehman(63), mcaxtr(64), bmendonca3(69)`
- **本轮无法完成方向3分析，建议下一轮重试**

---

## 追踪 PR 反馈（方向4）

### 新发现：#63207 (fix: respect agents.defaults.timeoutSeconds in HTTP request timeout)
- **PR 状态**：Open，2026-04-08 提交
- **内容**：将 `timeoutMs`（来自 `agents.defaults.timeoutSeconds`）threading through HTTP transport chain，修复 v2026.4.8 regression（LLM 请求忽略配置超时）
- **Greptile Review (2/5)**：发现 **P0 compile error** + **P1 functional gap**
  - `createTransportAwareStreamFnForModel` 和 `createBoundaryAwareStreamFnForModel` 未更新接受 `opts?: { timeoutMs? }`，导致 TypeScript 编译失败
  - `createBoundaryAwareStreamFnForModel` 是 Ollama 的主要执行路径，如果不修这个，Ollama 超时问题仍然存在
- **结论**：该 PR **不可安全合入**，需修复 P0 compile error；**建议 aoao 接单直接修复**（代码位置已给出）

### 其他已追踪 PR 状态
- **#55008**（docs clarification）：EronFan 已修复 feishu skills 回归（commit bb2ea2f7e4 + b14be82db1），PR 只含文档变更；**建议 Approve**
- **#55013**（feishu routing fallback）：EronFan 已推动 groupPolicy 描述修正（2026-04-06），**建议 Approve**
- **#57575 / #57406 / #57382 / #57375 / #57352 / #56984 / #56443 / #56438**：均为 greptile review（3-5/5），仅包含 greptile 评论无 maintainer 新评论
- **EronFan 无新提 PR**：近 2 小时无新 PR 活动

---

## 结论

**最高优先级**：
1. **#64966**（S + regression）：模型超时回退配置未生效，与 #63207 强相关；**建议 aoao 修复 #63207 的 P0 compile error 后一并验证 #64966**
2. **#64971**（S）：Control UI 回复路由到错误渠道；清晰可本地复现；**建议 aoao 接单**
3. **#64939**（S + regression）：Groq 语音转录损坏；workaround 已给出；**建议 aoao 接单**
4. **#64959**（M/S）：agent main session zombie/relock；需 xixi 调研根因

**建议**：
- 立即派 aoao 修复 #63207（P0 compile error），同时覆盖 #64966 超时回退问题
- 派 aoao 接单 #64971（Control UI 路由）和 #64939（Groq multipart）
- 方向3贡献者分析继续待解，下轮重试
