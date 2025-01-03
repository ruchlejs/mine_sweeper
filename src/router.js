import { createWebHistory, createRouter } from "vue-router";
import SettingsPage from "./pages/SettingsPage.vue";
import HomePage from "./pages/MainPage.vue";
import AccountPage from "./pages/AccountPage.vue";
import LoginPage from "./pages/LoginPage.vue";

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
    meta: { requiresAuth: true },
  },
  {
    path: "/login",
    name: "Login",
    component: LoginPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: links,
});

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem("auth-token");
  if (to.meta.requiresAuth && !token) {
    next("/login");
  } else {
    next();
  }
});

export default router;
