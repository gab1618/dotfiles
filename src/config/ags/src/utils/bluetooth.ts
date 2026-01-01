import { btOn } from "../providers/bluetooth";
import { safeAsync } from "./cmd";

export async function toggleBluetooth() {
  await safeAsync(`bluetoothctl power ${btOn() ? "off" : "on"}`)
}

export async function launchBlueman() {
  await safeAsync(`blueman-manager`)
}
