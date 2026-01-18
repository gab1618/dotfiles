import { Gtk } from "ags/gtk4";
import { playerMetadata, trimArtUrlPrefix, isPlaying } from "../providers/player";
import { playerNext, playerPrev, playerToggle } from "../utils/player";

export function Player() {
  const isPlayingPoll = isPlaying();
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

        <Gtk.Box
          class="controls"
        >
          <Gtk.Button
            class="prev"
            onClicked={playerPrev}
          >
            <Gtk.Label
              label=""
              class="icon"
            />
          </Gtk.Button>
          <Gtk.Button
            class="toggle"
            onClicked={() => {
              playerToggle()
            }}
          >
            <Gtk.Label
              label={isPlayingPoll(playing => playing ? "󰏤" : "") }
              class="icon"
            />
          </Gtk.Button>
          <Gtk.Button
            class="next"
            onClicked={playerNext}
          >
            <Gtk.Label
              label=""
              class="icon"
            />
          </Gtk.Button>
        </Gtk.Box>
      </Gtk.Box>
    </Gtk.Box>
  )
}
