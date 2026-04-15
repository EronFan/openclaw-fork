# 全量扫描报告 2026-04-16 03:26 CST

## GitHub Issues（方向1）

**新发现 30+ open issues（近 2 小时更新）**，其中最高优先级候选：

### 🔴 最高优先级（新增）

| # | 标题 | 标签 | 分析 |
|---|------|------|------|
| **#67353** | Onboarding `trim()` crash — 无法跳过 channel selection | bug, bug:crash | 0评论；用户选 channel 或点"Skip"都崩；阻断所有新用户配置；v2026.4.14 regression；**根因：与 #67347/#67291 同簇，`trim()` 在 undefined 上调用** |
| **#67343** | TTS `[[/tts:text]]` closing tag leaks into Telegram voice note caption | 无标签 | 1评论；用户已提供精确格式证据；PR #67352（hclsys）已开修同一根因；**可立即 review + approve** |
| **#67323** | MSTeams DM messages appear duplicated in agent session context（队列重放未去重） | 无标签 | 1评论；与 P60239 完全同根；**已在追踪，合并处理** |

### 🟠 S级新增

| # | 标题 | 分析 |
|---|------|------|
| **#67237** | WhatsApp 向联系人发送错误消息（内部 reply 路由到 contact） | 隐私安全事故；用户证据具体；与 P60237 不同角度（行为 bug vs 安全权限）；**确认 P60237 已覆盖此簇** |
| **#67342** | BlueBubbles: `runtime not initialized` on gateway startup (v2026.4.14) | bug+regression；v2026.4.14 新引入；0评论 |
| **#67340** | ElevenLabs TTS Telephony mode: hardcoded Accept header conflict | TTS delivery bug；PR #67349（ViseonDev）已修；**可 review** |
| **#67336** | macOS Remote over SSH rewrites browser path to discovered ws:// host URL | bug:crash；browser 功能完全破坏；0评论 |
| **#67334** | Ollama timeout persists after updating to 2026.4.14 | bug+bug:crash；embedded agent session timeout；0评论 |
| **#67296** | Memory Consolidation overwrites Dreaming output in `memory/YYYY-MM-DD.md` | memory/dreaming 冲突；0评论；与 #65834 相关 |
| **#67295** | `openclaw agents add` writes wrong baseUrls — 同时破坏 OpenRouter/Arcee/OpenAI-Codex/GitHub Copilot | 跨多个 provider 的配置写入 bug；0评论 |
| **#67288** | amazon-bedrock-mantle 缺少 `config.discovery.enabled` gate | bug；**PR #67311（hclsys）已修**；也可 review |

### 其他新增（已覆盖/无需追踪）

- **#67347**: `trim()` TypeError — 同 #67353 根因，无需重复追踪
- **#67291**: Onboarding `trim()` crash — 同 #67353 根因，无需重复追踪
- **#67352**: PR fix TTS closing tag leak — **review 机会**

---

## 插件仓库（方向2）

**Tencent/openclaw-weixin**：发现 18 个 open issues

### 新发现（近 2 小时）

| # | 标题 | 分析 |
|---|------|------|
| **#70** | IMA Knowledge Base: cannot read note content — returns 210005 not author error | 已追踪为 P60220；更新于 2026-04-15T14:46:11Z；**状态待确认** |
| **#69** | getUpdates 返回 errcode=-14 的情况咨询 | 功能咨询，非 bug |
| **#68** | 微信消息接收乱序（网页端能收到，微信收不到） | 已追踪为 #65（P60113）；无新进展 |
| **#66** | 微信消息重复（用户发1条，openclaw 处理并回复2次） | 已追踪为 P60173；根因已定位（ACK 机制缺失） |
| **#53** | AI承诺设置定时提醒后未创建 cron 任务 | 已追踪；更新于 2026-04-15T08:34:22Z |

### 结论
WeChat 插件 issue 列表无重大新变化；已有追踪项（#66 ACK 问题、#70 IMA 问题）状态无更新。

---

## 贡献者文件区域（方向3）

**Bottom 10 contributors（近 100 名，排除 EronFan）：**

| 排名 | Login | Commits | 备注 |
|------|-------|---------|------|
| 1 | chilu18 | ~11 | 新发现，历史无追踪 |
| 2 | sliverp | ~10 | 新发现 |
| 3 | clawdinator[bot] | ~10 | Bot，自动忽略 |
| 4 | **lml2468** | ~10 | ⚠️ **历史高频出现在 P59907/P59897/P59898**（compaction/memoryflush、gateway restart、OOM/memory泄漏）；本轮无新 commit |
| 5 | Whoaa512 | ~10 | 新发现 |
| 6 | darkamenosa | ~9 | 新发现 |
| 7 | BruceMacD | ~9 | 新发现 |
| 8 | **davidrudduck** | ~9 | ⚠️ **历史出现在 P59894/P59907**（timeout-compaction、memory flush）；本轮无新 commit |
| 9 | pandego | ~9 | 新发现 |
| 10 | joaohlisboa | ~9 | 新发现 |

**分析**：
- lml2468 和 davidrudduck 历史 commit 均命中高风险代码区（compaction/gateway/memory），但本轮 API 未检出新 commit
- 其余 8 人为本轮新出现的末段贡献者，commit 数量极少（9-11），建议下次扫描取更多页（如 300）后取真实末段 10 人
- 本轮无新文件区可关联到 open bug

---

## 追踪 PR 反馈（方向4）

### 关键 PR 状态

| PR | 追踪项 | 本轮状态 | 分析 |
|----|--------|---------|------|
| **#67279** | P60221 WhatsApp harden creds saves | ⚠️ **mergeable=UNKNOWN，Greptile COMMENTED** | 已持续追踪；Greptile 评正面但 maintainer 未 review；**mergeable 显示 UNKNOWN**（可能 CI 未通过或 branch 有冲突）；建议确认 |
| **#67277** | P60222 context-window Tighten | Takhoffman maintainer 主动响应 review feedback | 接近 merge 窗口 |
| **#67281** | P60223 dedupe exec.finished node events | ⚠️ Security review 待确认 | aisle-research-bot 报 Medium DoS 问题；Greptile 评正面；**需确认已解决才能 merge** |
| **#67352** | TTS closing tag leak (#67343) | **刚创建**（hclsys） | ⚡ 修复方向正确；review 成本低，建议立即 approve |
| **#67330** | heartbeat model bleed (#67314) | **刚创建**（shahyashish） | 追踪项 P60238 有外部 PR；需确认 fix 质量 |
| **#67329** | memory-wiki 0 artifacts (#67327) | **刚创建**（shahyashish） | 新发现；与 memory consolidation 问题相关 |
| **#67318** | Discord raw tool call leak (#67093) | **刚创建**（joelnishanth） | 已追踪 P60175；修复者来自末段 contributor（14 commits） |
| **#67311** | amazon-bedrock-mantle discovery gate (#67288) | **刚创建**（hclsys） | 已追踪 P60240；修复者活跃 |
| **#67349** | ElevenLabs TTS Accept header (#67340) | **刚创建**（ViseonDev） | 新发现；修复及时 |

### 结论
**#67279 长期未 merge（mergeable=UNKNOWN）** 是最大阻塞；外部 PR 生态活跃（2小时内 14+ 新 PR），但我们的追踪 PR 无推进。

---

## 结论

### 最高优先级

1. **🔴 P60237/#67237 WhatsApp 安全事故**：内部 reply 被误发到外部 contact——这不是"使用困难"，是隐私安全事故。Artyomkun 已标记为安全事件并 @ 负责人，但未见 fix。**建议立即派出 aoao 接单**。

2. **🔴 #67353 Onboarding trim() crash**：0评论，阻断所有新用户配置。已有 PR #67347 在修同根因。**建议 review 确认是否完整覆盖**。

3. **⚡ #67352 PR review**：TTS closing tag leak，hclsys 已提 PR，修复方向正确，size 小。**建议立即 approve 推 merge**。

4. **⚠️ #67279 mergeable=UNKNOWN**：WhatsApp harden creds 长期未 merge，Greptile 已 approve 但 maintainer 无响应。**需确认 branch 状态**。

### 建议

- **立即 review**：#67352（TTS leak）、#67318（Discord leak，关联 P60175）
- **确认 #67279 branch 状态**：mergeable UNKNOWN 原因不明
- **方向3**：下次取更多 contributors 页数（300+）以找到真实底部 10 人
- **xixi 链路**：本轮 gh API 访问正常，但 heartbeat 显示 72 次 AxiosError(400)，说明 subagent 侧网络仍有问题；主会话侧正常
