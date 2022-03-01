<template>
  <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar">
    <b-navbar toggleable="lg" type="dark" variant="dark">
      <div class="container">
        <b-navbar-brand href="/">NavBar</b-navbar-brand>
        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item>
              <router-link to="/">Home</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/about">About</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/started">Get Stared</router-link>
            </b-nav-item>
          </b-navbar-nav>
        </b-collapse>
      </div>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: "navbar-item",
};
</script>

<style>
a {
  color: antiquewhite;
}
a:hover {
  color: aqua;
}
</style>
