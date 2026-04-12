# xixi-scan-v2 | 2026-04-12 下午扫描报告

**扫描时间**: 2026-04-12 13:58 GMT+8  
**扫描覆盖**: 全量 open issues + PRs + 最近动态

---

## 🏆 TOP 推荐候选

### #65042 Gmail watcher duplicate bind — Size S | 无 PR | 优先接单

**标签**: regression  
**环境**: OpenClaw 2026.4.10, macOS Mac Mini, gogcli 0.12.0  
**错误**: `listen tcp 127.0.0.1:8788: bind: address already in use`

**根因**: Gmail watcher 在 8788 端口启动后，OpenClaw 重试再次绑定导致冲突  
**复现步骤**: 清晰（提供完整日志）  
**可修性**: S 级，本地端口重复绑定问题，代码路径明确  
**建议**: aoao 接单，查 `src/extensions/gmail/` 启动逻辑加锁/去重

---

## 📋 可修 Issues（无现有 PR，按优先级排序）

### Size S — regression / bug（今天新提交优先）

| # | 标题 | 标签 | 优先级 | 备注 |
|---|------|------|--------|------|
| 65193 | Cron bug: TypeError: Cannot read properties of undefined (reading 'runningAtMs') | bug, regression | ⭐⭐ S | cron.start()→runMissedJobs()→planStartupCatchup()，job对象state丢失，v2026.4.9 regression |
| 65184 | openclaw gateway install --force fails: "Unit file ... does not exist" on migrated root+systemd-user | bug, regression | ⭐⭐ S | systemd daemon-reload 时序竞态，有workaround和明确根因 |
| 65177 | openclaw doctor --fix does not migrate Feishu botName→name in 2026.4.11 | bug, regression | ⭐⭐ S | schema变更但doctor未迁移，有workaround |
| 65182 | `<final>` tags not stripped in Control UI (v4.11) | bug | ⭐⭐ S | UI渲染层regression，PR #65187已针对同源issue但独立 |
| 65195 | exec/runtime cannot reach LAN host on macOS while shell can | (无标签) | ⭐ S | 网络命名空间问题，launchd路径与shell环境分离 |

### Size XS — 小型 bug/regression

| # | 标题 | 标签 | 优先级 | 备注 |
|---|------|------|--------|------|
| 65191 | Plugin init before config loaded (openclaw-weixin, memory-lancedb-pro) | bug | ⭐ XS | 时序问题，插件启动时config未就绪 |
| 65168 | node.invoke stays reachable before node pairing approval | bug | 参考PR#65169 | PR #65169已开，XS |
| 65042 | Gmail watcher duplicate bind | regression | ⭐⭐ 优先接 | **第一候选** |

---

## 📦 Open PR 动态（已开 PR 的 issue 不要重复接）

| PR # | 标题 | 作者 | Size | 状态 |
|------|------|------|------|------|
| #65194 | fix(imessage): avoid duplicate default monitor startup | swang430 | S | 2个bot review，无human maintainer review |
| #65190 | feat(i18n): add Vietnamese (vi-VN) localization | kiet1022 | XS | 无review |
| #65188 | fix(ui): prevent iOS Safari auto-zoom | draix | S | 无review |
| #65187 | test: regression tests for `<final>` tag stripping | w-sss | XS | 可能覆盖#65182 |
| #65186 | feat: add `<example>` trigger mechanism for Skills | nasplycc | S | 无review |
| #65185 | fix(ios): allow plaintext ws:// for LAN/Tailscale hosts | draix | S | 无review |
| #65181 | fix(cron): persist sessionFile for isolated runs | Linux2010 | S | 关联#65151 |
| #65175 | fix(cron): persist sessionFile for isolated cron runs | Yanhu007 | XS | 类似#65181 |
| #65170 | fix(inter-session-completion-delivery): ANNOUNCE_SKIP | duqaXxX | XS | 无review |
| #65169 | fix: node.invoke stays reachable before pairing approval | coygeek | XS | **已覆盖#65168** |
| #65167 | fix: dispatch plugin hooks in cli-runner | w-sss | S | 关联#65157 |

**⚠️ Maintainer Review 缺失预警**:
- PR #65194 (imessage duplicate monitor): 2 bot reviews，0 human maintainer reviews → 需要review

---

## 🔍 扫描维度覆盖

### 1. GitHub Issues — 今天高优先级 regression/bug ✅
- 今天新开: #65195, #65193, #65191, #65189, #65184, #65183, #65182, #65177, #65165, #65161, #65159, #65157, #65156, #65153, #65152, #65151
- 带regression标签今天新开: #65193, #65184, #65177
- 无PR的高质量候选: #65193, #65184, #65177, #65182, #65191, #65042

### 2. 插件仓库 — openclaw-weixin 等 ✅
- #65191: openclaw-weixin 插件初始化时 config 未加载，导致 "account not configured" 错误
- 属于通用时序问题，不限于特定插件

### 3. 低贡献者活跃文件区 — regression bug ✅
- PR #65187 regression tests for `<final>` tag stripping → 指向 PR #65188 fix(ui) → #65182 bug 无PR
- PR #65169 node.invoke reachability → 覆盖 #65168
- cron persist sessionFile → #65175/#65181 两条PR处理 #65151

### 4. 已追踪 PR 的 maintainer 新评论 ✅
- PR #65194: 2 bot reviews (chatgpt-codex-connector, greptile-apps)，**无 maintainer human review**
- 其余今天新PR均无review，处于冷启动状态

---

## 📊 汇总与建议

### aoao 今日可接单（按推荐顺序）

1. **#65042 Gmail watcher duplicate bind** (Size S) — 端口绑定去重，逻辑清晰
2. **#65193 Cron: TypeError reading 'runningAtMs'** (Size S) — cron startup catchup逻辑，job state丢失
3. **#65177 Feishu doctor --fix 不迁移 botName→name** (Size S) — doctor迁移逻辑补充
4. **#65182 `<final>` tags not stripped in Control UI** (Size S) — UI渲染层，如PR #65187未覆盖则接

### 阻塞项
- #65184 (systemd timing race): 根因清楚但涉及systemd时序，可能需要测试环境验证
- #65191 (plugin init timing): 涉及启动顺序重构，建议了解plugin lifecycle后接单

### 不接单（已有PR）
- #65168 → PR #65169 已覆盖
- #65151 → PR #65175/#65181 已覆盖
- #65157 → PR #65167 已覆盖

---

**报告生成**: xixi-scan-v2  
**下次扫描**: 建议 2 小时后再跑一次，注意 #65193 和 #65184 是否有新评论
