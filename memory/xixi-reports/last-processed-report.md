# xixi Scan - Last Processed Report

**Scan time**: 2026-04-12 14:51 CST (2026-04-12 06:51 UTC)
**Processed at**: 2026-04-12 14:59 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub（xixi 第99轮扫描 2026-04-12 14:51 CST）**：

### 最高优先级新候选

| 优先级 | issue | 描述 | 行动 |
|--------|-------|------|------|
| P59909 | **#65210** | **CRITICAL REGRESSION** — Control UI token usage N/A + auto-compression fails since 2026.4.9；usage 字段解析失败级联导致全线崩溃；所有 2026.4.9+ 用户受影响 | **🔥 aoao 已派出（runId 03323276）** |
| P59910 | **#65211** | **S** — include user-configured provider models in gateway catalog（根因修复，supersedes #65178） | **建议 review 优先** |
| P59911 | **#65208** | **S** — Browser plugin 不传 `--remote-debugging-port` 导致 Chrome CDP 无法连接 | 建议 aoao 接单 |
| P59912 | **#65207** | **S** — Ollama models not displayed in openclaw models list (2026.4.11) | 建议 aoao 接单 |
| P59913 | **#65204** | **S** — Cannot start Chrome, cdpPort binding Permission denied (port 80) | 建议 aoao 接单 |
| P59914 | **#65209** | **S** — `openclaw mcp list` 只显示 OpenClaw registry（usability gap） | 建议 aoao 接单 |
| P59915 | **#65200** | **S** — /new 和 /reset 不清除 session model overrides | 建议 aoao 接单 |
| P59916 | **#65195** | **M** — exec/runtime 无法访问 LAN host (macOS) | 调研根因 |
| P59917 | **#65192** | **S** — too many dream sessions accumulation | 建议 aoao 接单 |

### 已在追踪的候选（本轮无变化）

| 优先级 | issue | 描述 | 状态 |
|--------|-------|------|------|
| P59904 | #65193 | Cron 持久化状态缺字段崩溃 | PR #65206 已创建 |
| P59905 | #65191 | 插件初始化先于 config 加载 | 新发现，继续盯 |
| P59906 | #65184 | gateway install 在 systemd --user 场景误报 | 继续盯 |
| P59907 | #55679 | memoryFlush 永不触发 | contributor-area，继续盯 |
| P59900 | #65177 | Feishu botName doctor migration 无效 | 建议 aoao 接单 |
| P59901 | #65168 | node.invoke pairing 前可调用（安全问题） | 建议安全优先级提升 |

### 追踪 PR 状态（方向4）

| PR | 标题 | 状态 | 新评论 |
|----|------|------|--------|
| #65202 | fix(feishu): add doctor migration for legacy botName→name | **有反馈** | maintainer：不应用 top-level rename，应是 per-account 层 |
| #65194 | fix(imessage): avoid duplicate default monitor startup | **有反馈** | maintainer P1×2/P2×2：检查范围过宽、disabled accounts 未 ignore |
| #65205 | feat(discord): add canvas-first Discord Activities support | **有反馈** | maintainer：spoofed launch markers 需 reject；SDK load promise reset 缺失 |
| #65211 | fix: include user-configured provider models in gateway catalog | **新 PR** | 根因级 image support 修复，supersedes #65178 |
| #65199 | fix(ui): humanize cron expressions in dreaming phase | **有反馈** | minute offset 丢失、next-run fallback 缺失 |

### 方向3 扫描方法改进

本轮发现 `.files` 字段全部为 null，需改用：
```bash
gh api "repos/openclaw/openclaw/commits?author={login}&per_page=20" --jq '.[].files[].filename'
```
对每个末段 contributor 逐个拉取。

---

## gh 反馈检查（2026-04-12 14:59 CST）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, 0 comments — 无新反馈
- **#55008**：OPEN, 5 comments — 无新反馈（regression 已修复，PR 可 merge）
- **#55013**：OPEN, 2 comments — 无新反馈（5/5 confidence，PR 可 merge）
