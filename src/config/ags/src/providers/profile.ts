import { createPoll } from "ags/time";
import { sh } from "../utils/cmd";

export const profile = createPoll("user", 60 * 1000, sh("whoami"))
