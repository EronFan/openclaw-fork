# 全量扫描报告 2026-04-15 17:04 CST

## GitHub Issues（方向1）

本次扫描（过去 2 小时）发现 **16 个新 open issue**，其中 **5 个 regression/bug** 需重点关注：

### 🔴 Top Candidates（新发现，未追踪）

**1. #67092（S regression）— Malformed reasoning 输出泄漏进用户可见文本和持久化历史**
- URL: https://github.com/openclaw/openclaw/issues/67092
- 根因：`</think>` 标签只出现在结尾但无对应 `<think>` 开标签时，sanitizer 无法识别并清除 reasoning prose
- 影响：Ollama 环境下用户看到原始 reasoning 内容 + 写入 session .jsonl 历史
- 已有 workaround（社区提供）：取最后一个 `</think>` 后的文本作为 safe output
- 建议：立即接单，1-2行 sanitizer 增强

**2. #67093（S）— Discord channel 泄漏原始 tool call XML 语法**
- URL: https://github.com/openclaw/openclaw/issues/67093
- 根因：Gateway 在 model fallback 时绕过了 response-parsing 层，Discord provider 收到原始 `<<parameterparameter>...</function>` 标签
- 影响：Discord 用户看到系统内部 tool call 语法而非自然语言回复；Telegram 正常
- 关联：`FailoverError: No API key for google` → fallback 到 OpenRouter 触发
- 建议：立即接单，response parsing 路径检查

**3. #67084（S regression）— Active Memory ON + Codex 导致 Session Timeout Spam**
- URL: https://github.com/openclaw/openclaw/issues/67084
- 根因：Active Memory 与 Codex OAuth refresh_token 冲突，embedded run 全部 terminated
- 影响：webchat 每次 1 条消息后卡死，session 完全不可用；关闭 Active Memory 后恢复
- 建议：立即接单（与 #66848 同根，AOAO 已派出 fix）

**4. #67076 + #67074（S regression x2）— Onboarding trim TypeError 持续出现**
- #67076: https://github.com/openclaw/openclaw/issues/67076
- #67074: https://github.com/openclaw/openclaw/issues/67074
- 注意：根因已由 **PR #66653** 修复，但该 PR 至今未合并（mergeable 状态）
- 今日又出现 2 个新 reporter 独立报告同类错误（Discord onboarding + 4.12 版 QuickStart Skip for now）
- **最高优先级：催促 maintainer 合并 #66653**

### 其他新发现 bug

| Issue | 标题 | 标签 | 评估 |
|-------|------|------|------|
| #67085 | Managed HOOK.md hooks silently no-op on before/after_tool_call | - | M，建议观察 |
| #67087 | Browser tool CDP mode downloads to temp instead of configured path | bug | M，文件名/路径逻辑问题 |
| #67057 | dreaming-narrative 导致 Telegram 通讯严重阻塞 | bug | S，建议跟进（已在 P60157 区域） |
| #67088 | dashboard falsely reports "No GUI detected" on macOS with SSH_* env | bug | L，macOS 特定 |
| #67053 | TUI streaming indicator stays active after response finishes | bug | L |

---

## 插件仓库（方向2）

**发现 2 个 weixin 插件新动态：**

### weixin #53（Bug，已更新 2026-04-15 08:34 CST）
- AI 承诺设置定时提醒后，实际未创建 cron 任务，且无法通过聊天记录回忆
- 严重性：高（功能直接失效）
- 建议：跟进 #53，排查 weixin 插件定时任务注册链路

### weixin #50（Bug，已更新 2026-04-15 09:02 CST）
- openclaw 定时推送无法在微信触发
- 可能是 weixin 出站通知路由问题
- 建议：确认是入站还是出站问题

**已追踪项无变化：**
- #66（P60173 区域）：微信消息重复，maintainer 已给精确根因分析，等待 fix PR

---

## 贡献者文件区域（方向3）

扫描 bottom 10 contributors（T5-AndyML, Anandesh-Sharma, alexfilatov, Alex-Alaniz, al3mart, akoscz, Aftabbs, aaronveklabs, AkashKobal, AI-Reviewer-QS）。

**分析结论：**
- 该 10 位 contributors 贡献量极低（各 1-3 次 commit），历史 commit 几乎全部已覆盖
- 未发现新的未被追踪的 open bug 关联到这些文件区域
- 无需额外派出 fix

---

## 追踪 PR 反馈（方向4）

| PR | 标题 | 状态 | 新动态 |
|----|------|------|--------|
| **#66930** | context-engine graceful degradation | ✅ **已合并**（2026-04-15 07:02 UTC） | 3 reviews，maintainer PR，已 merge |
| **#66692** | audio transcription allowPrivateNetwork | ✅ **已合并**（2026-04-15 02:36 UTC） | Greptile P2 评论无 regression test，已 merge |
| **#66653** | Onboarding TypeError trim | 🔴 **仍 OPEN，mergeable** | **⚠️ 同根因 bug 持续出现新 reporter**；今日又出现 #67076 + #67074；**紧急催促 merge** |

**结论：**
- #66930 和 #66692 均已合并 ✅
- **#66653 是最大阻塞**：该 PR 早已 mergeable，但 maintainer 未处理，导致 trim TypeError 持续出现新 reporter

---

## 结论

**最高优先级：**

1. **🔴 #66653 紧急催促 merge** — Onboarding TypeError trim，PR 已 open 超过 1 天，mergeable 但无人处理；今日 #67074 + #67076 继续报告同根因 bug
2. **🔴 #67092（S regression）— reasoning 输出泄漏** — 1-2 行 sanitizer fix，建议立即接单
3. **🔴 #67093（S）— Discord 泄漏原始 tool call** — response parsing 路径 regression，建议立即接单
4. **🟠 #67084（S regression）— Active Memory + Codex timeout spam** — 与 #66848 同根，建议确认 aoao fix 状态

**建议：**
- 主线任务：派人接单 #67092 和 #67093（均为 regression，直接影响用户体验）
- 阻塞疏通：联系 maintainer 催促合并 #66653
