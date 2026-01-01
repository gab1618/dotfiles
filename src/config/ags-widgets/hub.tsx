#!/usr/bin/env -S ags run

import { readFile } from "ags/file"
import { Astal } from "ags/gtk4"
import app from "ags/gtk4/app"
import { sh, safeAsync, safeSync } from "./src/utils/cmd"
import { createPoll } from "ags/time"
import scss from "./style.scss"

import Gdk from "gi://Gdk?version=4.0"
import GLib from "gi://GLib?version=2.0"
import Gtk from "gi://Gtk?version=4.0"
import Pango from "gi://Pango?version=1.0"
import { Notifications } from "./src/components/Notifications"

const prof = createPoll("user", 60 * 1000, sh("whoami"))

const TOP_GAP = 50
const RIGHT_GAP = 10
const PANEL_W = 340
const PANEL_H = 600

/* ---------------- CPU/RAM ---------------- */
let prevTotal = 0
let prevIdle = 0

const cpuPct = createPoll("0%", 2000, () => {
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

const ramPct = createPoll("0%", 3000, () => {
  try {
    const mem = readFile("/proc/meminfo")
    const total = Number(/MemTotal:\s+(\d+)/.exec(mem)?.[1] || 0)
    const avail = Number(/MemAvailable:\s+(\d+)/.exec(mem)?.[1] || 0)
    if (!total) return "0%"
    const usage = Math.max(0, Math.min(1, 1 - avail / total))
    return `${Math.round(usage * 100)}%`
  } catch { return "0%" }
})

/* ---------------- WiFi/BT/DND ---------------- */
const wifiOn = createPoll(false, 1500, sh(`nmcli -t -f WIFI g 2>/dev/null | head -n1 || true`), (o) => o.trim() === "enabled")
const wifiSSID = createPoll("WiFi", 2500, sh(`nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}' || true`), (o) => {
  const s = o.trim() || "WiFi"
  return s.length > 9 ? s.slice(0, 9) : s
})

const btOn = createPoll(false, 1500, sh(`bluetoothctl show 2>/dev/null | grep 'Powered:' | awk '{print $2}' || true`), (o) => o.trim() === "yes")
const btDev = createPoll(
  "Off",
  1500,
  sh(`
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
      dev="$(bluetoothctl devices Connected | head -n1 | cut -d' ' -f3-)"
      if [ -n "$dev" ]; then
        echo "$dev"
      else
        echo "On"
      fi
    else
      echo "Off"
    fi
  `),
  (o) => {
    const d = o.trim() || "Off"
    return d.length > 9 ? d.slice(0, 9) : d
  },
)

const dndOn = createPoll(false, 1500, sh(`makoctl mode 2>/dev/null || true`), (o) => o.includes("do-not-disturb"))
async function toggleDnd() { await safeAsync(`makoctl mode -t do-not-disturb`) }

function readVolNow(): number {
  const o = safeSync(`pactl get-sink-volume @DEFAULT_SINK@ | head -n1 || true`)
  const m = o.match(/(\d+)%/)
  const n = Number(m?.[1] || 0)
  return Number.isFinite(n) ? Math.max(0, Math.min(150, n)) : 0
}

const volAdj = new Gtk.Adjustment({
  lower: 0, upper: 150,
  step_increment: 1, page_increment: 5,
  value: readVolNow(),
})

let lastUserVolMs = 0

async function setVolumePct(v: number) {
  lastUserVolMs = Date.now()
  await safeAsync(`pactl set-sink-volume @DEFAULT_SINK@ ${Math.round(v)}%`)
}

// Live sync (updates when you use keyboard keys / other apps)
GLib.timeout_add(GLib.PRIORITY_DEFAULT, 350, () => {
  if (Date.now() - lastUserVolMs >= 450) volAdj.set_value(readVolNow())
  return GLib.SOURCE_CONTINUE
})

function Chip(props: { icon: string; text: any }) {
  return (
    <Gtk.Box class="chip" spacing={6} valign={Gtk.Align.CENTER}>
      <Gtk.Label class="chip-icon" label={props.icon} />
      <Gtk.Label class="chip-text" label={props.text} />
    </Gtk.Box>
  )
}

function Header() {
  return (
    <Gtk.CenterBox class="header" valign={Gtk.Align.CENTER}>
      <Gtk.Box $type="start" spacing={12} valign={Gtk.Align.CENTER}>
        <Gtk.Label class="name" xalign={0} label={prof} />
      </Gtk.Box>

      <Gtk.Box $type="end" spacing={8} valign={Gtk.Align.CENTER}>
        <Chip icon="" text={cpuPct} />
        <Chip icon="" text={ramPct} />
      </Gtk.Box>
    </Gtk.CenterBox>
  )
}

function ButtonsAndSlidersCard() {
  return (
    <Gtk.Box class="card" orientation={Gtk.Orientation.VERTICAL} spacing={10}>
      <Gtk.Box class="btn-row" spacing={12} homogeneous>
        <Gtk.Button
          class={wifiOn((on) => (on ? "qs-btn active" : "qs-btn"))}
          hexpand
          onClicked={async () => {
            await safeAsync(`nmcli radio wifi ${wifiOn() ? "off" : "on"}`)
          }}
          $={(btn) => {
            const right = new Gtk.GestureClick()
            right.set_button(3)
            right.connect("pressed", () => safeAsync(`nm-connection-editor`))
            btn.add_controller(right)
          }}
        >
          <Gtk.Box orientation={Gtk.Orientation.VERTICAL} spacing={3} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
            <Gtk.Label class="qs-icon" label="󰤨" halign={Gtk.Align.CENTER} />
            <Gtk.Label class="qs-label" label={wifiSSID} max_width_chars={8} ellipsize={Pango.EllipsizeMode.END} />
          </Gtk.Box>
        </Gtk.Button>

        <Gtk.Button
          class={btOn((on) => (on ? "qs-btn active" : "qs-btn"))}
          hexpand
          onClicked={async () => {
            await safeAsync(`bluetoothctl power ${btOn() ? "off" : "on"}`)
          }}
          $={(btn) => {
            const right = new Gtk.GestureClick()
            right.set_button(3)
            right.connect("pressed", () => safeAsync(`blueman-manager`))
            btn.add_controller(right)
          }}
        >
          <Gtk.Box orientation={Gtk.Orientation.VERTICAL} spacing={3} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
            <Gtk.Label class="qs-icon" label="󰂯" />
            <Gtk.Label class="qs-label" label={btDev} max_width_chars={9} ellipsize={Pango.EllipsizeMode.END} />
          </Gtk.Box>
        </Gtk.Button>

        <Gtk.Button
          class={dndOn((on) => (on ? "qs-btn active" : "qs-btn"))}
          hexpand
          onClicked={toggleDnd}
        >
          <Gtk.Box orientation={Gtk.Orientation.VERTICAL} spacing={3} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
            <Gtk.Label class="qs-icon" label="󰂛" />
            <Gtk.Label class="qs-label" label={dndOn((x) => (x ? "DND" : "Off"))} />
          </Gtk.Box>
        </Gtk.Button>
      </Gtk.Box>

      <Gtk.Box class="sliders-box" orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        <Gtk.Box class="slider-row" spacing={10} valign={Gtk.Align.CENTER}>
          <Gtk.Label class="slider-icon" label="󰕾" />
          <Gtk.Scale
            hexpand
            draw_value={false}
            orientation={Gtk.Orientation.HORIZONTAL}
            adjustment={volAdj}
            $={(self) => self.connect("value-changed", () => setVolumePct(self.get_value()))}
          />
        </Gtk.Box>
      </Gtk.Box>
    </Gtk.Box>
  )
}

/* ---------------- Window ---------------- */
let hubWin: any = null

function Hub() {
  const A = Astal.WindowAnchor

  return (
    <window
      name="hub"
      class="Hub"
      application={app}
      monitor={0}
      visible={false}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={A.TOP | A.BOTTOM | A.LEFT | A.RIGHT}
      $={(self) => {
        hubWin = self

        const k = new Gtk.EventControllerKey()
        k.connect("key-pressed", (_: any, keyval: number) => {
          if (keyval === Gdk.KEY_Escape) self.visible = false
        })
        self.add_controller(k)

        self.connect("notify::visible", () => {
          if (!self.visible) return
          volAdj.set_value(readVolNow())
        })
      }}
    >
      <Gtk.Overlay>
        <Gtk.Button class="scrim" hexpand vexpand onClicked={() => { if (hubWin) hubWin.visible = false }} />
        <Gtk.Box
          $type="overlay"
          class="panel"
          orientation={Gtk.Orientation.VERTICAL}
          widthRequest={PANEL_W}
          heightRequest={PANEL_H}
          halign={Gtk.Align.END}
          valign={Gtk.Align.START}
          css={`margin-top:${TOP_GAP}px; margin-right:${RIGHT_GAP}px;`}
        >
          <Header />
          <ButtonsAndSlidersCard />
          <Notifications />
        </Gtk.Box>
      </Gtk.Overlay>
    </window>
  )
}

app.start({
  css: scss,
  main() {
    app.hold()
    return Hub()
  },
})
