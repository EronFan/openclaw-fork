#!/bin/bash
# 内存守护脚本：每10分钟检查一次，严重时自动重启gateway
# 纯bash实现，无外部依赖

GATEWAY_PID=$(pgrep -f "openclaw-gateway" | head -1)
RSS_KB=$(ps -o rss= -p "$GATEWAY_PID" 2>/dev/null || echo 0)
AVAILABLE_KB=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
SWAP_TOTAL_KB=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
SWAP_FREE_KB=$(grep SwapFree /proc/meminfo | awk '{print $2}')
SWAP_USED_KB=$((SWAP_TOTAL_KB - SWAP_FREE_KB))

LOG_FILE="/tmp/openclaw/memory-guardian.log"
mkdir -p /tmp/openclaw

RSS_GB=$((RSS_KB / 1024 / 1024))
AVAIL_GB=$((AVAILABLE_KB / 1024 / 1024))
if [ "$SWAP_TOTAL_KB" -gt 0 ]; then
    SWAP_USED_PCT=$((SWAP_USED_KB * 100 / SWAP_TOTAL_KB))
else
    SWAP_USED_PCT=0
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') RSS=${RSS_GB}GB AVAIL=${AVAIL_GB}GB SWAP=${SWAP_USED_PCT}% (${SWAP_USED_KB}KB used)" >> $LOG_FILE

# 触发重启条件
if [ "$AVAILABLE_KB" -lt 307200 ]; then
    echo "[CRITICAL] Available < 300MB, restarting gateway..." >> $LOG_FILE
    systemctl --user restart openclaw-gateway
elif [ "$RSS_KB" -gt 2621440 ]; then
    echo "[HIGH] RSS > 2.5GB, restarting gateway..." >> $LOG_FILE
    systemctl --user restart openclaw-gateway
elif [ "$SWAP_USED_PCT" -gt 50 ]; then
    echo "[WARNING] Swap > 50%, restarting gateway..." >> $LOG_FILE
    systemctl --user restart openclaw-gateway
fi
