<template>
  <div class="hfeed site" id="page">
    <Navbar></Navbar>
    <div class="container">
      <router-view />
    </div>
    <Footer></Footer>
    <Imprint></Imprint>
  </div>
</template>

<script>
// @ is an alias to /src
import Navbar from "@/components/Navbar.vue";
import Footer from "@/components/Footer.vue";
import Imprint from "@/components/Imprint.vue";

export default {
  name: "Header",
  components: {
    Navbar,
    Footer,
    Imprint,
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#page {
  background-color: #f1f1f1;
}
.container {
  padding: 1em;
}
.content {
  margin: 2em auto;
  text-align: center;
}
</style>
