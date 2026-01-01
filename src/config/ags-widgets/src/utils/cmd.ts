import { exec, execAsync } from "ags/process"

export function sh(cmd: string) { return ["bash", "-lc", cmd] }
export async function safeAsync(cmd: string) { return execAsync(sh(cmd)).catch(() => { }) }
export function safeSync(cmd: string) { try { return String(exec(sh(cmd)) ?? "") } catch { return "" } }
