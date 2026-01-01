import { createPoll } from "ags/time";
import { sh } from "../utils/cmd";

export const dndOn = createPoll(false, 1500, sh(`makoctl mode 2>/dev/null || true`), (o) => o.includes("do-not-disturb"))
