import { createPoll } from "ags/time"
import { sh } from "../utils/cmd"

export const btOn = createPoll(false, 1500, sh(`bluetoothctl show 2>/dev/null | grep 'Powered:' | awk '{print $2}' || true`), (o) => o.trim() === "yes")
export const btDev = createPoll(
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
