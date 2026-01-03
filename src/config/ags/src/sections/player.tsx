import { Gtk } from "ags/gtk4";
import { playerMetadata, trimArtUrlPrefix } from "../providers/player";

export function Player() {
  return (
    <Gtk.Box class="section player" orientation={Gtk.Orientation.HORIZONTAL}>

    <Gtk.Box
        class="thumb"
        overflow={Gtk.Overflow.HIDDEN}
    >
      <Gtk.Image
        file={playerMetadata(m => trimArtUrlPrefix(m.artUrl))}
        pixelSize={64}
      />
    </Gtk.Box>
      <Gtk.Box
        orientation={Gtk.Orientation.VERTICAL}
        class="details"
        hexpand
        halign={Gtk.Align.START}
      >
        <Gtk.Label
          label={playerMetadata(i => i.title)}
          class="title"
          halign={Gtk.Align.START}
        />
        <Gtk.Label
          label={playerMetadata(i => i.artist)}
          class="artist"
          halign={Gtk.Align.START}
        />
      </Gtk.Box>
    </Gtk.Box>
  )
}
