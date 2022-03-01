import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home-item",
    component: Home,
  },
  {
    path: "/about-item",
    name: "about-item,",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: function () {
      return import(/* webpackChunkName: "about" */ "../views/About.vue");
    },
  },
  {
    path: "/started",
    name: "started-item",
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/Started.vue"),
  },
];

const router = new VueRouter({
  routes,
});

export default router;
