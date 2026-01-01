import { readFile } from "ags/file"
import { createPoll } from "ags/time"

let prevTotal = 0
let prevIdle = 0

export const cpuPct = createPoll("0%", 2000, () => {
  try {
    const line = (readFile("/proc/stat").split("\n")[0] || "").trim()
    const parts = line.split(/\s+/).slice(1).map(Number)
    if (parts.length < 4) return "0%"

    const idle = parts[3] + (parts[4] || 0)
    const total = parts.reduce((a, b) => a + b, 0)

    const totald = total - prevTotal
    const idled = idle - prevIdle
    prevTotal = total
    prevIdle = idle

    if (totald <= 0) return "0%"
    const usage = Math.max(0, Math.min(1, 1 - idled / totald))
    return `${Math.round(usage * 100)}%`
  } catch { return "0%" }
})
