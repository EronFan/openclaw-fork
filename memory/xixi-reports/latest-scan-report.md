# 全量扫描报告 2026-04-15 12:21 UTC (20:21 CST)

## GitHub Issues（方向1）

**新发现 17 个候选**（最近 2 小时共 22 个 open issues/PRs 更新），重点候选：

### 🔴 Top Candidate: #67173 S级 — Queued messages silently dropped after agent run timeout
- **描述**：Agent run 超时终止后，队列中的消息被静默丢弃（`queueDepth=1` 但无 `scheduleFollowupDrain` 调用）
- **根因**：`surface_error` failover path 未调用 followup drain；`FOLLOWUP_QUEUES` Map 为纯内存，服务重启丢失
- **影响**：用户体验极差——发送消息无响应，且无任何错误提示，需手动发消息才能恢复
- **触发场景**：Telegram topic + Bedrock Claude Opus 4.6 + `timeoutSeconds: 1800` + `maxConcurrent: 12`
- **报告质量**：极高（含完整 timeline + 分析 + 修复方向）
- **行动**：立即派出 subagent 复现并修复

### 🔴 #67171 S级 — config set strips `${VAR}` substitution sentinels（安全相关）
- **描述**：`openclaw configure` / `config set` 将 resolved 值写回磁盘，导致环境变量占位符被还原为明文 secret
- **根因**：写路径从 in-memory resolved config 序列化，而非 source view
- **影响**：operator 刻意用 `${VAR}` 隐藏 secret 的努力白费，secret 以明文进入 `openclaw.json` 和备份
- **报告质量**：极高（含 diff 示例 + 相关安全 issue #62438）
- **建议**：接单，修复方向明确（维护 source view 并行）

### 🔴 #67172 S级 — Cron classifier sets status=ok on denial tokens
- **描述**：Cron run 的 summary 含 `SYSTEM_RUN_DENIED` 等拒绝令牌，但 `status` 仍为 `ok`
- **根因**：`resolveRunOutcome` 只检查 `hasFatalErrorPayload`，不看 summary text
- **影响**：监控集成看到 green cron 实际已失败，operator 无法感知
- **报告质量**：极高（含 token 列表 + 相关 issue #65950 #65988）
- **建议**：接单，1 token 匹配列表 + 在 finalize 前加检查

### 🔴 #67168 S级 regression — logging.file config not applied
- **描述**：`logging.file` 配置被读取但未应用，日志仍写 `/tmp/openclaw/` 而非配置的路径
- **根因**：文件 logger 在读取配置前初始化，之后不再切换
- **影响**：用户配置日志路径完全无效，关键日志可能丢失
- **报告质量**：高（含验证步骤和日志对比）
- **建议**：接单，1行 fix

### 🟠 #67162 S级 regression — TypeError on undefined trim (channel selection)
- **描述**：空标题 bug，根因是 `path.trim()` 在 undefined 上调用
- **用户已自修复**：`sed` 补丁给出，但 regression 仍在，需正式 PR
- **建议**：确认 patch 对应源码位置，补自动化测试

### 🟠 #67170 S级 — talk-voice audio delivery failure to Telegram
- **描述**：ElevenLabs 生成的音频无法送达 Telegram，ffmpeg 已安装，无明确 error
- **根因**：不明确，需进一步调查
- **报告质量**：中（环境信息完整但缺 error 日志）

### 🟡 #67158 S级 regression — openai-codex gpt-5.1/5.2/5.3 rejected on OAuth
- **描述**：ChatGPT/Codex OAuth 仅 gpt-5.4 可用，gpt-5.1/5.2/5.3 均被 403
- **建议**：确认是否 Cloudflare bot 拦截

### 🟡 #67152 B级 — memory-core dreaming uses request-scoped subagent outside gateway request
- **描述**：dreaming narrative 生成在 gateway request 作用域外，导致 fallback generation + cleanup warnings
- **建议**：中优先级，建议 aoao 接单

### 🟡 #67151 S级 regression — Discord inbound messages containing `https` stripped
- **描述**：Discord 消息含 `https` 时被剥离，URL 不到达 agent
- **建议**：回归检查

---

## 插件仓库（方向2）

**无新发现**。openclaw-weixin 为私有仓库，无公众可见 issue。

---

## 贡献者文件区域（方向3）

扫描排名最低 10 位贡献者：
- `sliverp`(10), `clawdinator[bot]`(10), `Whoaa512`(10), `lml2468`(10), `anonymous`(10), `anonymous`(11), `aether-ai-agent`(11), `chinar-amrutkar`(11), `MoerAI`(11), `christianklotz`(11)

**结果**：无。
- 7/10 为 anonymous/bot 账号，API 无法查询其 commit
- 3/10（sliverp, MoerAI, Whoaa512, lml2468, chinar-amrutkar, christianklotz）在 `gh api --author=` 查不到 openclaw repo commits（可能是脚本/PR 作者而非直接 committer，或贡献在 fork 中）

---

## 追踪 PR 反馈（方向4）

**无新 maintainer 评论**（最近 2 小时内 PR 评论均来自历史 PRs，无最近活跃 PR 的新评论）。

**已追踪 PR 状态**：
- #67169（fix telegram command menu clearing）— 刚更新，open 状态
- #66958 关联，Linux2010 提交
- heartbeat `lastPrCreatedAt: 2026-04-15T11:04:32Z`（#67099 已 merge）
- 最近 2 小时新提 PR：#67169 #67163 #67159 #67157 #67156 #67155 #67153 #67149 #67148 #67147 #67146 #67145 #67144 #67143 #67142 #67137 等，均为 XS-S 级 fix/feat

---

## Top Candidate 派出

**立即派出 subagent 修复 #67173**（Queued messages dropped after agent run timeout）。

根因线索：
1. `scheduleFollowupDrain` via `finalizeWithFollowup` 在 `surface_error` path 未被调用
2. `FOLLOWUP_QUEUES` Map 为纯内存，需配合 `resetAllLanes()` 保全 command lane queue 的模式
3. 修复点：`embedded run timeout` 终止后，加一条 `scheduleFollowupDrain` 调用

**inProgressFixes**: fix-67173
