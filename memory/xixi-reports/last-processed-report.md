# xixi Scan - Last Processed Report

**Scan time**: 2026-04-11 22:03 CST (14:03 UTC)
**Processed at**: 2026-04-11 22:08 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub（xixi 第91轮扫描 2026-04-11 22:03 CST）**：

### 最高优先级新候选（已派出 aoao）

| 优先级 | issue | 描述 | runId |
|--------|-------|------|-------|
| P1 | **#64821** | tools.exec.security 被插件初始化日志污染（bug+security+crash 三标签） | edf3dcbd（#64821 接单） |
| P1 | **#64814** | api.pluginConfig 在 extension plugin register() 中为 null（bug+regression） | 刚派出 |

### 其他新候选（已写入 OPENCLAW-PROJECT.md）

| 优先级 | issue | 描述 | Action |
|--------|-------|------|--------|
| S | **#64816** | Plugin-bundled skill 对 CLI 可见但 live session 中 agent available_skills 不可见 | 待分配 |
| S | **#64818** | openclaw update src/canvas-host/a2ui/.bundle.hash 破坏 preflight bisect | 待分配 |
| S | **#64825** | TUI finalizeRun() 在 wasActiveRun=false 时不转换 UI，导致 streaming 指示器卡住 | 待分配 |
| S | **#64795** | heartbeat isolatedSession:true 静默复用同一 transcript 文件（每次覆盖） | 待分配 |
| XS PR | **#64681** | test(qa): GPT 5.4 Parity vs. Opus Agentic gate parity prose scenarios | 待 Approve |
| P1 | Tencent/weixin **#54** | 图片查看功能完全不可用（sharp 模块缺失，ERR_MODULE_NOT_FOUND） | 调研 |
| P1 | Tencent/weixin **#53** | AI 承诺创建 cron 定时提醒但实际未调用创建接口 | 追踪 |
| S PR | Tencent/weixin **#49** | fix: preserve quote context (ref_msg) for voice messages | 建议 Approve |

## gh 反馈检查（#54952/#54964/#55008/#55013）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：状态无变化（0 comments）
- **#55008**：OPEN, 5 comments — 已知 regression 已修复，PR 可 merge
- **#55013**：OPEN, 2 comments — 已知 5/5 confidence，PR 可 merge

## 追踪状态
- P702 #64821: 已派出 aoao（runId edf3dcbd）
- P703 #64814: 已派出 aoao
- P704-P707: 待分配
- PR #49（weixin voice quote context）: 待发支持评论
