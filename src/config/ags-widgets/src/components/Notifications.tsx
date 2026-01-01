import { For } from "ags"
import GLib from "gi://GLib?version=2.0";

import Gtk from "gi://Gtk?version=4.0"
import { safeAsync, safeSync, sh } from "../utils/cmd";
import { createPoll } from "ags/time";

type Notif = { id: number; app: string; summary: string }

function parseMakoHistory(raw: string): Notif[] {
  const lines = raw.split("\n")
  const out: Notif[] = []
  for (let i = 0; i < lines.length && out.length < 200; i++) {
    const line = lines[i].trim()
    const m = line.match(/^Notification\s+(\d+):\s*(.+)$/)
    if (!m) continue
    const id = Number(m[1])
    const summary = m[2]

    let appName = "SYSTEM"
    for (let j = i + 1; j < Math.min(i + 10, lines.length); j++) {
      const l2 = lines[j].trim()
      const am = l2.match(/^App name:\s*(.+)$/)
      if (am) { appName = am[1]; break }
      if (l2.startsWith("Notification ")) break
    }

    out.push({ id, app: appName, summary })
  }
  return out
}

const DISMISSED_PATH = `${GLib.get_user_cache_dir()}/ags-hub-dismissed.json`

function loadDismissed(): Set<number> {
  try {
    const raw = safeSync(`cat "${DISMISSED_PATH}" 2>/dev/null || true`).trim()
    if (!raw) return new Set()
    const arr = JSON.parse(raw)
    if (!Array.isArray(arr)) return new Set()
    return new Set(arr.map((x) => Number(x)).filter((n) => Number.isFinite(n)))
  } catch {
    return new Set()
  }
}

const clearedNotifIds = loadDismissed()

function saveDismissed() {
  try {
    const dir = GLib.path_get_dirname(DISMISSED_PATH)
    GLib.mkdir_with_parents(dir, 0o755)
    const payload = JSON.stringify([...clearedNotifIds].slice(-400))
    GLib.file_set_contents(DISMISSED_PATH, payload)
  } catch {
    // ignore
  }
}

const notifs = createPoll<Notif[]>(
  [],
  1500,
  sh(`makoctl history 2>/dev/null | head -n 320 || true`),
  (out) => {
    if (!out) { console.log("Debug: makoctl returned empty string"); return []; }
    const parsed = parseMakoHistory(out)
    const visible = parsed.filter(n => !clearedNotifIds.has(n.id))
    return visible.slice(0, 6)
  },
)

async function clearNotifs() {
  for (const n of notifs()) clearedNotifIds.add(n.id)
  saveDismissed()
}

async function dismissOne(id: number) {
  await safeAsync(`makoctl dismiss -n ${id}`)
  clearedNotifIds.add(id)
  saveDismissed()
}
export function Notifications() {
  return (
    <Gtk.Box class="card" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
      <Gtk.Box spacing={10} valign={Gtk.Align.CENTER}>
        <Gtk.Label class="notif-title" hexpand xalign={0} label="Notifications" />

        <Gtk.Box class="badge">
          <Gtk.Label class="badge-text" label={notifs((n) => String(n.length))} />
        </Gtk.Box>

        <Gtk.Button class="btn-clear" visible={notifs((n) => n.length > 0)} onClicked={clearNotifs}>
          <Gtk.Label label="Clear" />
        </Gtk.Button>
      </Gtk.Box>

      <Gtk.Box visible={notifs((n) => n.length === 0)}>
        <Gtk.Label class="empty-text" label="No new notifications" halign={Gtk.Align.CENTER} />
      </Gtk.Box>

      <Gtk.ScrolledWindow
        visible={notifs((n) => n.length > 0)}
        heightRequest={170}
        hscrollbarPolicy={Gtk.PolicyType.NEVER}
        vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
      >
        <Gtk.Box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
          <For each={notifs}>
            {(n: { id: number; app: string; summary: string }) => (
              <Gtk.Button
                class="notif-item"
                $={(self) => {
                  self.connect("clicked", async () => {
                    self.add_css_class("gone")
                    setTimeout(async () => { await dismissOne(n.id) }, 170)
                  })
                }}
              >
                <Gtk.Box spacing={10} valign={Gtk.Align.CENTER}>
                  <Gtk.CenterBox class="notif-ico">
                    <Gtk.Label
                      $type="center"
                      label="󰋽"
                      halign={Gtk.Align.CENTER}
                      valign={Gtk.Align.CENTER}
                      xalign={0.5}
                      yalign={0.5}
                    />
                  </Gtk.CenterBox>

                  <Gtk.Box orientation={Gtk.Orientation.VERTICAL} spacing={2} hexpand>
                    <Gtk.Label class="notif-app" xalign={0} label={(n.app || "SYSTEM").toUpperCase()} />
                    <Gtk.Label class="notif-msg" xalign={0} wrap label={n.summary || "Notification"} />
                  </Gtk.Box>
                </Gtk.Box>
              </Gtk.Button>
            )}
          </For>
        </Gtk.Box>
      </Gtk.ScrolledWindow>
    </Gtk.Box>
  )
}
