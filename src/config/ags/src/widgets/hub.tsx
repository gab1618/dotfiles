import { Astal } from "ags/gtk4"
import app from "ags/gtk4/app"

import Gdk from "gi://Gdk?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Pango from "gi://Pango?version=1.0"
import { Notifications } from "../components/Notifications"
import { ramPct } from "../providers/ram"
import { wifiOn, wifiSSID } from "../providers/wifi"
import { btDev, btOn } from "../providers/bluetooth"
import { profile } from "../providers/profile"
import { dndOn } from "../providers/notification"
import { cpuPct } from "../providers/cpu"
import { toggleDnd } from "../utils/notification"
import { readVolNow, setVolumePct, volAdj } from "../utils/volume"
import { launchNMConnectionEditor, toggleWifi } from "../utils/wifi"
import { launchBlueman, toggleBluetooth } from "../utils/bluetooth"

const TOP_GAP = 50
const RIGHT_GAP = 10
const PANEL_W = 340
const PANEL_H = 600

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
        <Gtk.Label class="name" xalign={0} label={profile} />
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
          onClicked={toggleWifi}
          $={(btn) => {
            const right = new Gtk.GestureClick()
            right.set_button(3)
            right.connect("pressed", launchNMConnectionEditor)
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
          onClicked={toggleBluetooth}
          $={(btn) => {
            const right = new Gtk.GestureClick()
            right.set_button(3)
            right.connect("pressed", launchBlueman)
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

export function Hub() {
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

