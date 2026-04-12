# 2026-04-12 晚间扫描报告

**扫描时间**: 2026-04-12 15:25 GMT+8  
**扫描者**: xixi

---

## 一、GitHub Issues 扫描（最近 2 小时）

### 已关闭 PR（今天活跃）
| PR# | 标题 | 状态 |
|-----|------|------|
| 65230 | fix(gmail): set stopped=true on addressInUse to prevent duplicate watcher restart | CLOSED |
| 65227 | fix(status): reflect observed heartbeat state | CLOSED |
| 65206 | fix: preserve cron persisted runtime state on load | CLOSED |
| 65196 | fix(gmail): duplicate watcher | CLOSED |
| 65163 | fix(gmail): duplicate watcher | CLOSED |

### Open Issues（按优先级排序）

#### 🔴 高优先级 - Regression Bug

| Issue# | 标题 | 标签 | Size |
|--------|------|------|------|
| **65218** | embedded heartbeat precheck ignores configured compaction reserve and uses reserveTokens=16384 | bug, regression | **S** |
| **65214** | Bundled @openclaw/elevenlabs-speech extension never loads on 2026.4.11 | bug, regression | **S** |
| **65210** | Control UI token usage shows N/A, usage page missing token counts, and auto-compression fails | bug, regression | **M** |
| **65204** | Cannot start Chrome | bug, regression | **S** |
| **65193** | Cron bug: TypeError: Cannot read properties of undefined (reading 'runningAtMs') | bug, regression | **M** |
| **65192** | too many dream sessions have led to accumulation | bug:behavior | **M** |
| **65189** | OpenViking 记忆引擎的上下文块泄露到了 UI 层 | bug:behavior | **M** |
| **65184** | openclaw gateway install may fail with "Unit file openclaw-gateway.service does not exist" | bug, regression | **S** |

---

## 二、Issue 详细分析

### 🔥 最佳候选人（Size S/XS，有明确复现步骤）

**#65218** - embedded heartbeat reserveTokens bug
- **问题**: 配置文件设置的 `reserveTokens: 1000` 被忽略，预检查始终用 `16384`
- **复现步骤**: 已提供清晰步骤
- **相关文件**: 可能是 `src/core/heartbeat.ts` 或 `src/core/compaction.ts`
- **可修性**: **S** - 需要理解 compaction 预留逻辑

**#65214** - ElevenLabs TTS 不加载
- **问题**: 插件存在但 gateway 报 "missing"
- **复现**: 明确提供了版本环境、重现步骤
- **可修性**: **S** - 可能是插件加载路径问题

**#65204** - Cannot start Chrome
- **问题**: macOS Chrome 启动失败
- **可修性**: **S** - 可能是路径问题

**#65184** - gateway install systemd bug
- **问题**: systemd --user 安装迁移后失败
- **可修性**: **S** - 安装脚本问题

---

## 三、低贡献者活跃文件区

未扫描到低贡献者 regression bug。今天主仓库活跃 PR 多为大型 rollup，修复已由核心维护者完成。

---

## 四、Maintainer 新评论

已关闭 PR 列表显示今天有多个 Gmail watcher 修复（#65230, #65196, #65163），均已合并。

---

## 五、建议接单

| 优先级 | Issue# | 建议操作 |
|--------|--------|----------|
| 🥇 | #65218 | 查 compaction reserveTokens 逻辑，确认为何配置未生效 |
| 🥈 | #65214 | 查插件加载流程，确认 elevenlabs 为何 missing |
| 🥉 | #65204 | 需获取完整日志判断 Chrome 问题 |

---

## 六、已完成 PR（需排除）

- #65230 (Gmail watcher) ✅ 已完成
- #65042 (Gmail watcher 根源 issue) ⚠️ 需确认是否已修