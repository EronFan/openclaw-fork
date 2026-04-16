import { getDiagnosticSessionState } from "../logging/diagnostic-session-state.js";
import { logToolLoopAction } from "../logging/diagnostic.js";
import {
  detectToolCallLoop,
  recordToolCall,
  recordToolCallOutcome,
  recordToolFailureStreak,
  clearToolFailureStreak,
} from "./tool-loop-detection.js";

export const beforeToolCallRuntime = {
  getDiagnosticSessionState,
  logToolLoopAction,
  detectToolCallLoop,
  recordToolCall,
  recordToolCallOutcome,
  recordToolFailureStreak,
  clearToolFailureStreak,
};
