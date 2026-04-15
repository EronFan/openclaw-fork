# 全量扫描报告 2026-04-15T05:00:00Z (第131轮 · 北京时间 13:00)

---

## GitHub Issues（方向1）

**本轮发现 20+ 个新 open issues，其中高优先级候选：**

### 🔴 最优先（建议立即接单）

**#66978 `sessions_spawn(mode="run")` regression — 孩子干完活，爹不知道**
- 标签：`bug` + `regression`
- 问题：`sessions_spawn(..., mode="run")` 子进程 Claude Code 工作完成并产出结果，但父 session 超时不获 final completion payload
- 影响：父 session 无感知孩子完成，可能无限等待或误判失败；mode="run" 设计为一次性，结果丢失是根本性违背
- 根因：child 完成事件没有传回父 session 的 completion relay
- ✅ **已在 fix-66978 追踪（从 heartbeat-state 确认派单）**

**#66963 agent crashes on startup — `ReferenceError: Cannot read properties of undefined (reading 'trim')` in `buildPollSchema`**
- 标签：`bug` + `bug:crash`
- 问题：Gateway 启动时 crash，完全无法启动
- 优先级：S-crash
- 5 分钟前新鲜报告

**#66971 exec 内部 hardcodes `security=allowlist`，绕过全局 config**
- 标签：无标签（漏标）
- 问题：`queue-health/surge-plan` exec 调用硬编码 `security=allowlist`，全局 `plugins.allow` / `exec.security` 配置被绕过
- 影响：安全边界失效；任何能触发该 exec 路径的 input 都能以 allowlist 权限执行
- 建议：**安全 S 级**，建议加 bug 标签 + regression 标签

### 🔴 Regression 簇（Telegram 命令菜单，2026.4.14）

**#66975** Telegram bot commands disappear after upgrading to 2026.4.14
**#66950** Telegram native command menu disappears after upgrade to 2026.4.14 (323493f)
**#66958** Telegram native command menu can be cleared on startup because runtime command registration resolves to an empty list
**#66916** Malformed tool calls on longer requests for approval button on Slack + sessions.resolve fails on Slack user ID

- 这 4 条中 #66975 和 #66950 高度疑似同一 regression（独立 reporter 确认）；#66916 是 Slack 端同类问题
- PR 覆盖情况：#66939 (maintainer, Telegram 修复) 刚 merge，#66932 (maintainer, Telegram 自动完成 reaction) 新开
- ⚠️ **需确认 #66939 是否完全覆盖 #66975/#66950，或有遗漏场景**

### 其他重要候选

**#66982** Exec completion relay creates orphan sessions with missing result context
- S 级 bug；orphan session 累积导致内存泄漏

**#66981** Browser failed: timed out — Gateway restart required
- 标签：`bug` + `bug:behavior`
- macOS 用户报告

**#66977** sqlite-vec extension cannot load on macOS — OMIT_LOAD_EXTENSION
- S 级 bug；向量搜索完全不可用

**#66973** `sessions_spawn` defaults to thread-bound persistent mode, turning one-shot tests into permanent bindings
- 行为 bug；mode="run" 应该一次性，但默认变成 persistent

**#66967** `skills.update` echoes raw apiKey and env secrets in gateway response
- **安全问题**，secrets 明文泄漏在 skills.update 响应中
- ✅ PR #66986 已 merge（mask secrets in skills.update response）

**#66952** openai-codex OAuth refresh race — shared refresh token invalidation + models status misreports expired Codex profiles as OK
- S 级 bug；涉及 token 竞态 + 状态误报

**#66957** `models.mode="replace"` still triggers implicit provider discovery + startup delays
- S 级 bug:behavior

**#66946** Control UI 路径重复导致 404 错误（中文标题）
- S 级 bug:behavior

**#66945 / #66942** `TypeError: Cannot read properties of undefined (reading 'trim')` — 多处
- crash 级别

**#66968** ✅ 已 merge — style: apply oxfmt formatting to 16 files（maintainer）

**#66980** ✅ 新 PR — fix(theme): accessibility tweaks for Matrix/Cyberpunk (size:L) — 需 review

---

## 插件仓库（方向2）

**Tencent/openclaw-weixin 发现 2 个 open issues：**

**#68** 上传媒体文件到 CDN 时报 500 超时时的优化
- 更新时间：2026-04-15T04:49:44Z（约10分钟前）
- 无标签；功能优化请求，非 crash
- 建议：低优先级，确认是否有已有 PR 覆盖

**#66** 微信消息重复（用户发1条 → openclaw 回复2次）
- 更新时间：2026-04-15T04:01:07Z
- ✅ **已在 P60173 追踪**；maintainer 已给精确根因分析（ACK 机制缺失）
- 状态：待修复 PR

**已确认修复完成（方向2）：** openclaw-weixin #49 fix: preserve quote context for voice messages — **PR 已 merge（maintainer）**

---

## 贡献者文件区域（方向3）

**扫描底部 10 位 contributor（均 <80 contributions，排除 EronFan）：**
- quotentiroler (45), altaywtf (54), Glucksberg (59), osolmaz (63), eleqtrizit (64), onutc (67), jalehman (68), bmendonca3 (69), mcaxtr (69), huntharo (70)

**结果：10 位 contributor 最近 20 条 commit 全部为空**（近期无活跃 commit）

✅ **无新文件区可分析；无需追踪**

---

## 追踪 PR 反馈（方向4）

**本轮新 merge 的 maintainer PR：**
- ✅ #66987 (maintainer) — fix: avoid running native pnpm binaries through node（安全 fix）
- ✅ #66986 (maintainer) — fix: mask secrets in skills.update response（安全 fix，已合并）
- ✅ #66969 (maintainer) — fix(openai-codex): default undefined model.api to openai-codex-responses
- ✅ #66985 (agents) — fix(agents): resolve requestedNode to canonical ID before boundNode comparison
- ✅ #66948 (memory-core) — fix(memory-core): default dreaming storage to "separate"
- ✅ #66966 (mcp) — fix(mcp): add required Accept header for streamable-http transport

**本轮新 open PR（需追踪）：**
- #66987 (maintainer, size:S) — pnpm binaries security fix，刚 merge
- #66939 (maintainer, size:M) — Telegram duplicate preview fix，刚 merge
- #66980 (size:L) — theme accessibility，需要 review

**当前心跳追踪状态：**
- 8 个 fix 在 progress（fix-66978、fix-66937、fix-66940 等）
- ⚠️ **lastPrCreatedAt: null** — 尚无 PR 创建落地
- fix-66937 commit 完成但 push 失败（403）

---

## 结论

**最高优先级：**

1. **🔴 #66978 sessions_spawn regression**（mode="run" 孩子完成爹不知道）— 新 regression，S 级，影响核心功能正确性，**建议立即派单**

2. **🔴 #66971 security: hardcoded security=allowlist** — 安全边界被绕过，**建议立即确认并加 bug 标签**

3. **🔴 #66963 buildPollSchema ReferenceError crash** — Gateway 启动即崩，S-crash，**建议优先派单**

4. **⚠️ Telegram 命令菜单 regression 簇**（#66975/#66950/#66958）— 需确认 #66939 merge 是否完全覆盖，建议快速验证

**建议：**
- 本轮有多个安全 fix 已 merge（#66987、#66986、#66969），安全交付良好
- heartbeat 显示 fix 全部还在 progress 阶段，无 PR 落地；需确认阻塞原因（build kill / push 403）
- MCP Accept header fix（#66966）已 merge，方向2方向1均有覆盖，👍
