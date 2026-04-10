#!/bin/bash
cd /root/.openclaw/workspace
exec node skills/feishu-card/send.js --target "ou_5abeeb52afc248214694d8d79ab20df8" --text-file ".evolver_report.md"
