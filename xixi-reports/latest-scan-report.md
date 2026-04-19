# OpenClaw 高优先级 issue 复扫报告（xixi）

- 扫描时间：2026-04-19 14:45 CST
- 范围：`openclaw/openclaw` 最近活跃 open issues + 最近活跃 open PR/最近合并 PR
- 结论口径：优先保留“根因已较清晰、当前无现成 PR 覆盖”的候选；已被 open PR/merged PR 覆盖的项单列到移除/降级区。

## 1) Top 5 候选 issue

| 优先级 | Issue | 判断 | 原因 |
|---|---|---|---|
| 1 | [#68847](https://github.com/openclaw/openclaw/issues/68847) | 立即可做 | 根因非常清晰：`maybeWakeNodeWithApns` 在 registration check 前先 `nodeWakeById.set(...)`，`no-registration` 提前返回路径未 cleanup，属于很干净的 map 泄漏修复点；扫到的活跃 PR 中未见覆盖。 |
| 2 | [#68841](https://github.com/openclaw/openclaw/issues/68841) | 立即可做 | 根因清晰：`costUsageCache` 仅靠 TTL 判 stale，但没有 prune/cap，`(startMs,endMs)` key 会持续累积；问题定位已在 issue 里写得很具体，未见现成 PR 覆盖。 |
| 3 | [#68838](https://github.com/openclaw/openclaw/issues/68838) | 立即可做 | 根因清晰：followup drain 的 finally 仅按 key 删除 `FOLLOWUP_QUEUES`，未校验当前 queue identity，存在并发/竞态下误删新队列的风险；未见现成 PR 覆盖。 |
| 4 | [#64947](https://github.com/openclaw/openclaw/issues/64947) | 高价值 | 问题稳定复现且根因指向明确：`openai-codex` OAuth scope 集合包含当前 client 不允许的 `model.request` / `api.responses.write`，导致 `invalid_scope`；近日报告仍持续复现，未见最近活跃 PR 覆盖。 |
| 5 | [#66733](https://github.com/openclaw/openclaw/issues/66733) | 值得跟进 | Control UI streaming / typing indicator 回归已被多名用户持续确认（4.11 正常、4.12+ 异常、4.14 仍在），虽然根因不如前三个“单点式”清晰，但用户面广且仍无现成 PR 覆盖。 |

## 2) maintainer / reviewer 新评论是否需要我们响应

**结论：没有看到明确的 maintainer 新评论在等我们立刻回复。**

但有两类“值得盯住”的新动态：

1. **PR #68349** `Ollama: honor Modelfile num_ctx and auto-detect tool support`
   - 最新有人留言：`LGTM - happy to help this get merged once you resolve conflicts`
   - 这更像“作者需要先解冲突”，不是我们必须马上下场回复的 maintainer blocking comment。

2. **PR #68822** `feat(memory): make embedding retry/concurrency parameters configurable`
   - 仍有 bot review 指出 schema / config 接线问题；作者已修了 getter 调用错误。
   - 目前没看到 maintainer 人工评论，但这类 PR 还没完全稳定，暂不建议把相关 issue 当成空白待办再派单。

补充：
- **PR #68834**（Discord ACP binding hang 修复）作者今天已连续处理 review comment，并回帖说明已修；当前不像缺回复，更像等待合并。
- **PR #68441** 的新留言主要是作者/贡献者自更新与设计升级说明，不是我们要代答的 maintainer ping。

## 3) 已 merge / 已覆盖，可从待办移除或降级的项

### 可直接从“待修复候选”移除

1. **#68826** `bug(cron): --tools csv stores space-separated string instead of array on Windows (PowerShell)`
   - 已有 **PR #68832**，且在本轮 recent closed PR 中显示 **已 merged**。
   - 结论：可从待办移除。

### 已被 open PR 覆盖，先从“可派单候选”降级

2. **#68776** `Discord inbound silently hangs in ensureConfiguredBindingRouteReady for type:"acp" bindings`
   - issue 内已有贡献者留言“Working on a fix”。
   - 最近活跃 open PR 中已有 **PR #68834** `fix: prevent Discord ACP binding silent hang on fresh gateway boot`，并且今天仍在处理 review。
   - 结论：从待派单列表移除，转为“等 PR #68834 结果”。

3. **#68373** `Cached plugin restore drops memory capability, breaks wiki bridge imports`
   - issue 评论已明确交叉链接 **PR #68334 / #68041** 等多个重叠修复。
   - 结论：从“空白候选”移除，避免重复派单。

4. **#68154** `security audit false positive: plugins.allow_phantom_entries flags bundled plugins as phantom`
   - issue 评论明确指出已有 **PR #67978** 在修。
   - 结论：从“空白候选”移除，转观察 PR 状态即可。

5. **#68827** `sessions_spawn: MCP child processes not reaped after spawned run ends`
   - 最近活跃 open PR 中已有 **PR #68846** `fix: reap MCP child processes when spawned session run ends`。
   - 结论：已覆盖，先不重复派单。

## 简短建议

- **最适合 aoao 直接接单的 3 个**：#68847 / #68841 / #68838
- **高价值但需要一点验证/产品判断的 2 个**：#64947 / #66733
- **今天先不要重复派单的覆盖项**：#68776 / #68373 / #68154 / #68827 / #68826
