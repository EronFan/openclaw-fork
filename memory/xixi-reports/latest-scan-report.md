# 全量扫描报告 2026-04-13 15:28 CST / 07:28 UTC

## GitHub Issues（方向1）

**本轮扫描范围**: issues #65701–#65779（上次覆盖至 #65779 第117轮 14:23 CST）

**新发现**: 13 个 open issues（部分已被 PR 覆盖）

### 最高优先级（建议立即行动）

1. **#65721 🔥 BETA BLOCKER** — agents can self-destruct through configuration modification
   - agent 可写无效字段到 `~/.openclaw/openclaw.json`，导致 gateway 启动失败
   - 需 `openclaw doctor --fix` 手动恢复；影响 2026.4.9+ 所有用户
   - **建议：aoao 优先接单**

2. **#65706 🔥 BETA BLOCKER** — `nodes status` 和 `nodes list` 不 sync
   - `node.paired` 字段处理不当导致 regression
   - PR [#65772](https://github.com/openclaw/openclaw/pull/65772) 已在修（M 级），但有 3 个 maintainer review comments（P1+P2×2）
   - **建议：持续盯 PR merge 前 review 机会**

3. **#65701 regression** — Telegram provider 重复发送每条响应
   - bug+regression 双标签；用户对话完全不可用
   - **建议：aoao 接单**

4. **#65740 regression** — Chrome CDP websocket unreachable macOS ARM64
   - 2026.4.10；可能与 #65208/#65204 同根
   - **建议：aoao 接单**

### 已确认有 PR 覆盖（可快速确认）

| Issue | PR | Size | 状态 |
|-------|-----|------|------|
| #65768 minimax OAuth token | [#65779](https://github.com/openclaw/openclaw/pull/65779) | XS | 今日提交 |
| #65760 fallbackRetryPrompt 丢弃 prompt | [#65778](https://github.com/openclaw/openclaw/pull/65778) | XS | 今日提交 |
| #65751 Slack manifest box chars | [#65773](https://github.com/openclaw/openclaw/pull/65773) | XS | 今日提交，review 进行中 |
| #65769 active-memory qmd collection not found | 上轮已覆盖 | S | 根因 backend-config.ts inode/case |

### 建议跟踪（暂未认领）

- #65775 active-memory: `allowedChatTypes` 丢弃 `"explicit"` sessions（behavior bug，S 级）
- #65747 Dingtalk Stream mode failure（钉钉插件，0评论）
- #65744 Feishu DM response 截断泄露群聊（regression）
- #65734 session_status imports missing runtime path（beta 1，0评论）
- #65733 safeRealpathSync Windows 20分钟（regression）
- #65728 gateway run unauthorized regression
- #65705 Dreaming sweep 每 heartbeat 重复触发（已有 PR）

---

## 插件仓库（方向2）

**扫描 Tencent/openclaw-weixin**

### 新发现: 4 个

| # | 标题 | 优先级 | 备注 |
|---|------|--------|------|
| [#58](https://github.com/Tencent/openclaw-weixin/pull/58) | feat(messaging): chunkMode outbound text | 新功能 | PR 已开，2026-04-13 最新 |
| [#57](https://github.com/Tencent/openclaw-weixin/issues/57) | unable to uninstall（Error: zod module + duplicate plugin id） | S | 持续 open |
| [#54](https://github.com/Tencent/openclaw-weixin/issues/54) | 图片查看功能不可用（sharp 模块缺失） | M | 持续 open |
| [#55](https://github.com/Tencent/openclaw-weixin/issues/55) | ACP thread binding for WeChat | feat | PR #56 在修 |

---

## 贡献者文件区域（方向3）

**扫描**: 14 名低末段贡献者（scoootscooob / github-actions[bot] / Sid-Qin / BunsDev / joshp123 / huntharo / mcaxtr / bmendonca3 / onutc / jalehman / osolmaz / Glucksberg / altaywtf / eleqtrizit / quotentiroler）

**结果**: 所有 14 个账号在 `openclaw/openclaw` 本仓库均无 commit 记录（可能 commits 在 fork 或其他仓库）

**无新发现**

---

## 追踪 PR 反馈（方向4）

### Maintainer Review 新增 comments（本轮重点）

**PR #65773**（fix: Slack JSON manifest box chars，XS）— 2 个新 review：
- **greptile-apps P1**: manifest 在 env-shortcut 路径仍被打印（`SLACK_BOT_TOKEN+SLACK_APP_TOKEN` 命中时未跳过 prepare）
- **chatgpt-codex-connector P2**: manifest 应用 `console.log` 而非 WizardPrompter，session-based 客户端丢失 in-flow payload

**PR #65772**（fix: nodes list/status sync，M）— 3 个新 review：
- **greptile-apps P2×2**: `"unauthorized"` fallback 未 scope 到 method + 重复 `node.list` 调用可合并
- **chatgpt-codex-connector P1**: `node.paired` 硬性要求导致无该字段时全量过滤（regression 根因）

**PR #65771**（cron errorReason schema，S）— 2 个新 review：
- **greptile-apps P1**: `CronFailoverReasonSchema` 缺 `"auth_permanent"` / `"overloaded"` / `"session_expired"`（暴露协议 gap）
- **chatgpt-codex-connector P2**: `resolveFailoverReasonFromError` 返回值可能超出 schema 范围

### 持续追踪状态
- PR #65574（MCP stdio proxy）：author 连续 5 个 fix commits，仍接近可 merge
- PR #65577（OutboundPayloadPlan size:L）：maintainer 等待 review
- PR #65750/65752：最新 fix PRs

---

## 结论

**本轮最高优先级**：

1. 🔥 **#65721 agents self-destruct through config modification** — BETA BLOCKER，根因明确，建议 aoao 立即接单
2. 🔥 **#65706 nodes status/list 不 sync** — BETA BLOCKER，PR #65772 在修，持续盯 maintainer review 走向
3. 🔥 **#65701 Telegram 重复消息** — regression 未认领，建议 aoao 接单
4. ⏸️ **PR #65772** — 3 个 maintainer P1/P2 review，建议等 author 修复后再 Approve

**建议快速行动项**：
- 确认 PR #65779（minimax OAuth）和 PR #65778（fallbackRetryPrompt）可 merge → 推 Approve
- 评估 #65721 的 config validation guard → aoao 接单
- PR #65773 有两个反向 review（console.log vs WizardPrompter），需 author 澄清后再判断
