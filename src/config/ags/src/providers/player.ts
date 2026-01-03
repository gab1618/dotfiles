import { createPoll } from "ags/time";
import { sh } from "../utils/cmd";

export interface PlayerMetadata {
  trackid: string
  title: string
  album: string
  artist: string
  artUrl: string
  url: string
  length: number
}

type PlayerMetadataKey = keyof PlayerMetadata;

type MetadataLine = {
  app: string;
  key: PlayerMetadataKey;
  value: string;
}

function parseMetadataLine(line: string): MetadataLine | undefined {
  const lineParts = line.trim().split(" ").filter(p => p.trim() !== "");

  const keyParts = lineParts[1].split(":");
  const key = keyParts[1] as PlayerMetadataKey;
  const app = lineParts[0];
  const value = lineParts.slice(2).join(" ")

  return {
    value,
    key,
    app,
  }

}

const getDefaultPlayerMetadata = () => ({
  url: "",
  trackid: "",
  title: "",
  album: "",
  artist: "",
  artUrl: "",
  length: 0
} as PlayerMetadata);

export function parsePlayerMetadata(rawData: string) {
  const lines = rawData
    .split("\n")
    .filter(l => l.trim() !== "");
  let metadata = getDefaultPlayerMetadata();
  for (const line of lines) {
    const parsedLine = parseMetadataLine(line);
    if (!parsedLine) continue;
    // @ts-ignore
    metadata[parsedLine.key] = parsedLine.value;
  }

  return metadata
}

export function trimArtUrlPrefix(val: string) {
  return val.slice(5)
}

export const playerMetadata = createPoll(getDefaultPlayerMetadata(), 1000, sh("playerctl metadata"), parsePlayerMetadata)

export type PlayerStatus = "Paused" | "Playing";
export const isPlaying = createPoll(false, 1000, sh("playerctl status"), o => o === "Playing")
