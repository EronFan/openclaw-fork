# OpenClaw GitHub 扫描报告
**扫描时间：2026-04-12 08:12 CST**
**范围：补扫最近约 9 小时新增 issue / PR，并刷新高优先级候选**

---

## 一、最新高优先级 Issue

### 1. #65052 — Codex-native vision turns can stall when inbound images are present and the dynamic image tool remains exposed
- 标签：`bug` `regression`
- 时间：2026-04-12 08:00 CST 左右
- 摘要：用户消息里已经带图，Codex vision 模型本应直接回答，但动态 `image` tool 仍暴露，模型再次调用 `image` 后会卡死不回复
- 影响：直接造成带图对话无回复，用户面可见
- 难度：**S**
- 可修性：**S**
- 状态：**已有对应 PR #65061**，勿重复修

### 2. #65042 — Gmail watcher duplicates and causes port 8788 bind conflict in OpenClaw
- 标签：`bug` `regression`
- 时间：2026-04-12 07:27 CST
- 摘要：Gmail watcher 启动后被重复拉起，8788 端口二次 bind 失败，同时邮件 reply target not found，导致自动化邮件流断掉
- 影响：邮件自动化不可用
- 难度：**M**
- 可修性：**M**
- 建议：值得跟进，但比纯代码回归类更重一些

### 3. #65062 — Gateway high CPU caused by malformed QMD startup collections and unrelated extension plugins loaded during provider normalization
- 标签：暂无
- 时间：2026-04-12 08:21 CST
- 摘要：网关高 CPU，混合了两类 runtime bug，分别是 QMD collection 异常重建 + disabled/discovered plugin 被错误加载
- 影响：高 CPU、日志噪音、MCP 子进程膨胀
- 难度：**M/L**
- 可修性：**M**（现阶段问题偏大，不适合优先给 aoao）
- 建议：先观察，不作为本轮首选接单

### 4. #65054 — provider-usage js hardcodes CN endpoint for MiniMax usage polling
- 标签：`bug` `bug:behavior`
- 时间：2026-04-12 08:00 CST
- 摘要：usage polling endpoint 写死 CN endpoint
- 难度：**XS**
- 状态：**已有 PR #65059**

### 5. #65056 — Prompt cache busted cross-run for task-scoped adapters
- 标签：`bug` `bug:behavior`
- 时间：2026-04-12 08:07 CST
- 摘要：task-scoped adapter 的 prompt cache 跨 run 失效
- 难度：**S/M**
- 建议：可跟，但不如 regression 直观

---

## 二、最新 PR 审查建议

### 值得 Approve
- **#65059** — `fix(minimax): use configured baseUrl for usage polling endpoint`
  - size: **XS**
  - 只修 endpoint 选择，变更小，清晰
  - **可 Approve**

- **#65057** — `fix(dreaming): include timezone label in diary timestamps`
  - size: **XS**
  - UI 小修，可 Approve

- **#65058** — `fix(googlechat): accept add-on space lifecycle payload variants`
  - size: **XS**
  - 变更小，可 Approve

- **#65053** — `fix(memory-core): wake managed dreaming jobs immediately`
  - size: **XS**
  - 可 Approve

### 已有 PR 对应，勿重复修
- **#65061** — 修 #65052，size **S**
- **#65059** — 修 #65054，size **XS**

---

## 三、给 aoao 的接单建议

### 第一推荐
**#65042 — Gmail watcher duplicate bind / reply target not found**
- 原因：回归、用户影响明确、问题真实，不是纯想法类 issue
- 风险：中等，涉及 watcher 生命周期
- 适合度：**M**

### 第二推荐
**#65056 — prompt cache cross-run 失效**
- 原因：偏核心逻辑 bug，若复现清晰可切入
- 适合度：**S/M**

### 不建议 aoao 本轮首接
- **#65062**：范围偏大，混合两个 runtime 根因，容易陷进去
- **#65052**：虽然很值，但已经有 PR #65061 了
- **#65054**：已有 PR #65059

---

## 四、结论摘要

```
状态：成功
任务：补扫 OpenClaw GitHub 最新 issue / PR
结论：最新高优先级新增里，#65052 最清晰但已有 PR；#65042 是当前最适合 aoao 接的新增候选；#65062 影响大但范围过散
可修性：#65042 = M，#65056 = S/M，#65062 = M 但不建议优先
建议：aoao 优先看 #65042；main 可顺手 Approve #65059 这类 XS PR
阻塞：无
```
