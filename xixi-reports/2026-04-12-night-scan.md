# 2026-04-12 Night Scan Report

**扫描时间**: 2026-04-12 20:58 GMT+8  
**扫描方向**: 4 个方向全面扫描  
**状态**: ✅ 完成

---

## 📊 方向 1: GitHub Issues & PRs (最近 2 小时)

### 新开 Issue (高优先级 Regression/Bug)

| # | 标题 | 标签 | 可修性 |
|---|------|------|--------|
| 65347 | [Bug]: OpenAI Codex OAuth Authentication Failed | bug, regression | **S** 🔴 有明确步骤 |
| 65346 | Skill catalog prompt injection ignores allowBundled filter | bug | M |
| 65345 | [Bug]: Docs/code alignment questions | bug, bug:behavior | M |
| 65322 | [Bug]: gatewayRequestError: chat.history unavailable during gateway startup | bug, regression | **S** 🔴 |
| 65321 | [Bug]: built-in TTS provider broken in 2026.4.11 | bug | **S** 🔴 |
| 65318 | [Bug]: Gemini CLI OAuth orphaned in v2026.4.10 | bug, regression | **S** 🔴 有修复 |
| 65317 | [Bug]: functions.write fails (python3 required) | bug, bug:behavior | M |
| 65309 | [Bug]: Active Memory blocks direct-chat ~30s | bug, regression | **M** |
| 65304 | [Bug]: Windows 3.28 工具调用全部失败 | bug, regression | **M** |

### 新开 PR (20 个)

关键 PR:
- #65348 docs: Claude subscription billing guide
- #65342 fix(memory-wiki): preserve Unicode slugs
- #65333 fix(gateway): default gateway.auth.mode to 'none'
- #65331 fix: textTransforms from plugins now applied

---

## 📊 方向 2: 插件仓库

未发现新的 regression。核心仓库列表:
- openclaw/openclaw (主仓库)
- openclaw/extensions-* (扩展仓库)
- openclaw/skills (skill 存档)

---

## 📊 方向 3: 低贡献者活跃文件

近期提交 (非核心维护者):
- @welfo-beo: fix/memory-wiki-unicode-slugs (#65342)
- @monsonego: fix-62390-chat-model-prefix (#65340)
- @hclsys: fix/groupchat-history-limit-zero (#65311)
- @weichengdeng: fix/send-poll-intent-detection

---

## 📊 方向 4: 已追踪 PR 动态

### #65042 (Gmail watcher duplicate)
- 状态: **OPEN** (未修复)
- 评论: 0
- 结论: **仍是 regression bug**，有明确复现步骤。gmail watcher 重复启动导致 port 8788 冲突。

### #65193 (Cron TypeError)
- 状态: **OPEN** (未修复)
- 评论: 0
- 结论: **仍是 regression bug**。TypeError: Cannot read properties of undefined (reading 'runningAtMs')
- 补充: 2026.3.29 正常，2026.4.10 失败

---

## 🎯 S 级候选 (推荐优先)

| Issue | 难度 | 原因 |
|-------|------|------|
| #65347 OAuth scope | S | Codex OAuth 有明确复现步骤 |
| #65321 TTS broken | S | 2026.4.11 regression |
| #65318 Gemini CLI | S | 已有修复建议 (martingarramon) |
| #65322 chat.history | S | gateway startup regression |
| #65042 Gmail watcher | S | regression 有明确步骤 |
| #65193 Cron crash | S | 2026.4.9 回归 |

---

## ❌ 排除项

- 大型 feature request
- 已有 active PR 的 issue
- 核心架构改动

---

**报告生成完毕**  
xixi 2026-04-12 20:58