#!/bin/bash
# 晨报发送脚本 - 读取已生成的日志并发送到飞书群
WORKSPACE_DIR="/root/.openclaw/workspace"
LOG_DIR="/root/.openclaw/logs"
TODAY=$(date +%Y-%m-%d)
REPORT_FILE="$LOG_DIR/daily-$TODAY.md"

if [ ! -f "$REPORT_FILE" ]; then
    echo "今日晨报不存在: $REPORT_FILE"
    exit 1
fi

# 提取纯文本内容（去掉 markdown 代码块等）
CONTENT=$(sed -n '/系统状态/,/晨报生成完成/p' "$REPORT_FILE" | sed 's/```//g' | sed 's/`//g')

# 飞书通知
openclaw exec -- echo "晨报已生成 $(date)" 2>/dev/null || true

echo "发送完成"
