<template>
  <div class="content">
    <!-- <div class="row">
      <div class="col">
        <h3>
          <button class="btn btn-round bg-light text-light" @click="getData">
            Download TopCollection
          </button>
        </h3>
      </div>
    </div> -->
    <div class="row">
      <div class="card" v-if="downloaded1">
        <div class="card-body">
          <h2>{{ title }}</h2>
          <h4>Number of resources found: {{ numberOfItems }}</h4>
          <button
            class="btn btn-round btn-dark text-light"
            :data-key="topColIdentifier"
            type="childCols"
            @click="getDataRs"
          >
            load more data
          </button>
        </div>
        <div class="card-footer" v-if="breadcrum.length != 0">
          <span v-if="breadcrum.length != 0">
            <a :data-key="breadcrum" @click="getDataRs" type="childCols">
              ChildCols
            </a>
          </span>
          <span v-if="breadcrumCol.length != 0">
            |
            <a :data-key="breadcrumCol" @click="getDataRs" type="cols">
              Collection
            </a>
          </span>
          <span v-if="breadcrumRs.length != 0">
            |
            <a :data-key="breadcrumRs" @click="getDataRs" type="resources">
              Resource
            </a>
          </span>
          <span v-if="breadcrumCol.length != 0">
            |
            <a :data-key="breadcrumCol" @click="getDataRs" type="resources">
              load more
            </a>
          </span>
        </div>
      </div>
    </div>
    <div class="row">
      <div v-if="downloaded">
        <div class="card" v-for="value in childCollection" :key="value.title">
          <div class="card-body">
            <table class="table table-striped table-hover">
              <tbody>
                <tr>
                  <td>Title Collections</td>
                  <td>{{ value.title }}</td>
                </tr>
                <tr>
                  <td>Description</td>
                  <td>{{ value.description }}</td>
                </tr>
                <tr>
                  <td>Version</td>
                  <td>{{ value.version }}</td>
                </tr>
                <tr>
                  <td>Identifier</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.identifier"
                      type="cols"
                      @click="getDataRs"
                    >
                      load more
                    </button>
                    {{ value.identifier }}
                  </td>
                </tr>
                <tr>
                  <td>Is part of</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.isPartOf"
                      type="cols"
                      @click="getDataRs"
                    >
                      load more
                    </button>
                    {{ value.isPartOf }}
                  </td>
                </tr>
                <tr>
                  <td>Is newer Version of</td>
                  <td>{{ value.isNewVersionOf }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div v-if="downloaded2">
        <div class="card" v-for="value in collections" :key="value.title">
          <div class="card-body">
            <table class="table table-striped table-hover">
              <tbody>
                <tr>
                  <td>Title Resources</td>
                  <td>{{ value.title }}</td>
                </tr>
                <tr>
                  <td>Description</td>
                  <td>{{ value.description }}</td>
                </tr>
                <tr>
                  <td>Identifier</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.identifier"
                      type="resources"
                      @click="getDataRs"
                    >
                      load more
                    </button>
                    {{ value.identifier }}
                  </td>
                </tr>
                <tr>
                  <td>Is part of</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.isPartOf"
                      type="resources"
                      @click="getDataRs"
                    >
                      {{ value.isPartOf }}
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Is newer Version of</td>
                  <td>{{ value.isNewVersionOf }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div v-if="downloaded3">
        <div class="card" v-for="value in resources" :key="value.title">
          <div class="card-body">
            <table class="table table-striped table-hover">
              <tbody>
                <tr>
                  <td>Title Resources</td>
                  <td>{{ value.title }}</td>
                </tr>
                <tr>
                  <td>Description</td>
                  <td>{{ value.description }}</td>
                </tr>
                <tr>
                  <td>Identifier</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.identifier"
                      type="resources"
                      @click="getDataFiles"
                    >
                      load more
                    </button>
                    {{ value.identifier }}
                  </td>
                </tr>
                <tr>
                  <td>Is part of</td>
                  <td>
                    <button
                      class="btn btn-round btn-dark text-light"
                      :data-key="value.isPartOf"
                      type="resources"
                      @click="getDataFiles"
                    >
                      {{ value.isPartOf }}
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Is newer Version of</td>
                  <td>{{ value.isNewVersionOf }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {
  // openFile,
  ARCHEdownloadResourceIdM2,
  ARCHErdfQuery,
} from "arche-api/src";

import { getFile } from "@/service/request";
const SaxonJS = require("saxon-js");

export default {
  name: "got-started",
  data() {
    return {
      title: "",
      numberOfItems: 0,
      topColIdentifier: "",
      childCollection: [],
      collections: [],
      resources: [],
      downloaded: false,
      downloaded2: false,
      downloaded3: false,
      downloaded1: false,
      breadcrum: "",
      breadcrumCol: "",
      breadcrumRs: "",
      host: "https://arche.acdh.oeaw.ac.at/api",
      archeID: "140074",
      // projectSize: 0,
      paginationStart: 0,
      paginationEnd: 20,
      count: 0,
      editions: "",
      xml: "",
      json: "",
      htmlObject: "",
      html: "",
    };
  },
  mounted() {
    // var toColID = "365835";
    this.childCollection = [];
    ARCHEdownloadResourceIdM2({
      host: this.host,
      format: "application/n-triples",
      resourceId: this.archeID,
      readMode: "resource",
    }).then((data) => {
      var topCol = ARCHErdfQuery(
        {
          expiry: 14,
          subject: null,
          predicate: null,
          object: null,
          paginate: false,
        },
        data
      );
      topCol.value.forEach((el) => {
        if (el.hasTitle) {
          var hasTitle = el.hasTitle;
          this.title = hasTitle.object;
        }
        if (el.hasIdentifier) {
          if (el.hasIdentifier.object.includes("api")) {
            this.topColIdentifier = el.hasIdentifier.object;
          }
        }
        if (el.hasNumberOfItems) {
          var hasNumberOfItems = el.hasNumberOfItems;
          var items = hasNumberOfItems.object.replace(
            "^^http://www.w3.org/2001/XMLSchema#decimal",
            ""
          );
          this.numberOfItems = items;
        }
      });
      this.downloaded1 = true;
    });
  },
  methods: {
    getDataRs(event) {
      this.downloaded = false;
      this.downloaded2 = false;
      this.downloaded3 = false;
      this.childCollection = [];
      this.collections = [];
      this.resources = [];
      var element = event.currentTarget;
      var dataKey = element.getAttribute("data-key");
      var type = element.getAttribute("type");
      console.log(this.count);
      if (this.count >= 2) {
        this.paginationStart += 21;
        this.paginationEnd += 20;
        // var items = subCols.fullLength;
        // this.projectSize = Math.ceil(items / 20);
        console.log(this.paginationStart);
        console.log(this.paginationEnd);
      }
      this.count += 1;
      console.log(this.count);
      if (this.editions.length == 0) {
        ARCHEdownloadResourceIdM2({
          host: this.host,
          format: "application/n-triples",
          resourceId: dataKey.replace(this.host + "/", ""),
          readMode: "neighbors",
        }).then((rs) => {
          var subCols = ARCHErdfQuery(
            {
              expiry: 14,
              subject: null,
              predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
              object: dataKey,
              paginate: [this.paginationStart, this.paginationEnd],
            },
            rs
          );
          subCols.value.forEach((el) => {
            var res = {};
            ARCHEdownloadResourceIdM2({
              host: this.host,
              format: "application/n-triples",
              resourceId: el.isPartOf.subject.replace(this.host + "/", ""),
              readMode: "resource",
            })
              .then((data) => {
                var rss = ARCHErdfQuery(
                  {
                    expiry: 14,
                    subject: null,
                    predicate: null,
                    object: null,
                    paginate: false,
                  },
                  data
                );
                rss.value.forEach((el) => {
                  if (el.hasTitle) {
                    res["title"] = el.hasTitle.object;
                  }
                  if (el.hasDescription) {
                    res["description"] = el.hasDescription.object;
                  }
                  if (el.hasIdentifier) {
                    if (el.hasIdentifier.object.includes("api")) {
                      res["identifier"] = el.hasIdentifier.object;
                    }
                  }
                  if (el.isNewVersionOf) {
                    res["isNewVersionOf"] = el.isNewVersionOf.object;
                  }
                  if (el.isPartOf) {
                    res["isPartOf"] = el.isPartOf.object;
                  }
                });
              })
              .then(() => {
                if (type == "childCols") {
                  this.childCollection.push(res);
                  this.downloaded = true;
                  this.breadcrum = dataKey;
                }
                if (type == "cols") {
                  this.collections.push(res);
                  this.downloaded2 = true;
                  this.breadcrumCol = dataKey;
                  this.editions = rs;
                }
                if (type == "resources") {
                  this.resources.push(res);
                  this.downloaded3 = true;
                  this.breadcrumRs = dataKey;
                  this.editions = rs;
                }
              });
          });
        });
      } else {
        var subCols = ARCHErdfQuery(
          {
            expiry: 14,
            subject: null,
            predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
            object: dataKey,
            paginate: [this.paginationStart, this.paginationEnd],
          },
          this.editions
        );
        subCols.value.forEach((el) => {
          var res = {};
          ARCHEdownloadResourceIdM2({
            host: this.host,
            format: "application/n-triples",
            resourceId: el.isPartOf.subject.replace(this.host + "/", ""),
            readMode: "resource",
          })
            .then((data) => {
              var rss = ARCHErdfQuery(
                {
                  expiry: 14,
                  subject: null,
                  predicate: null,
                  object: null,
                  paginate: false,
                },
                data
              );
              rss.value.forEach((el) => {
                if (el.hasTitle) {
                  res["title"] = el.hasTitle.object;
                }
                if (el.hasDescription) {
                  res["description"] = el.hasDescription.object;
                }
                if (el.hasIdentifier) {
                  if (el.hasIdentifier.object.includes("api")) {
                    res["identifier"] = el.hasIdentifier.object;
                  }
                }
                if (el.isNewVersionOf) {
                  res["isNewVersionOf"] = el.isNewVersionOf.object;
                }
                if (el.isPartOf) {
                  res["isPartOf"] = el.isPartOf.object;
                }
              });
            })
            .then(() => {
              if (type == "childCols") {
                this.childCollection.push(res);
                this.downloaded = true;
                this.breadcrum = dataKey;
              }
              if (type == "cols") {
                this.collections.push(res);
                this.downloaded2 = true;
                this.breadcrumCol = dataKey;
              }
              if (type == "resources") {
                this.resources.push(res);
                this.downloaded3 = true;
                this.breadcrumRs = dataKey;
              }
            });
        });
      }
    },
    getDataFiles(event) {
      this.html = "";
      this.htmlObject = "";
      var element = event.currentTarget;
      var dataKey = element.getAttribute("data-key");
      getFile(
        "https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json"
      ).then((data) => {
        // console.log(data);
        this.json = data;
      });
      getFile(dataKey)
        .then((data) => {
          console.log(data);
          this.xml = data;
        })
        .then(() => {
          setTimeout(() => {
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
              // console.log(this.htmlObject);
              this.downloaded3 = true;
            });
          }, 100);
        });
    },
  },
  // computed() {
  //   if (this.projectSize > 20) {
  //     for (let i = 0; i > this.projectSize; i++) {

  //     }
  //   }
  // },
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
.card-footer span a {
  cursor: pointer;
  color: #42b983;
}
</style>
