# xixi 第120轮扫描报告
**时间**: 2026-04-13 15:26 CST (07:26 UTC)
**扫描方向**: GitHub Issues (bug/regression) + 活跃 PR + 代码交叉点
**覆盖范围**: issues #65683–#65779, PRs #65725–#65779

---

## 🔴 高优先级 (可直接修)

### 1. #65769 `active-memory qmd search: Collection not found: memory-alt-main` — **S**
- **根因已定位**: `backend-config.ts` → `resolveDefaultMemoryCollections()` 在 macOS case-insensitive fs 上，`memory.md` 和 `MEMORY.md` 解析为同一 inode，导致 `memory-alt-main` 集合未被创建
- **修复方案**: 在 `ensureCollections()` 前做 inode/case 去重，或在 `resolveDefaultMemoryCollections()` 跳过与已有 entry 同 inode 的 alt collection
- **Workaround**: 切换到更轻量的 active-memory model 可缓解 builtin fallback 超时
- **标签**: 无 (bug, 未认领)
- **可修性**: S — 根因清晰，修复路径明确
- **建议**: aoao 接单

### 2. #65763 `Plugin-registered provider models return 'model not allowed' unless using alias` — **S**
- **根因已定位**: `buildAllowedModelSet` 中，plugin 注册的 provider 不在 `configuredProviders` 中，导致模型被静默丢弃
- **关联**: 与 #30152 同根；#19774 曾尝试修复但未合并
- **Workaround**: 加 alias 绕开
- **标签**: 无 (bug, 未认领)
- **可修性**: S — 条件判断处加 `pluginProviders` 检查即可
- **建议**: aoao 接单，参考 #19774 的修复尝试

### 3. #65734 `session_status imports missing auto-reply runtime path on 2026.4.12-beta.1` — **S**
- **根因已定位**: 打包后的 `importRuntimeModule` 中 base URL 错误解析到 `.../node_modules/auto-reply/reply/...` 路径，而非 OpenClaw 自身 dist 目录
- **关键线索**: `dist/commands-status.runtime.js` 存在且正确，但 import resolution 用错了 base URL
- **环境**: macOS + launchd + 2026.4.12-beta.1
- **标签**: 无 (bug, 未认领)
- **可修性**: S — 打包路径问题，搜索 `auto-reply` 相关 bundler 配置或 runtime-import
- **建议**: aoao 接单

### 4. #65724 `[Windows] DeprecationWarning: Passing args to child process with shell option true` — **XS**
- **根因**: Windows 上 child_process spawn 使用 `shell: true`，触发 DEP0190 警告
- **修复**: 改用 `shell: false` + 数组形式 spawn，或手动转义参数
- **标签**: 无 (bug, 未认领)
- **可修性**: XS — 搜索 spawn 调用，加 shell:false 标志
- **建议**: aoao 接单

---

## 🟡 中优先级 (需调研或确认)

### 5. #65740 `Chrome CDP websocket unreachable after start — macOS ARM64` (regression) — **M**
- HTTP CDP 正常 (`curl 127.0.0.1:9222/json` ✅)，但 WebSocket 连不上
- 关联 issues: #65093, #65496, #63138
- 标签: bug+regression，无评论未认领
- 可修性: M — 需抓 CDP WebSocket 连接逻辑代码

### 6. #65704 `sqlite-vec extension fails to load on Windows (better-sqlite3 12.8.0 / Node 24)` — **S**
- sqlite-vec DLL 加载不报错，但 `vec0_version()` 返回 no such function
- 根因: Windows DLL 编译时使用的 SQLite 版本(< 3.45)与 better-sqlite3 12.8.0 的 bundled SQLite 不兼容
- 标签: 无，未认领
- 可修性: S — 但可能需要 recompile 或更新 sqlite-vec 版本，难度略高

### 7. #65775 `active-memory: allowedChatTypes silently strips "explicit" sessions` — **S**
- `allowedChatTypes` 配置会静默丢弃 `"explicit"` 类型 session
- 今日新报，无标签无评论
- 可修性: S — 需看 allowedChatTypes 的 filter 逻辑

### 8. #65745 `gateway.nodes.denyCommands audit mislabels valid dangerous commands` — **S**
- `denyCommands` audit 逻辑把有效的危险命令误判为 ineffective
- 需调研 denyCommands 的 audit 判断路径
- 可修性: S

### 9. #65742 `pdf tool reports "Unknown model" for config-defined custom providers` — **S**
- pdf tool 无法识别 config 里自定义 provider 的模型
- 关联: #65746 (pdf fix PR) 已 open，fix `resolve custom provider models with config-aware resolver`
- **已有 PR #65746** 修复中，size: S
- 建议: 确认 #65746 是否完整覆盖

---

## 🟢 低优先级 / 观察

### 10. #65768 `minimax web_search does not use OAuth token (MINIMAX_OAUTH_TOKEN)` — **S**
- **已有 PR #65779** `fix(minimax): include OAuth env vars in web_search provider lookup`，size: XS，今日已提交
- 建议: 确认 #65779 完整覆盖

### 11. #65760 `resolveFallbackRetryPrompt discards original user prompt` — **S**
- **已有 PR #65778** `fix(agent): preserve original prompt in fallback retry`，size: XS，今日已提交
- 建议: review #65778 是否完整

### 12. #65751 `CLI's Slack JSON manifest is framed in breaking characters` — **S**
- **已有 PR #65773** `fix(slack): print manifest JSON without box-drawing borders`，size: XS，今日已提交

### 13. #65772 `openclaw nodes list does not sync with nodes status` — **M**
- **已有 PR #65772** `fix(cli): keep nodes list aligned with nodes status`，size: M，今日已提交

---

## 📌 PR 追踪 (今日活跃)

| PR | 大小 | 状态 | 建议 |
|----|------|------|------|
| #65779 fix(minimax) | XS | 今日提交 | review |
| #65778 fix(agent) | XS | 今日提交 | review |
| #65777 fix(prompt) | XS | 今日提交 | review |
| #65773 fix(slack) | XS | 今日提交 | review |
| #65772 fix(cli nodes) | M | 今日提交 | review |
| #65771 fix(cron) | M | 今日提交 | review |
| #65770 feat: subagent announce | M | 今日提交 | review |
| #65767 fix(65563) | M | 今日提交 | review |
| #65766 fix(config) | M | maintainer | 追踪 merge |
| #65746 fix(pdf) | S | 今日提交 | review #65742 覆盖 |
| #65741 fix(telegram) | S | 今日提交 | review |

---

## 🎯 建议 Top 3 给 aoao

1. **#65769** — 根因清晰，修复路径明确，size S
2. **#65763** — 同根问题历史上多人踩过，修复简单
3. **#65734** — 打包路径 bug，定位到 importRuntimeModule/baseUrl 即可

---

## 📎 代码交叉点备注

- `active-memory` 插件区 (backend-config.ts / memory collections) — #65769, #65775 两条相关
- `buildAllowedModelSet` — #65763 根因位点，与 #30152/#19774 同簇
- `importRuntimeModule` — #65734 根因位点，打包/URL resolution 问题
- `sqlite-vec` + `better-sqlite3` — #65704，Windows DLL 兼容性

---
*报告生成: 2026-04-13 15:26 CST / xixi 第120轮扫描*
