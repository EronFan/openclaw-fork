# 全量扫描报告 2026-04-15 10:40 CST

## GitHub Issues（方向1）
**发现了 10 个新候选**

### 🔴 S级（建议立即接单）
- **#66940** MCP Accept header 缺失 — streamable-http MCP 请求缺少 `Accept: application/json, text/event-stream`，导致模型端无法正确解析响应；curl 可直接复现；修复只需在 headers 中加一行；根因清晰
- **#66916** Slack regression 4.14 — 审批按钮对长命令失效；同一 regression 在不同 reporter 处独立报告；approval 逻辑在 4.14 被改动；需 review 相关 commit
- **#66895** modelOverrideSource="auto" 持久化无 TTL — auto-failover 写入 override 后永不清除，重启/reset 也不生效；guard 只保护 user source，auto source 无保护机制；长期污染配置

### 🟠 B级（建议 aoao 接单）
- **#66925** memory plugin 覆盖问题 — `registerMemoryCapability` 使用直接赋值而非合并，`publicArtifacts` 被覆盖导致 wiki bridge 返回 0 条目；覆盖 vs 合并语义错误
- **#66886** gateway 内存泄漏 — 长跑 gateway RSS 持续增长；疑似未关闭 handle 或全局状态累积；需要 heap snapshot 对比定位
- **#66885** Telegram event loop 冻结 — regression 4.12；undici HTTP/2+IPv6 在 Windows 上每 10-12min 冻结 90-200s；web_fetch 在 4.7 已修复但 Telegram polling 未应用
- **#66936** CLI SecretRef + hang — `buildProviderStatusIndex()` 无法解析 SecretRef 导致 agents list 失败；所有 agents 子命令完成后进程不退出（unclosed handles）

### 🟡 C级
- **#66937** lmstudio 误要求 api key — 本地 LM Studio 不需要 api key，但 provider onboarding 强制要求；local provider 判断逻辑有误

### 🟢 XS级
- **#66934** Webchat sender label 显示 'openclaw-control-ui' 而非 'you' — UI 小 bug；input 字段与 chat window 状态不同步

---

## 插件仓库（方向2）
**openclaw-weixin 仓库不存在（404）**，扫描无结果

其他相关插件仓库（openclaw-* organization）未单独扫描，超出本次范围。

---

## 贡献者文件区域（方向3）
**扫描了 10 名末段 contributors 的文件区，未发现新的未认领高优先级 bug**

末段 contributors（已排除 EronFan）：huntharo, mcaxtr, bmendonca3, jalehman, onutc, eleqtrizit, osolmaz, Glucksberg, altaywtf, quotentiroler

本轮次贡献者的最近文件区未发现新的、未被追踪的 open bug 与其重叠。

---

## 追踪 PR 反馈（方向4）
**⚡ 方向4本轮极为活跃，发现多个关键 maintainer / bot 评论**

### 活跃 PR 评论
- **#66930** (maintainer PR: fix context-engine third-party plugin graceful degradation) — openperf 开了一个 S 级 maintainer PR，2h 内无新评论，需跟进 merge 窗口
- **#66939** (fix telegram duplicate preview) — rubencu 的 PR，Greptile P2 指出 `consoleSpy` 未在 `finally` 中 restore，会泄漏到后续测试；建议要求作者修复
- **#66939** — chatgpt-codex-connector bot P1 指出 `pendingCompactionReplayBoundary` 在 queue drain 前就被 reset，compaction retry 时会重新出现 duplicate preview；P2 指出 retry 无 partial chunk 时 boundary 从未被 resolve

### 新发现（PR 上的代码质量 comment）
- `extensions/telegram/src/bot-message-dispatch.ts` — Greptile 指出 `onCompactionStart` 中 `pendingCompactionReplayBoundary` 判断逻辑重复，建议重构
- `#66930` 相关代码 — maintainer PR，Greptile 指出 test file `src/context-engine/context-engine.test.ts` 中 `consoleSpy` 需要用 `afterEach(() => { vi.restoreAllMocks(); })` 统一清理

### 项目文件状态检查
- **#66522** (Session index 重启后丢失) — 磁盘文件存在但 sessions.json 索引丢失，数据丢失级别；建议立即接单
- **#66936** (CLI SecretRef hang) — 新发现，S 级，根因清晰
- **#66937** (lmstudio api key) — 新发现，S 级
- **#66920/#66917** (WhatsApp 群消息静默丢弃) — 新发现，S regression，建议合并追踪
- **#66653** (Onboarding TypeError) — PR 已开 mergeable，建议 approve
- **#66692** (audio transcription allowPrivateNetwork) — PR 已开，Greptile P2 指出缺少 regression test，建议补充

---

## 结论
**本轮最高优先级：**

1. **[S，建议接单] #66940** MCP Accept header — 根因极清晰，1行 fix，可快速 close
2. **[S，建议接单] #66936** CLI SecretRef + hang — 两条独立 bug（解析失败+进程不退出），但根因都在 agents/index.ts
3. **[S，建议跟进] #66930** maintainer PR — context-engine graceful degradation，maintainer 亲写，需确认 merge 窗口
4. **[S，建议确认] #66937** lmstudio api key — onboarding 逻辑错误，local provider 判断缺失

**建议动作：**
- aoao 或 xixi 立即接单 #66940 和 #66936（根因已在 summary 中）
- review #66930 是否可 approve（maintainer PR，mergeable）
- #66939 的 Greptile/chatgpt-codex-connector 评论需要作者响应，建议要求作者修复 test + compaction boundary 问题
