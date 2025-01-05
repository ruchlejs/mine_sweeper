import { defineStore } from "pinia";

export const useSettingsStore = defineStore("settings", {
  state: () => ({
    size: 10,
    difficulty: "easy",
    mine: 10,
    theme: "dark-red",
  }),
  actions: {
    setSize(newSize) {
      this.size = newSize;
    },
    setDifficulty(newDifficulty) {
      this.difficulty = newDifficulty;
    },
    setTheme(newTheme) {
      this.theme = newTheme;
    },
    setMine(newMine) {
      this.mine = newMine;
    },
  },
});
