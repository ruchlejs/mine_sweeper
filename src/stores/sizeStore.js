import { defineStore } from "pinia";

export const useSizeStore = defineStore("size", {
  state: () => ({
    size: 10,
  }),
  actions: {
    setSize(newSize) {
      this.size = newSize;
    },
  },
});
