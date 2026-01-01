import { wifiOn } from "../providers/wifi";
import { safeAsync } from "./cmd";

export async function toggleWifi() {
  await safeAsync(`nmcli radio wifi ${wifiOn() ? "off" : "on"}`)
}

export async function launchNMConnectionEditor() {
  await safeAsync(`nm-connection-editor`)
}
