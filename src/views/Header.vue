<template>
  <div class="Navbar">
    <Navbar></Navbar>
  </div>
</template>

<script>
// @ is an alias to /src
import Navbar from "@/components/Navbar.vue";

export default {
  name: "header-item",
  components: {
    Navbar,
  },
};
</script>
