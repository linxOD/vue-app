<template>
  <div class="gotStarted">
    <GotStarted></GotStarted>
  </div>
</template>

<script>
// @ is an alias to /src
import GotStarted from "@/components/GotStarted";
// import { getFile } from "@/service/request";
// const SaxonJS = require("saxon-js");
// const axios = require('axios');

// import {
//   // openFile,
//   ARCHEdownloadResourceIdM2,
//   ARCHErdfQuery,
// } from "arche-api/src";

export default {
  name: "started-item",
  components: {
    GotStarted,
  },
//   data() {
//     return {
//       title: "",
//       numberOfItems: 0,
//       childCollection: [],
//       downloaded: false,
//     };
//   },
//   methods: {
//     getData() {
//       var options = {
//         host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
//         format: "application/n-triples",
//         resourceId: "146747",
//         readMode: "resource",
//       };
//       ARCHEdownloadResourceIdM2(options).then((data) => {
//         const options = {
//           expiry: 14,
//           subject: null,
//           predicate: null,
//           object: null,
//           paginate: false,
//         };
//         var topCol = ARCHErdfQuery(options, data);
//         // console.log(topCol);
//         topCol.value.forEach((el) => {
//           if (el.hasTitle) {
//             var hasTitle = el.hasTitle;
//             this.title = hasTitle.object;
//           }
//           if (el.hasNumberOfItems) {
//             var hasNumberOfItems = el.hasNumberOfItems;
//             var items = hasNumberOfItems.object.replace(
//               "^^http://www.w3.org/2001/XMLSchema#decimal",
//               ""
//             );
//             this.numberOfItems = items;
//           }
//         });
//       });
//       var options2 = {
//         host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
//         format: "application/n-triples",
//         resourceId: "146747",
//         readMode: "neighbors",
//       };
//       ARCHEdownloadResourceIdM2(options2).then((data) => {
//         const options = {
//           expiry: 14,
//           subject: null,
//           predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
//           object: "https://arche-curation.acdh-dev.oeaw.ac.at/api/146747",
//           paginate: false,
//         };
//         var childCol = ARCHErdfQuery(options, data);
//         // console.log(childCol);
//         childCol.value.forEach((el) => {
//           // var rsID = `col_${Math.random().toString(16).slice(2)}`;
//           var collections = {};
//           // console.log(el);
//           var id = el.isPartOf.subject.replace(
//             "https://arche-curation.acdh-dev.oeaw.ac.at/api/",
//             ""
//           );
//           const options = {
//             host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
//             format: "application/n-triples",
//             resourceId: id,
//             readMode: "resource",
//           };
//           ARCHEdownloadResourceIdM2(options).then((data) => {
//             const options = {
//               expiry: 14,
//               subject: null,
//               predicate: null,
//               object: null,
//               paginate: false,
//             };
//             var child_col = ARCHErdfQuery(options, data);
//             // console.log(child_col);
//             child_col.value.forEach((el) => {
//               if (el.hasTitle) {
//                 collections["title"] = el.hasTitle.object;
//               }
//               if (el.hasDescription) {
//                 collections["description"] = el.hasDescription.object;
//               }
//               if (el.hasVersion) {
//                 collections["version"] = el.hasVersion.object;
//               }
//               // console.log(collections);
//             });
//           });
//           this.childCollection.push(collections);
//         });
//       });
//     },
//   },
};
// getData1() {
//   getFile(
//     "https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json"
//   ).then((data) => {
//     // console.log(data);
//     this.json = data;
//   });
//   getFile(
//     "https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0008.xml"
//   ).then((data) => {
//     // console.log(data);
//     this.xml = data;
//   });
// },
// getData2() {
//   getFile(
//     "https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json"
//   ).then((data) => {
//     // console.log(data);
//     this.json = data;
//   });
//   getFile(
//     "https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0001.xml"
//   ).then((data) => {
//     // console.log(data);
//     this.xml = data;
//   });
// },
// getData3() {
//   getFile(
//     "https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json"
//   ).then((data) => {
//     // console.log(data);
//     this.json = data;
//   });
//   getFile(
//     "https://raw.githubusercontent.com/Auden-Musulin-Papers/amp-data/main/data/editions/amp-transcript__0002.xml"
//   ).then((data) => {
//     // console.log(data);
//     this.xml = data;
//   });
// },
// showData() {
//   setTimeout(() => {
//     SaxonJS.transform(
//       {
//         stylesheetText: this.json,
//         sourceText: this.xml,
//         destination: "serialized",
//       },
//       "async"
//     ).then((data) => {
//       this.html = data.principalResult;
//       this.htmlObject = data;
//       // console.log(this.htmlObject);
//     });
//   }, 100);
</script>
