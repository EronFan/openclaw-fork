#!/bin/bash

# 兼容保留脚本（备用）
# 主调度已统一迁移到 OpenClaw 内建 cron: morning-briefing
# 这个脚本只作为手动补跑/排障备用，不再作为主触发链路。

WORKSPACE_DIR="/root/.openclaw/workspace"
LOG_DIR="/root/.openclaw/logs"
TODAY=$(date +%Y-%m-%d)
REPORT_FILE="$LOG_DIR/daily-$TODAY.md"

# 创建日志目录
mkdir -p "$LOG_DIR"

# 开始生成日报
echo "# 每日晨报 - $TODAY" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## 生成时间" >> "$REPORT_FILE"
echo "- **时间**: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查内存使用
echo "## 系统状态" >> "$REPORT_FILE"
echo "\`\`\`" >> "$REPORT_FILE"
echo "内存使用: $(free -h | awk '/^Mem:/ {print $3"/"$2}')" >> "$REPORT_FILE"
echo "磁盘使用: $(df -h / | awk 'NR==2 {print $3"/"$2}')" >> "$REPORT_FILE"
echo "运行时间: $(uptime -p)" >> "$REPORT_FILE"
echo "\`\`\`" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查 OpenClaw 状态
echo "## OpenClaw 状态" >> "$REPORT_FILE"
echo "\`\`\`" >> "$REPORT_FILE"
openclaw status 2>&1 | grep -A 5 "Overview" >> "$REPORT_FILE" 2>/dev/null || echo "状态检查失败" >> "$REPORT_FILE"
echo "\`\`\`" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# OpenClaw 贡献里程碑
echo "## 📊 OpenClaw 贡献里程碑" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查是否有 OpenClaw 项目目录
if [ -d "/root/.openclaw/workspace/projects/openclaw-pr" ]; then
    cd "/root/.openclaw/workspace/projects/openclaw-pr"
    echo "**项目位置**: \`/root/.openclaw/workspace/projects/openclaw-pr\`" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # 检查 GitHub 贡献统计
    echo "**Git 状态**: " >> "$REPORT_FILE"
    git status --short 2>/dev/null | head -5 >> "$REPORT_FILE" 2>/dev/null || echo "  无未提交更改" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # 最近提交记录
    echo "**最近提交**: " >> "$REPORT_FILE"
    git log --oneline -3 2>/dev/null >> "$REPORT_FILE" 2>/dev/null || echo "  无提交记录" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # 分支状态
    echo "**当前分支**: \`$(git branch --show-current 2>/dev/null || echo "未知")\`" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
else
    echo "**项目状态**: OpenClaw 贡献项目目录未找到" >> "$REPORT_FILE"
    echo "**建议**: 请检查项目是否已克隆到正确位置" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
fi

# 贡献目标提醒
echo "**长期目标**: 冲击 OpenClaw contributors 前 20" >> "$REPORT_FILE"
echo "**当前策略**: 通过高质量 issue/PR/docs fix/walkthrough 改进" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**协作团队**: main + xixi + aoao" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查 Agent 活跃情况
echo "## Agent 状态" >> "$REPORT_FILE"
echo "- **主机器人**: 运行中" >> "$REPORT_FILE"
echo "- **兮兮(xixi)**: 待检查" >> "$REPORT_FILE"
echo "- **玲玲(ling)**: 待检查" >> "$REPORT_FILE"
echo "- **熬熬(aoao)**: 待检查" >> "$REPORT_FILE"
echo "- **薇薇(weiwei)**: 待检查" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 今日提醒事项
echo "## 今日提醒" >> "$REPORT_FILE"
echo "1. 检查 OpenClaw 项目进展" >> "$REPORT_FILE"
echo "2. 推送内容创作计划" >> "$REPORT_FILE"
echo "3. 技术学习与实践" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "晨报生成完成！" >> "$REPORT_FILE"

# 发送通知（这里需要根据实际情况实现）
# 可以通过飞书 API、邮件等方式推送

echo "日报已生成: $REPORT_FILE"

# 生成完成后，通过飞书发送简单通知
# 注意：这里需要配置飞书 API 权限
# curl -X POST "https://open.feishu.cn/open-apis/bot/v2/hook/xxx" \
#      -H "Content-Type: application/json" \
#      -d '{"msg_type":"text","content":{"text":"每日晨报已生成，请查收"}}'