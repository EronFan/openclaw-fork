# OpenClaw 高优先级 issue 增量复扫报告（xixi）

- 扫描时间：2026-04-19 21:30 CST
- 范围：`openclaw/openclaw` 最近活跃 open issues、最近活跃 open PR、最近 merged PR
- 扫描策略：仅做增量/窄范围复扫；重点检查下午报告中的 top candidates 是否已被新开 PR / 新 merge 覆盖，并补充最近新活跃但尚未覆盖的候选

## 1) 更新后的 Top candidates

| 优先级 | Issue | 判断 | 原因 |
|---|---|---|---|
| 1 | [#68965](https://github.com/openclaw/openclaw/issues/68965) | 立即可做 | 根因在 issue 里写得非常直：`models.mode: replace` 仍无条件加载 bundled plugin 的 implicit providers；修复点已直接指向 `resolveProvidersForModelsJsonWithDeps`，当前未见 open/merged PR 覆盖。 |
| 2 | [#67441](https://github.com/openclaw/openclaw/issues/67441) | 立即可做 | 新增确认信息很强：isolated cron 通过 `message` 成功发 Discord 且 `lastDelivered=true`，但 cron 状态仍记成 error；问题表现和根因都较集中，当前未见 open/merged PR 覆盖。 |
| 3 | [#64947](https://github.com/openclaw/openclaw/issues/64947) | 高价值 | `openai-codex` OAuth scope 不兼容问题今天又被复现确认，仍阻塞真实登录/验证链路；症状稳定、 workaround 明确，仍未见 open/merged PR 覆盖。 |
| 4 | [#66733](https://github.com/openclaw/openclaw/issues/66733) | 值得跟进 | Control UI 无 streaming / typing indicator 的回归今天仍有新确认；用户面广、回退版本可规避，说明回归边界较清晰，但当前仍未见针对该 issue 的活跃修复 PR。 |
| 5 | [#68944](https://github.com/openclaw/openclaw/issues/68944) | 值得跟进 | 问题报告质量高：握手停在 `connect.challenge` 后、CLI 不发 `connect.reply`，并给出 Windows/Node 24 线索；尚未看到覆盖 PR，但比前四项更偏平台/诊断型。 |

## 2) 与下午报告相比，需要降级/移除的项

### 已被 open PR 覆盖，先从 top candidates 降级或移除

1. **#68847** `maybeWakeNodeWithApns ... leaking entries for unregistered nodeIds`
   - 现已看到 **PR #68848** `fix(gateway): clear nodeWakeById on no-registration early-return`
   - 还有后续重提/替代 PR 关闭痕迹（#68912 / #68902），说明该方向已有人在做。
   - **结论：从 top candidates 移除，转观察 PR #68848。**

2. **#68841** `costUsageCache has no cap/prune`
   - 现已看到 **PR #68842** `fix(gateway): bound costUsageCache with MAX + FIFO eviction`
   - 同时存在多个后续重复/替代 PR 已 closed（#68913 / #68905 / #68881）。
   - **结论：从 top candidates 移除，转观察 PR #68842。**

3. **#68838** `drain finally deletes FOLLOWUP_QUEUES entry without identity check`
   - 下午时还可视为未覆盖；本轮复扫已看到 **PR #68908** 直接修这个点，且更早还有 **PR #68839**。
   - **结论：从 top candidates 移除，优先观察 PR #68908。**

### 之前已覆盖的项，本轮继续维持降级/移除

4. **#68776** `Discord inbound silently hangs in ensureConfiguredBindingRouteReady ...`
   - 仍由 **PR #68834** 覆盖，今天仍处于 open 状态。
   - **结论：继续不作为空白派单候选。**

5. **#68827** `sessions_spawn: MCP child processes not reaped after spawned run ends`
   - 仍由 **PR #68846** 覆盖。
   - **结论：继续不作为空白派单候选。**

6. **#68826** `cron --tools csv / PowerShell 解析问题`
   - 本轮 recent merged PR 已看到 **PR #68858** `fix(cron): parse PowerShell tools allow list` merged。
   - **结论：可继续视为已解决并从待办移除。**

## 3) 最近 merged PR 对候选池的影响

本轮 recent merged PR 中，和 xixi 候选池最相关的覆盖项主要是：

- **PR #68858** merged → 覆盖/吸收 **#68826**，可移除。
- 其余最近 merged PR（#68915、#68907、#68891、#68715、#68886、#55787、#67905、#68829 等）未直接命中本轮保留的 top candidates。

## 4) 近期活跃但暂不升入 top candidates 的项

1. **#68596** `Configurable streaming watchdog timeout threshold`
   - 活跃度很高，今天还有新用户确认；但更偏功能/参数化诉求，不如 #66733 / #67441 / #68965 那样是“清晰可落的 bug 修复单”。

2. **#68940** `CLI Backends quick-start 文档命令失效`
   - 问题清楚、可能很快修完，但偏 docs / quick-start 对齐，价值略低于前五。

3. **#68938** `Web UI voice input / image upload broken`
   - 用户影响可能不小，但当前 issue 里的根因还不够聚焦，暂不排进前五。

## 5) 简短结论

- **下午报告里的 3 个“最适合直接接单”候选（#68847 / #68841 / #68838）现在都已有 open PR 覆盖，应从 top candidates 里降级移除。**
- **本轮增量复扫后，新的优先池建议改为：#68965 / #67441 / #64947 / #66733 / #68944。**
- **若要马上派单，优先顺序建议：#68965 > #67441 > #64947。**
- **继续避免重复派单的覆盖项：#68847 / #68841 / #68838 / #68776 / #68827 / #68826。**
