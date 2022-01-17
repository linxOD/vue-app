<template>
  <div class="gotStarted">
    <GotStarted></GotStarted>
    <button @click="showData()">Download</button>
    <div v-html="html"></div>
  </div>
</template>

<script>
// @ is an alias to /src
import GotStarted from "@/components/GotStarted.vue";
import { getFile } from "@/service/request";
const SaxonJS = require("saxon-js");
// const axios = require('axios');

export default {
  name: "Started",
  components: {
    GotStarted,
  },
  data() {
    return {
      xmlItems: [],
      sefJson: [],
      xml: "",
      json: "",
      html: "",
      htmlObject: "",
    };
  },
  mounted() {
    getFile("https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json").then((data) => {
      // console.log(data);
      this.json = data;
    });
    getFile("https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0008.xml").then((data) => {
      // console.log(data);
      this.xml = data;
    });
  },
  methods: {
    showData() {
      SaxonJS.transform(
        {
          stylesheetText: this.json,
          sourceText: this.xml,
          destination: "serialized",
        },
        "async"
      ).then((data) => {
        this.html = data.principalResult;
        this.htmlObject = data;
        console.log(this.htmlObject);
      });
    },
  },
};
</script>
