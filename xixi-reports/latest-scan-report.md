# GitHub Issues 扫描报告

**扫描时间:** 2026-04-13 08:40 GMT+8  
**扫描方向:** GitHub Issues & PRs、最近活跃 PR、代码文件交叉点

---

## 一、高优先级 Issue (bug + regression 标签)

### 🔴 P0 - Regression Issues

| # | Title | 可修性 | 备注 |
|---|-------|--------|------|
| **65613** | Discord stale-socket health-monitor restart every ~35min | **S** | 与 #38395 相同问题重现，WebSocket 连接池清理问题 |
| **65611** | manual-cdp attachOnly profile not detecting active CDP session | **M** | 用户已提供调试信息，root cause: CDP readiness 检测逻辑 |
| **65603** | LLM request failed: Azure Foundry GPT models schema/tool payload | **S** | 可能是 Azure 端配置或请求格式问题 |
| **65578** | Kilo Gateway model auto-discovery only returning Kilo/kilo-auto | **S** | 模型发现逻辑只返回默认模型 |
| **65571** | Browser CDP fails on Linux (Elementary OS) | **M** | 跨版本问题 (2026.4.8-2026.4.11)，root cause 已在评论区找到 |
| **65553** | openclaw memory CLI hangs with QMD backend on Raspberry Pi | **S** | 特定平台 (arm64) 阻塞问题 |
| **65529** | Microsoft Edge TTS provider not registered | **S** | Provider 注册缺失，配置问题 |

### 🟠 Token Usage / Auto-Compression Regression (2026.4.9+)

| # | Title | 可修性 | 备注 |
|---|-------|--------|------|
| **65602** | resourceLoader.reload() overwrites reserveTokens | **M** | 用户配置被 SDK 默认值覆盖，影响 preemptive compaction |
| **65600** | totalTokensFresh permanently set to true — pre-flight compaction skipped | **M** | 第一个 response 后 totalTokensFresh 永不重置 |
| **65550** | memory-core dreaming runaway loop — 94 sessions, $4.35 | **M** | 高优先级！已有 PR #65589 但未集成到生产代码 |

---

## 二、已追踪 PR 的 Maintainer 反馈

| # | Title | 状态 | 关键反馈 |
|---|-------|------|----------|
| **65596** | QA Lab Convex credential broker | ⚠️ 安全问题 | 5 个安全问题 (2 High SSRF, 1 Medium 权限, 1 DoS, 1 泄露) |
| **65589** | dreaming circuit breaker | ⚠️ P1 阻断 | **未集成到生产代码** — enforcer 写了但没调用 dreaming.ts |
| **65554** | Media support v2 | ❌ 拒绝 | P0 命令注入 + P0 XSS + P1 sandbox escape |
| **65555** | crypto-bot-binance skill | ⚠️ P1 阻断 | credential 明文暴露在 process list |
| **65567** | telegram hashText guard | ⚠️ 不完整 | Greptile: emitSystemStatus 仍会 crash |

---

## 三、代码文件区交叉 (最近修改路径 + Open Issues)

| 文件路径 | 相关 Issue | 备注 |
|----------|-----------|------|
| `src/agents/pi-embedded-runner/run.ts` | #65602, #65600 | reserveTokens / totalTokensFresh 问题 |
| `extensions/memory-core/src/dreaming.ts` | #65550 | 需集成 circuit breaker |
| `src/gateway/server-methods/send.ts` | #65577 (安全 PR) | 需注意 MEDIA directive 解析安全 |
| `extensions/mcp-stdio/src/mcp-stdio.ts` | #65525 | NODE_OPTIONS 继承问题 (已修复) |

---

## 四、建议的下一步候选人 (按优先级排序)

### 🎯 首选: #65600 - totalTokensFresh 永远为 true
- **可修性:** M
- **难度:** 需理解 agent-runner 状态机
- **影响:** pre-flight compaction 永不触发，上下文无限增长
- **修复思路:** 在 pre-flight check 消费 totalTokensFresh 后重置为 false

### 🎯 次选: #65602 - reserveTokens 被覆盖
- **可修性:** M
- **难度:** 需理解 settingsManager 与 resourceLoader 生命周期
- **影响:** 用户配置的 reserveTokens 被 SDK 默认值覆盖
- **修复思路:** 在 resourceLoader.reload() 后重新应用 config overrides

### 🎯 三选: #65578 - Kilo Gateway 模型发现
- **可修性:** S
- **难度:** 只需检查模型发现逻辑的 filter
- **影响:** 无法使用 Kilo 其他模型
- **修复思路:** 检查 auto-discovery 返回逻辑

---

## 五、特别关注

### Token Usage Regression (2026.4.9+)
- #65602 和 #65600 都是 2026.4.9+ 的 compaction/regression
- 都影响 token 管理逻辑，可能导致上下文失控
- **建议优先处理**

### Discord 重复消息
- #65581 - Agent emits duplicate Discord messages on every response
- 用户未提供详细日志，但问题明确

---

**报告生成完成**  
**下次扫描建议:** 24 小时后，重点关注 #65600/#65602 修复进展