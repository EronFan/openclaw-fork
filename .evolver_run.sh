#!/bin/bash
cd /root/.openclaw/workspace/skills/capability-evolver
export A2A_NODE_ID=node_39aedb370197f318
export A2A_NODE_SECRET=7f7270045b950a7036dc901e91d431f18ec01558d9cb77cae2453767ded4eb6a
export A2A_HUB_URL=https://evomap.ai
export EVOLVER_USE_PARENT_GIT=true
exec node index.js run --every 8h
