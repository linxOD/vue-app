<template>
  <div class="gotStarted">
    <GotStarted></GotStarted>
  </div>
</template>

<script>
// @ is an alias to /src
import GotStarted from "@/components/GotStarted.vue";
const SaxonJS = require("saxon-js");
const axios = require('axios');

export default {
  name: "Started",
  components: {
    GotStarted,
  },
  data() {
    return {
      xmlItems: [],
      sefJson: []  
    }
  },
  created() {
    axios.get('https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0001.xml',
     {
      responseType: "text"
     }
    )
    .then(response => {
        // console.log(response.headers)
        var parser = new DOMParser();
        var xmlDoc = parser.parseFromString(response.data, "text/xml");
        this.xmlItems = xmlDoc;        
    })
    .then(() => {
      axios.get('https://raw.githubusercontent.com/linxOD/vue-app/main/src/datat/tei-editions.sef.json',
        {
          responseType: "json"
        }
      )
      .then(response => {
        this.sefJson = response.data;
      })
      .then(() => {
        console.log(this.xmlItems);
        console.log(this.sefJson);
        SaxonJS.transform({      
          sourceNode: this.xmlItems,
          stylesheetInternal: this.sefJson,
          destination: "serialized"
        }, "async");
      });
    });   
    // .then(result => console.log("Transformation result: " + result.principalResult.toString()))
    // .catch(err => console.log("Transformation failed: " + err));
    // axios.get("https://raw.githubusercontent.com/linxOD/vue-app/main/src/datat/tei-editions.sef.json")
    // .then((response) => {
    //   console.log(response.data);
    //   SaxonJS.transform({
    //     sourceFileName: "https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0001.xml",
    //     stylesheetFileName: response.data,        
    //     destination: "serialized"
    //   }, "async");
    // });
    // const stylesheetParams = {};
    // SaxonJS.getResource({
    //   file: "@/data/editions/amp-transcript__0001.xml",
    //   type: "xml"
    // })
    // .then(doc => {
    //   stylesheetParams["Q{}lookup-doc"] = doc
    //   console.log(doc);
    // })
    // .then(() => {
    //   SaxonJS.transform({
    //     "stylesheetFileName": "https://raw.githubusercontent.com/linxOD/vue-app/main/src/datat/tei-editions.sef.json",
    //     "stylesheetParams": stylesheetParams,
    //     "destination": "serialized"
    //   }, "async");
    // })
    // .then(result => console.log("Transformation result: " + result.principalResult.toString()))    
    // .catch(err => console.log("Transformation failed: " + err));
    // SaxonJS.transform({
    //     stylesheetFileName: sef,
    //     sourceFileName: xml,
    //     destination: "serialized"
    // }, "async");
  }
};
</script>
