import { readFile } from "ags/file"
import { createPoll } from "ags/time"

export const ramPct = createPoll("0%", 3000, () => {
  try {
    const mem = readFile("/proc/meminfo")
    const total = Number(/MemTotal:\s+(\d+)/.exec(mem)?.[1] || 0)
    const avail = Number(/MemAvailable:\s+(\d+)/.exec(mem)?.[1] || 0)
    if (!total) return "0%"
    const usage = Math.max(0, Math.min(1, 1 - avail / total))
    return `${Math.round(usage * 100)}%`
  } catch { return "0%" }
})
