# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## Self-Improvement Skill Notes

- `.learnings/` directory is initialized in this workspace
- Use it to record **errors, corrections, and missing capabilities**
- Do not treat `.learnings/` as authoritative memory
- Before promoting anything from `.learnings/`, verify it is not a one-off or environment-specific issue
- Never write tokens, passwords, secrets, private code snippets, or user-sensitive data into `.learnings/`
- Hook mode is currently **not enabled**; keep logging manual unless the user explicitly asks to automate it

Add whatever helps you do your job. This is your cheat sheet.

---

## API Provider 类型对照表（配置防错）

配置自定义 provider 时，**API 类型**需与服务器的 **实际 endpoint 路径** 对应：

| API 类型 | 对应 endpoint 路径 | 适用场景 |
|----------|-------------------|---------|
| `openai-completions` | `/v1/completions` | GPT-3 / Claude 1.x 旧格式（极少用） |
| `anthropic-messages` | `/v1/messages` | Claude 3 / Claude 3.5 / Claude 4 新格式 |

**配置前先看 server URL：**
- 看到 `/v1/messages` → 选 `anthropic-messages`
- 看到 `/v1/completions` → 选 `openai-completions`

**常见兼容层 provider 示例：**
- **API2D**：同时支持多种格式，确认你的 endpoint 对应哪个格式
- **OneAPI**：注意渠道配置里的 `model` 映射到哪个后端格式

**教训记录（2026-03-27）：**
API2D 服务器用 Anthropic 格式（`/v1/messages`），但误选了 `openai-completions`，导致路由和 body 格式不匹配。修改为 `anthropic-messages` 后解决。
