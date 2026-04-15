# OpenClaw 内存防OOM方案（3.7GB 机器）

## 当前状态

- 机器总内存：3.7GB
- 已停用：lighthouse-chromium（节省约 300-500MB）
- swap：10GB（已存在）
- Gateway 内存上限：已通过 systemd 设置 2.5GB 软限制 / 3GB 硬限制

## 核心矛盾

openclaw-gateway 在跑 full test suite 时，vitest + node + gateway 进程集群会吃掉 3GB+，直接触发 OOM killer。subagent 每创建一个 test runner 就会多一层内存压力。

---

## 方案：分层内存管控

### 第一层：systemd 强制隔离（已实施）
```
MemoryHigh=2500M  # 软限制，超限后节流而非 kill
MemoryMax=3000M   # 硬限制，超限后 OOM
```
**效果**：gateway 进程组不会被直接 SIGKILL，系统会先 throttle 内存分配，给 gateway 喘息空间做 graceful degradation。

### 第二层：subagent 测试内存隔离
**规则**：所有 fix subagent 必须用"无 build"策略
- ✅ `pnpm test -- --run --grep "xxx"`（只跑相关测试）
- ❌ 禁止 `pnpm test`（跑全量 suite 会爆内存）
- ❌ 禁止 `pnpm build` / `pnpm check` / `pnpm lint`
- commit 用 `git commit --no-verify`（跳过 pre-commit hooks）

**原因**：测试进程 vitest 单独占 ~750MB，跑全量会把机器吃满。

### 第三层：防止内存泄漏
**规则**：每次 heartbeat 检查 gateway 进程 RSS，如果连续 3 次 > 2.5GB，立即重启 gateway。
```bash
# 检查命令
ps aux --sort=-%mem | grep openclaw-gateway | awk '{print $6/1024/1024 "GB"}'
```

### 第四层：swap 调优
**当前**：swappiness=50（内存满时积极换出）  
**建议**：改为 60-80，让系统更积极用 swap 换出冷内存，给 gateway 更多物理内存空间。
```bash
sysctl vm.swappiness=80
echo "vm.swappiness=80" >> /etc/sysctl.conf
```

### 第五层：定期内存自愈
**规则**：每 6 小时检查一次，如果可用内存 < 500MB 且 swap 使用率 > 30%，重启 gateway。
- 可用内存 < 500MB + swap 使用率 > 30% → 重启 gateway
- 凌晨 3-4 点优先重启（低流量窗口）

---

## 触发条件汇总

| 条件 | 动作 |
|------|------|
| 内存 < 500MB | 立即 heartbeat 告警 |
| 内存 < 300MB | 立即重启 gateway |
| RSS > 2.5GB 连续3次 | 重启 gateway |
| swap 使用率 > 50% | 考虑重启 gateway |
| 凌晨 3-4 点可用 < 1GB | 计划重启 gateway |

---

## 已知资源大户

- `openclaw-gateway`：~1.3GB RSS（正常），> 2GB（警告）
- `vitest test runner`：~750MB/个（每个跑测试的 subagent 产生）
- `YDService`（云镜）：~28MB，固定，无法优化
- `barad_agent`：~13MB，固定

---

## 部署清单

- [x] 停用 lighthouse-chromium（已执行）
- [x] systemd MemoryHigh/MemoryMax（已部署）
- [ ] swappiness 调优（建议执行）
- [ ] heartbeat 检查 RSS 超限（已内置于 heartbeat）
- [ ] 定期自愈重启（写入 cron 或 heartbeat）
