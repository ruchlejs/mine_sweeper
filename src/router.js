import { createWebHistory, createRouter } from "vue-router";
import SettingsPage from "./pages/SettingsPage.vue";
import HomePage from "./pages/MainPage.vue";

const links = [
  {
    path: "/",
    name: "Home",
    component: HomePage,
  },
  {
    path: "/settings",
    name: "Settings",
    component: SettingsPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: links,
});

export default router;
