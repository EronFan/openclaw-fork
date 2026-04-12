# xixi Scan - Last Processed Report

**Scan time**: 2026-04-12 12:41 CST (2026-04-12 04:41 UTC)
**Processed at**: 2026-04-12 13:15 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub（xixi 第97轮扫描 2026-04-12 12:41 CST）**：

### 最高优先级新候选

| 优先级 | issue | 描述 | 行动 |
|--------|-------|------|------|
| P59901 | **#65168** | node pairing approval 之前 node.invoke 仍可调用，安全边界绕过 | 建议安全优先级提升 |
| P59900 | **#65177** | Feishu botName 升级 2026.4.11 后 gateway 启动失败，doctor --fix 无效 | 建议 aoao 接单 |
| P59902 | **#65164** | Windows 下 gateway 内所有 outbound HTTP 失败，WebSocket 正常 | gateway 初始化 HTTP/undici 污染路径需单独调研 |
| P59903 | **#65144/#65146** | EronFan approve 后被 barnacle 因"active PR>10"自动关闭 | 流程阻塞，等活跃 PR 下降后 reopen |

### contributor-area 命中（继续盯）
- P59897: `lml2468` 活跃在 `src/gateway/control-plane-rate-limit*` ↔ #64911
- P59898: `lml2468` 活跃在 `src/gateway/server-maintenance.ts` ↔ #64984
- P59894: `davidrudduck` 活跃在 `src/agents/pi-embedded-runner/compact*` ↔ #64962

### 追踪 PR 状态（方向4）
- PR #65144/#65146 被 barnacle 自动关闭（EronFan 已 approve）
- PR #64681 维持 7/7 通过，maintainer 确认中
- PR #65016/#65012 均仍 open，无新 maintainer 评论

## gh 反馈检查

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, 0 comments — 无新反馈
- **#55008**：OPEN, 5 comments — 状态同前（regression 已修复，PR 可 merge）
- **#55013**：OPEN, 2 comments — 状态同前（5/5 confidence，PR 可 merge）
