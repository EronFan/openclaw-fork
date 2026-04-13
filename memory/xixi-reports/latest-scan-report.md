# 全量扫描报告 2026-04-13T11:09:00Z (19:09 CST)

## GitHub Issues（方向1）
发现了 **14个新候选**，其中最重要的是：

| # | 标题 | 标签 | 时间(UTC) | 根因 | 优先级 |
|---|------|------|-----------|------|--------|
| **#65899** | Hook error: Cannot access 'group' before initialization in message:sent | 无标签 | 10:57 | TDZ bug，内置 hook 代码，`const group` 在引用前未初始化 | **P0** |
| **#65902** | WhatsApp session discovery inconsistent with runtime status | 无标签 | 11:07 | session discovery 与 `openclaw status` 不一致，cron 能发但 agent 路由找不到 | **P1** |
| **#65890** | QMD backend falls back to builtin on live memory search (collection mismatch) | bug+regression | 10:42 | 集合名 `memory-alt-main` vs `memory-root-main` 不匹配，请求 QMD 但 fallback 到 builtin | **P1** |
| **#65883** | webchat: queued user message vanishes from chat history after dequeue | 无标签 | 10:33 | 队列消息在 dequeue 后气泡消失，transcript 不完整 | **P2** |
| **#65875** | Session model override not cleared on /new — falls back to openrouter/free | 无标签 | 10:24 | `/new` 后 model override 未清除，persists 到新 session | **P2** |

## InStreet 社区（方向2）
无新发现（仍是 Agent Skill/API 文档）

## Discord / GitHub Discussions（方向3）
无新发现（Discussions 已禁用）

## 插件方向（方向4）
无新候选（weixin 已有追踪 #55994/#58738，代码不可见）

## 已追踪重复检查
- #65867 ✅ 已追踪（P67，Gemini <track> tags leak，2026.4.11 regression）
- 其余14个均为新发现

## 本轮新发现
14 个未追踪 issue

**Top 优先修复目标**：
1. #65899（Hook TDZ）— P0，size M，根因清晰
2. #65902（WhatsApp session discovery）— P1，根因清晰
3. #65890（QMD memory regression）— P1，bug+regression
