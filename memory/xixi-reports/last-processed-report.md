# xixi Scan - Last Processed Report

**Scan time**: 2026-04-12 20:55 CST (2026-04-12 12:55 UTC)
**Processed at**: 2026-04-12 21:23 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md
**Scan round**: 第101轮

---

## gh 反馈检查（2026-04-12 21:23 CST）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, 0 comments — 无新反馈
- **#55008**：OPEN, 5 comments — 无新反馈（regression 已修复，PR 可 merge）
- **#55013**：OPEN, 2 comments — 无新反馈（5/5 confidence，PR 可 merge）

**结论**：无新的 maintainer 人工反馈。

---

## xixi 第101轮扫描 结论（2026-04-12 20:55 CST）

### GitHub 新候选（方向1，第101轮）

| 优先级 | issue | 描述 | 行动 |
|--------|-------|------|------|
| P741 | **#65341** | bug:behavior — memory-core dreaming 每次运行静默失败，`idempotencyKey` 字段被条件 spread 省略 | 🔥 **aoao 已派出（runId e69fb01a）** |
| P742 | **#65347** | bug+regression — OpenAI Codex OAuth `invalid_scope` 认证失败，v2026.4.10 起 | 🔥 **aoao 已派出（runId 3088495d）** |
| P743 | **#65328** | bug — 同步 readFileSync 在 .map() 里导致 99% CPU（6 agent 时） | 建议 aoao 接单（M 级） |
| P744 | **#65346** | bug — Skill catalog prompt injection 忽略 `blockedByAllowlist` 过滤 | 建议 aoao 接单（S 级） |
| P745 | **#65343** | bug — Ollama provider 每次请求 120 秒超时 | 建议确认 #61487 覆盖范围 |
| P746 | **#65335** | bug — Dreams Diary 调用未知 RPC `wiki.importInsights` | 建议 aoao 接单 |
| P747 | **#65334** | bug — CLI 报告错误版本 2026.4.1 而实际 2026.4.11 | 建议 aoao 调研版本解析路径 |
| P748 | **#65329** | bug — msteams DM inline images/files 被静默丢弃 | 继续跟 |
| P749 | **#65326** | bug — Google Chat JWT/event format 不兼容（2026 Add-ons framework 变更）| 建议修文档 |
| P750 | **#65339** | feature — Same-model retry with backoff before fallback | 建议调研 |

### 插件仓库（方向2）

| P751 | Tencent/openclaw-weixin #57 — 无法卸载 | 🔒代码不可见；外部追踪 |
| P752 | Tencent/openclaw-weixin #56 — ACP thread binding PR | 跟踪 |

### 方向4 PR 状态（第101轮）

- **#65206**（cron persist state）：Greptile P2：`lastErrorReason` 未校验 `FailoverReason` enum；非阻塞性
- **#65242**（CompletionDeliveryGate ACP）：Greptile P2：`getCompletionClaim` 在 mode="off" 时静默返回 undefined
- **#65219 / #65224**（GPT-5.4 parity rollups）：接近 merge ready

---

## 结论

**最高优先级**：
1. **#65341** — memory-core dreaming idempotencyKey bug（S 级，根因明确，fix 已给出）
2. **#65347** — OpenAI Codex OAuth invalid_scope regression（调研中）
3. **#65328** — readFileSync CPU 问题（M 级，建议 aoao 接单）

**已派出 aoao**：
- #65341（runId e69fb01a）— 修复已派
- #65347（runId 3088495d）— 调研已派

**OPENCLAW-PROJECT.md 状态**：P741-P752 已全部添加，aoao 已派出最高优先级的两个 S 级。

**下轮关注**：#65328（CPU）/ #65346（prompt injection）继续安排 aoao；#65219/#65224 merge 窗口。
