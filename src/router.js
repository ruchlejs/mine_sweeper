import { createWebHistory, createRouter } from "vue-router";
import SettingsPage from "./pages/SettingsPage.vue";
import HomePage from "./pages/MainPage.vue";
import AccountPage from "./pages/AccountPage.vue";

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
  {
    path: "/account",
    name: "Account",
    component: AccountPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: links,
});

export default router;
