<template>
  <div class="content">
    <div id="editions-input" />
  </div>
</template>

<script>
const SaxonJS = require("saxon-js");
const editions = require("../datat/tei-editions.sef.json");

export default {
  name: "GotStarted",
  data() {
    return {
    };
  },
  mounted() {
    SaxonJS.transform({
        stylesheetLocation: editions, // https://tei4arche.acdh-dev.oeaw.ac.at
        sourceLocation: "https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0001.xml",
        destination: "serialized"
    }, "async")
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
div {
  margin: 1em;
}
table,
td {
  text-align: left;
  border: 1px solid lightgrey;
}
td {
  padding: 0.5em;
}
</style>
