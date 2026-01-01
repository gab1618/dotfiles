import { createPoll } from "ags/time"
import { sh } from "../utils/cmd"

export const wifiOn = createPoll(false, 1500, sh(`nmcli -t -f WIFI g 2>/dev/null | head -n1 || true`), (o) => o.trim() === "enabled")
export const wifiSSID = createPoll("WiFi", 2500, sh(`nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}' || true`), (o) => {
  const s = o.trim() || "WiFi"
  return s.length > 9 ? s.slice(0, 9) : s
})
