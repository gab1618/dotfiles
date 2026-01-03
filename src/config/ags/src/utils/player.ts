import { safeAsync } from "./cmd";

export async function playerNext() {
  await safeAsync("playerctl next")
}
export async function playerPrev() {
  await safeAsync("playerctl previous")
}
export async function playerToggle() {
  await safeAsync("playerctl play-pause")
}
