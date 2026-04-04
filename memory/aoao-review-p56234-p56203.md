# aoao 复核报告
**时间：** 2026-03-28 14:47 GMT+8  
**任务：** Review PR #56234 & PR #56203

---

## PR #56234 分析：dmPolicy security audit parity fix

### 修复了什么
- **缺口 1（对称性）：** `groupPolicy="open"` 已触发 CRITICAL 暴露告警，但 `dmPolicy="open"` 没有。PR 重构 `listGroupPolicyOpen` → 通用 `listPolicyOpen(cfg, policyKey)`，使两种 policy 享受等价检测。
- **缺口 2（dmScope 误配）：** `session.dmScope="main"` 在多用户环境下可导致跨用户上下文泄漏，新增 `CRITICAL` finding `security.trust_model.dm_scope_main_multi_user`。

新增 3 个 CRITICAL finding：
| Check ID | 触发条件 |
|---|---|
| `security.exposure.open_dms_with_elevated` | `dmPolicy="open"` + elevated tools |
| `security.exposure.open_dms_with_runtime_or_fs` | `dmPolicy="open"` + runtime/fs tools |
| `security.trust_model.dm_scope_main_multi_user` | `dmScope="main"` + 多用户信号 |

### 是否覆盖 #55612/#55578
**是。** PR body 明确声明 `Closes #55612` 和 `Closes #55578`，且新增的 3 个 CRITICAL finding 与这两个 issue 描述的审计盲点完全对应。

### 建议动作
- ✅ **可以合并** — 逻辑对称性修复干净，测试覆盖到位（unit + integration）
- ⚠️ **注意范围蔓延** — PR 涉及 11 个文件含 2 个 docs/proposals 新增文件，建议确认非预期 side-effect（skill-integrity-verification.md、plugin-capability-model.md 是否在此次 scope 内）
- 🔍 **review 质量** — 目前只有 bot review（greptile-apps、chatgpt-codex-connector），无 maintainer approve，建议等至少一个 human maintainer review 后合并

---

## PR #56203 分析：sessions_send prefers sessionKey over label

### 修复了什么
- **问题根因：** `sessions_send` schema 接受 `sessionKey` 和 `label` 两个字段，但 executor 将「两者同时存在」视为错误直接 throw，导致实际 tool-call pipeline（adapter/hook 冗余注入参数）即使 sessionKey 精准也会失败。
- **修复逻辑：** executor 优先使用 `sessionKey`（更明确的 selector），仅当 `sessionKey` 缺失时 fallback 到 `label` 解析。

改动极小（+47/-7 行），仅修改 `src/agents/tools/sessions-send-tool.ts`。

### 对我们的实际影响
**高。** 这直接对应我们 agent 间 `sessions_send` 超时的问题。之前主 agent 向子 agent 派单时若 adapter 层同时注入了 `sessionKey` 和 `label`，请求会立即以 `Provide either sessionKey or label (not both)` 失败，而不是真正发到目标 session 造成超时。

修复后：
```
tool call -> { sessionKey, label } -> sessions_send -> use sessionKey -> 正常发送
```

### 建议动作
- ✅ **优先合并** — bug fix 精准，regression test 到位（unit + integration + gateway 三层），runtime 验证有效
- ✅ **对我们直接受益** — 解决了 agent 间 sessions_send 失败的问题，无需再额外规避参数冲突
- ⚠️ **潜在风险：** 有 caller 依赖旧 hard-error 做参数校验的话现在会静默通过。review 中已标注此风险，但调用方通常不会故意同时传两个字段，风险可控
- 🔍 **测试覆盖率声明：** 作者称未跑 `pnpm check` 和完整 test suite，建议合入前跑一次快速 check 确认无意外

---

## 汇总

| PR | 状态 | 优先级 | 我们是否受益 |
|---|---|---|---|
| #56234 | 逻辑正确，等 maintainer review | 中 | 间接受益（审计能力完善） |
| #56203 | bug fix 精准，已 runtime 验证 | 高 | **直接受益**（派单失败问题） |

**建议：** #56203 可考虑加速合并；#56234 确认 scope 蔓延后合并。
