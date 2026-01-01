import { Gtk } from "ags/gtk4"
import { safeAsync, safeSync } from "./cmd"
import GLib from "gi://GLib?version=2.0"

export function readVolNow(): number {
  const o = safeSync(`pactl get-sink-volume @DEFAULT_SINK@ | head -n1 || true`)
  const m = o.match(/(\d+)%/)
  const n = Number(m?.[1] || 0)
  return Number.isFinite(n) ? Math.max(0, Math.min(150, n)) : 0
}

export const volAdj = new Gtk.Adjustment({
  lower: 0, upper: 150,
  step_increment: 1, page_increment: 5,
  value: readVolNow(),
})

export async function setVolumePct(v: number) {
  await safeAsync(`pactl set-sink-volume @DEFAULT_SINK@ ${Math.round(v)}%`)
}

export function setupVolumeTimeouts() {
  GLib.timeout_add(GLib.PRIORITY_DEFAULT, 350, () => {
    volAdj.set_value(readVolNow())
    return GLib.SOURCE_CONTINUE
  })
}
