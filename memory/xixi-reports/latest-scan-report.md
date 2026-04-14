# 全量扫描报告 2026-04-14 22:50 CST (14:50 UTC)

**第99轮扫描** | Scan UUID: `6d35b411-e65c-4253-bcf4-cb20bb2f030a`

---

## GitHub Issues（方向1）

**过去2小时内新发现 40+ open issues**，重点候选：

### 🔴 Regression / Critical
- **#66591** `[Bug]: lossless-claw context engine factory returned invalid ContextEngine: info.id must match registered id "lossless-claw"` — **regression**，14:09 UTC，0评论未认领。2026.4.14 引入，上来就崩。
- **#66601** `OpenClaw v2026.4.14 causes repeated context engine errors and breaks usability` — 14:24 UTC，与 #66591 同簇
- **#66608** `Bug: Z.ai glm-4.6v vision model always aborts with 'Request was aborted'` — 14:27 UTC，SIZE S，provider 特定

### 🟡 新 Bug（SIZE S，可修）
- **#66618** `Scoped npm packages from ClawHub fail to install with ENOENT` — **14:51 UTC**，SIZE S。ClawHub 安装 scoped 包（如 `@clawhub/skill-*`）时路径解析失败。需要检查 `openclaw plugins install` 的 npm install 逻辑。
- **#66614** `[Bug]: Block streaming splits markdown tables into separate Telegram messages` — **14:44 UTC**，SIZE S，**已有 PR #66568 在修**（14:55 UTC 更新）。PR 覆盖，无需重复追踪。
- **#66611** `[Bug]: Browser attachOnly profile fails to connect despite Chrome running with CDP` — 14:38 UTC，SIZE S+B
- **#66607** `[Bug]: Control UI: thinking dropdown shows Default (low) even when effective/configured default is adaptive` — 14:27 UTC，SIZE S
- **#66573** `[Bug]: chat.history limit=2000 exceeds server maximum of 1000, no retry` — 已在 P60101 追踪
- **#66581** `toolsAllow parameter not forwarded to runEmbeddedAttemptWithBackend` — 13:56 UTC，SIZE S，**新根因发现**：config 解析正确但 backend 未接收参数
- **#66579** `[Bug]: WhatsApp auto-reply ignores plugin hooks (message_sending cancel / before_dispatch handled)` — 13:55 UTC，SIZE S+B
- **#66588** `[Bug]: Browser plugin fails to launch on Raspberry Pi 5 (ARM)` — 14:04 UTC，regression

### 🟢 Feature Requests
- **#66577** `[Feature]: Add optional hard context truncation mode` — 13:50 UTC
- **#66576** `[Feature]: Configurable workspace file inclusion/exclusion (bootstrapFiles)` — 13:49 UTC

### 已覆盖无需重复追踪
- #66614 → PR #66568 已覆盖
- #66573 → P60101 已追踪
- #66540 → PR #66562 已覆盖
- #66549 → PR #66559 已覆盖

**本轮最高优先级新候选**：**#66618**（ClawHub scoped npm ENOENT，SIZE S，路径解析清晰，aoao 可直接接单）

---

## 插件仓库（方向2）

### Tencent/openclaw-weixin
- **Issue #65** `微信消息接收乱序` — 24小时内新；已在 P60113 追踪
- **PR #63** `fix: preserve quote context (ref_msg) for voice messages` — 已在 P59960 追踪
- **PR #62** `fix: voice message SILK/MP3/OGG format support` — 持续追踪
- **PR #58** `chunkMode for outbound` — 持续追踪
- 其余 PR/issue 本轮未见显著状态变化

**方向2 无重大新发现**，weixin 插件代码不可见，外部 issue 追踪已达上限。

---

## 贡献者文件区域（方向3）

**扫描末段贡献者**：Lukavyi（15 commits）、velvet-shark、joelnishanth、jnMetaCode、akyourowngames、neist（均与 Lukavyi 重叠）、AaronLuo00（es/ 翻译+代码）、sallyom（19 commits，文件获取失败）、mbelinky/cpojer/vignesh07 等（文件获取 API 限流）

### Lukavyi 文件区：
- `src/auto-reply/reply/get-reply.ts`（含 SecretRef fallback 修复，关联 issue #45838）
- `extensions/telegram/src/bot-message-dispatch.ts`（关联 #66588 Raspberry Pi Telegram）
- `src/config/schema.help.ts`、`src/config/schema.labels.ts`
- 大量 docs/ 文件（与贡献者无关，系 Lukavyi commit 附带更新）

### AaronLuo00 文件区：
- `src/auto-reply/reply/commands-context-report.ts`
- `src/utils/cjk-chars.ts`（中文处理工具）
- `packages/memory-host-sdk/src/host/internal.ts`
- 大量 `docs/es/*`（西班牙语翻译）

**相关 open bugs**：未发现 Lukavyi/AaronLuo00 文件区与当前 open issues 有强关联。auto-reply 文件区与 #66579（WhatsApp auto-reply）无关（不同 channel）。

**方向3 无新的高优先级可行动发现**。

---

## 追踪 PR 反馈（方向4）

### maintainer 新评论（本轮）
方向4 第124轮记录（P60114）：
- **PR #66575**（webchat filter heartbeat）：maintainer P1×2 指出 dry-run 分支没有调用 `runMessageAction` 导致 result 缺少必需字段；aborted 逻辑误判 stop reason
- **PR #66574**（lifecycle:end event）：maintainer P2 指出 MediaPaths 和 MediaTypes 独立过滤可能导致 index 不对齐

→ **需要 aoao review 这两条 maintainer 反馈**

### 新 PR（本轮）
- **#66617** Skills watcher fix for macOS（14:52 UTC，SIZE S）
- **#66615** fix(gateway): chat.history limit 1000→2000（14:48 UTC，SIZE L）
- **#66613** fix(gateway): explicit error on non-image attachments（14:44 UTC）
- **#66568** fix(streaming): prevent block chunker from splitting markdown tables（14:55 UTC，SIZE M）→ **直接对应 issue #66614，PR 覆盖后 issue 可关闭**
- **#66594** fix(gateway): register chat run on agent start（14:24 UTC）
- **#66583** feat(memory-core): dreaming.model config（14:06 UTC）
- 其余多个 SIZE XS/S small fixes

### PR #66568 直接覆盖 issue #66614
PR #66568 `fix(streaming): prevent block chunker from splitting markdown tables`（SIZE M，14:55 UTC 更新）与 issue #66614 完全对应，**建议确认 PR merge 后关闭 issue #66614**。

---

## 结论

**本轮最高优先级**：
1. **#66618**（ClawHub scoped npm ENOENT，SIZE S）— 路径解析清晰，建议 aoao 接单
2. **#66591**（lossless-claw factory regression）— regression，14:09 UTC 新鲜，0评论，需立即关注
3. **方向4 maintainer 反馈**：PR #66575 / #66574 有未处理的 maintainer P1/P2 评论，需 aoao review

**inProgressFixes**：无（xixi 只负责扫描发现，修复由 aoao 执行）

**本轮新发现 SIZE S 候选**：
- #66618（ClawHub ENOENT）
- #66581（toolsAllow 不转发）
- #66579（WhatsApp hook 忽略）
