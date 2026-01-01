import { safeAsync } from "./cmd";

export async function toggleDnd() { await safeAsync(`makoctl mode -t do-not-disturb`) }
