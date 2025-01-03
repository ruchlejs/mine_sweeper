import { createApp } from "vue";
import App from "./App.vue";
import router from "./router.js";

import ElementPlus from "element-plus";
import "element-plus/dist/index.css";

import { createPinia } from "pinia";

createApp(App).use(router).use(ElementPlus).use(createPinia()).mount("#app");
