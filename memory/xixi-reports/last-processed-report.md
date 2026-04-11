# xixi Scan - Last Processed Report

**Scan time**: 2026-04-12 02:18 CST (2026-04-11 18:18 UTC)
**Processed at**: 2026-04-12 03:04 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub（xixi 第93轮扫描 2026-04-12 02:18 CST）**：

### 最高优先级新候选（建议派 aoao）

| 优先级 | issue | 描述 | 建议 |
|--------|-------|------|------|
| P338 | **#64925** | Silent agent errors never surface to TUI/Telegram — 错误被 isError=true 吞掉，用户只看到 2 分钟 typing 后静默失败，根因已定位 | **建议 aoao 接单** |
| P339 | **#64917** | sessions_send from visible webchat leaks internal replies via announce path — 高优先级隐私/路由问题，多 agent/webchat 场景有错误交付风险 | **建议 aoao 接单** |
| P340 | **#64921** | 插件 textTransforms 在 main process 完全不生效 — `loadPluginRuntime()` 始终返回 null，已有对应 PR #64924 | 跟进 PR #64924 |
| P341 | **#64910** | Agent response gets stuck，输出框无限闪烁不结束 — 核心交互 regression | **建议 aoao 接单** |

### 其他候选（已记账）
- #64922: Minimax reasoning level 被拒
- #64916: WebUI 图片发出但 Agent 收到空消息
- #64894: Codex OAuth invalid_scope 回归
- Tencent/openclaw-weixin #55: Support ACP thread binding on WeChat（能力缺口，长期追踪）

## gh 反馈检查（#54952/#54964/#55008/#55013）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, 0 comments — 无新反馈
- **#55008**：OPEN, 5 comments — regression 已修复，PR 可 merge
- **#55013**：OPEN, 2 comments — 5/5 confidence，PR 可 merge

## 追踪状态
- P338 #64925: 已派出 aoao
- P339 #64917: 已派出 aoao
- P340 #64921: 跟进 PR #64924
- P341 #64910: 已派出 aoao
