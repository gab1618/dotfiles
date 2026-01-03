import { Gtk } from "ags/gtk4";
import { playerMetadata } from "../providers/player";

export function Player() {
  return (
    <Gtk.Box class="section" orientation={Gtk.Orientation.VERTICAL}>
      <Gtk.Label label={playerMetadata(i => i.length.toString())} />
      <Gtk.Label label={playerMetadata(i => i.url)} />
      <Gtk.Label label={playerMetadata(i => i.album)} />
      <Gtk.Label label={playerMetadata(i => i.artist)} />
      <Gtk.Label label={playerMetadata(i => i.artUrl)} />
      <Gtk.Label label={playerMetadata(i => i.title)} />
      <Gtk.Label label={playerMetadata(i => i.trackid)} />
    </Gtk.Box>
  )
}
