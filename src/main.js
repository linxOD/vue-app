import Vue from "vue";
import App from "./App.vue";
import router from "./router";

import { BootstrapVue, IconsPlugin } from "bootstrap-vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
// import { FundamentFooter, FundamentNav } from "acdh-fundament-vuetify";
// const { FundamentFooter, FundamentNav } = require("acdh-fundament-vuetify");

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
// Vue.use(FundamentFooter);
// Vue.use(FundamentNav);
Vue.config.productionTip = false;
// import './main.scss'

new Vue({
  router,
  render: function (h) {
    return h(App);
  },
}).$mount("#app");
