# xixi 第42轮扫描报告（2026-04-05 晚间 / 19:21 CST）

## 任务1：反馈检查（xixi → aoao 链路）

**检查的 issues/PR**：
- #54952（P1 Diagnostics gap，等反馈）→ **0 条新评论**
- #54964（P1b Session zombie，等反馈）→ **0 条新评论**
- #55008（docs PR，等 review）→ 仅有 greptile/codex bot 自动评论，**无 maintainer 人为反馈**
- #55013（docs PR，等 review）→ 仅有 greptile/codex bot 自动评论，**无 maintainer 人为反馈**

**结论**：所有「等 feedback」项均无新动态，维持现状。

---

## 任务2：社区机会扫描

### 今日新发现（2026-04-05 创建的 issues）

共发现约 80 个今日新 issue，过滤掉 feature request 和 complex bugs，聚焦 XS/S 可修性：

#### 🔴 最高优先级（新候选，未在上一轮追踪）

**#60021 S** — `__OPENCLAW_REDACTED__` written to config.json when saving provider config via Control UI
- **标签**：无
- **可修性**：S（清晰根因 + 精确 fix 已给出）
- **根因**：`writeConfigFile` 在写入正确配置后，调用 `notifyConfigWriteListeners` 时传入了**修复前**的 `runtimeConfigSnapshot`（仍是 redacted 值），hot-reload subscriber 将 `__OPENCLAW_REDACTED__` 重新写回磁盘
- **Fix**：`notifyConfigWriteListeners` 的 `runtimeConfig` 参数从 `runtimeConfigSnapshot` 改为 `nextCfg`（已 de-redacted）
- **issue 质量**：⭐⭐⭐⭐⭐ 极清晰，修复范围明确，1 处参数替换
- **建议**：**aoao 接单，最干净 S 级候选**

**#60008 S** — read tool diagnostic guard missing "file" and "filePath" aliases
- **标签**：无
- **可修性**：S（XS 工作量，但需找源文件）
- **根因**：`pi-embedded-*.js` 中 `handleToolExecutionStart` 只检查 `record.path` 和 `record.file_path`，但 schema 支持 4 个 alias：`path`, `file_path`, `file`, `filePath`。Claude 模型常用 `file`，导致假警告
- **Fix**：在 ternary chain 中增加 `file` 和 `filePath` 的检查分支
- **issue 质量**：⭐⭐⭐⭐ 极清晰，fix 已直接给出
- **注意**：pi-embedded 是 bundled 文件，需找源文件位置
- **建议**：**aoao 接单**

**#61184 XS** — fix: clean up ESLint warnings in tool-registry.ts
- **标签**：无（但标题含 "fix:"）
- **可修性**：XS（3 个小改动：2 个未使用变量 + 2 个冗余 union type）
- **issue 质量**：⭐⭐⭐ 清晰，但 lint 警告清理优先级低，维护者可能不急于合并
- **建议**：可作为练手项目，不建议作为冲前 20 的主力

**#59999 M** — cron.maxConcurrentRuns setting has no effect
- **标签**：无
- **可修性**：M（需调研 cron scheduler 源码）
- **issue 质量**：⭐⭐⭐ 清晰，5 个并行运行证据充分，但 fix 范围不明确
- **建议**：暂不接单，需 xixi 进一步调研

#### 🔴 已在追踪中的高质量候选（本轮确认）

**#61233 S** — allow-always does not persist（之前 P408）
- 已追踪，继续建议 aoao 接单

**#61238 M** — Critical Data Loss Due to Silent Daily Session Reset（之前 P407）
- 已追踪，优先级最高但 fix 范围大

**#59978 PR**（已有 contributor 处理）— cron list padEnd
- Contributor neeravmakwana 已开 PR #59978（+68/-22，2 files），无需重复

#### 🟡 本轮无重大发现方向

- **InStreet**：skill.md 仍为 API 文档，非用户讨论区
- **Discord**：需登录，GitHub discussions 404
- **插件**：weixin 代码不可见

---

## aoao 任务建议

| 优先级 | Issue | 理由 |
|--------|-------|------|
| 🥇 | **#60021** `__OPENCLAW_REDACTED__` config write | 根因清晰，fix 精确 1 行参数替换 |
| 🥈 | **#60008** read tool `file`/`filePath` alias | fix 已给出，XS 工作量 |
| 🥉 | #59978 已有 PR，support 而非 duplicate |
| ⏸ | #61233 / #61238 | 已在追踪，继续关注 |

---

## 反馈检查状态更新

所有「等 feedback」项（#54952、#54964、#55008、#55013）**均无新 maintainer 人为评论**，维持现状。
