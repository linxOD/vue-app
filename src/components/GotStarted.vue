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
            type="Collection"
            data-type="Collection"
            @click="getDataRs"
          >
            load collections
          </button>
        </div>
        <div class="card-footer" v-if="breadcrumCol.length != 0">
          <!-- <span v-if="breadcrum.length != 0">
            <a :data-key="breadcrum" @click="getDataRs" type="childCols">
              ChildCols
            </a>
          </span> -->
          <span v-if="breadcrumCol.length != 0">
            <a
              :data-key="topColIdentifier"
              @click="getDataRs"
              type="Collection"
              data-type="Collection"
            >
              Collection
            </a>
          </span>
          <span v-if="breadcrumRs.length != 0">
            |
            <a
              :data-key="breadcrumRs"
              @click="getDataRs"
              type="Resource"
              data-type="Resource"
            >
              Item
            </a>
          </span>
          <span v-if="breadcrumRs.length != 0">
            |
            <a
              :data-key="breadcrumRs"
              @click="getDataRs"
              type="Resource"
              data-type="load more"
            >
              load more items
            </a>
          </span>
        </div>
      </div>
    </div>
    <div class="row">
      <div v-for="value in childCollection" :key="value.identifier">
        <div class="card">
          <div class="card-body">
            <h3>{{ value.title }}</h3>
            <p>{{ value.description }}</p>
            <button
              class="btn btn-round btn-dark text-light"
              :data-key="value.identifier"
              :type="value.type"
              :data-type="value.type"
              @click="getDataRs"
            >
              load_{{ value.identifier }}
            </button>
          </div>
        </div>
      </div>
      <div>
        <h4>
          Items loaded: from {{ paginationStart + 1 }} to {{ paginationEnd }} of
          {{ projectSize }}
        </h4>
      </div>
      <div v-for="value in resources" :key="value.identifier">
        <div class="card">
          <div class="card-body">
            <h3>{{ value.title }}</h3>
            <button
              class="btn btn-round btn-dark text-light"
              :data-key="value.identifier"
              type="binary"
              data-type="binary"
              @click="loadxml"
            >
              show_{{ value.identifier }}
            </button>
          </div>
        </div>
      </div>
      <div v-if="downloaded4">
        <div class="card">
          <div class="card-body">
            <div v-html="html" />
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
import * as SaxonJS from "../vendor/saxon-js/SaxonJS2.rt";

export default {
  name: "got-started",
  data() {
    return {
      title: "",
      numberOfItems: 0,
      topColIdentifier: "",
      childCollection: [],
      resources: [],
      downloaded: false,
      downloaded2: false,
      downloaded3: false,
      downloaded1: false,
      downloaded4: false,
      breadcrum: "",
      breadcrumCol: "",
      breadcrumRs: "",
      host: "https://arche.acdh.oeaw.ac.at/api",
      archeID: "140074",
      projectSize: 0,
      paginationStart: 0,
      paginationEnd: 20,
      collections: "",
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
      this.html = "";
      this.downloaded4 = false;
      this.downloaded = false;
      this.downloaded2 = false;
      // this.downloaded3 = false;
      this.childCollection = [];
      // this.collections = [];
      this.resources = [];
      var element = event.currentTarget;
      var dataKey = element.getAttribute("data-key");
      var type = element.getAttribute("type");
      var dataType = element.getAttribute("data-type");
      console.log(type);
      // console.log(type);
      if (dataType == "load more" && this.projectSize > this.paginationEnd) {
        this.paginationStart += 20;
        this.paginationEnd += 20;
        // console.log(this.paginationStart);
        // console.log(this.paginationEnd);
        // console.log(this.projectSize);
      } else {
        this.paginationStart = 0;
        this.paginationEnd = 20;
      }
      if (this.editions.length == 0) {
        ARCHEdownloadResourceIdM2({
          host: this.host,
          format: "application/n-triples",
          resourceId: dataKey.replace(this.host + "/", ""),
          readMode: "neighbors",
        }).then((rs) => {
          if (type == "Resource") {
            this.editions = rs;
          } else if (type == "Collection") {
            this.collections = rs;
          }
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
          var items = subCols.fullLength;
          this.projectSize = items;
          subCols.value.forEach((el) => {
            var res = {};
            var cols = {};
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
                  if (el.type) {
                    type = el.type.object.replace(
                      "https://vocabs.acdh.oeaw.ac.at/schema#",
                      ""
                    );
                  }
                });
                if (type == "Resource") {
                  rss.value.forEach((el) => {
                    console.log(type);
                    if (el.type) {
                      res["type"] = el.type.object.replace(
                        "https://vocabs.acdh.oeaw.ac.at/schema#",
                        ""
                      );
                    }
                    if (el.hasTitle) {
                      res["title"] = el.hasTitle.object;
                    }
                    if (el.hasDescription) {
                      res["description"] = el.hasDescription.object;
                    }
                    if (el.hasIdentifier) {
                      if (el.hasIdentifier.object.includes("api")) {
                        res["identifier"] = el.hasIdentifier.object;
                        console.log(el.hasIdentifier.object);
                      }
                    }
                    if (el.isNewVersionOf) {
                      res["isNewVersionOf"] = el.isNewVersionOf.object;
                    }
                    if (el.isPartOf) {
                      res["isPartOf"] = el.isPartOf.object;
                    }
                    console.log(res);
                  });
                } else if (type == "Collection") {
                  rss.value.forEach((el) => {
                    console.log(type);
                    if (el.type) {
                      cols["type"] = el.type.object.replace(
                        "https://vocabs.acdh.oeaw.ac.at/schema#",
                        ""
                      );
                    } else if (el.hasTitle) {
                      cols["title"] = el.hasTitle.object;
                    } else if (el.hasDescription) {
                      cols["description"] = el.hasDescription.object;
                    } else if (el.hasIdentifier) {
                      if (el.hasIdentifier.object.includes("api")) {
                        cols["identifier"] = el.hasIdentifier.object;
                        console.log(el.hasIdentifier.object);
                      }
                    } else if (el.isNewVersionOf) {
                      cols["isNewVersionOf"] = el.isNewVersionOf.object;
                    } else if (el.isPartOf) {
                      cols["isPartOf"] = el.isPartOf.object;
                    }
                    console.log(cols);
                  });
                }
              })
              .then(() => {
                this.childCollection.push(cols);
                this.resources.push(res);
                if (dataType == "Collection") {
                  this.downloaded = true;
                  this.breadcrumCol = dataKey;
                  this.collections = rs;
                  console.log(this.childCollectionpe);
                }
                if (dataType == "Resource") {
                  this.downloaded2 = true;
                  this.breadcrumRs = dataKey;
                  this.editions = rs;
                  console.log(this.resources);
                }
                // this.editions = rs;
                // if (type == "childCols") {
                //   this.childCollection.push(res);
                //   this.downloaded = true;
                //   this.breadcrumCol = dataKey;
                //   this.collections = rs;
                //   this.editions = "";
                // }
                // if (type == "Collection") {
                //   this.childCollection.push(res);
                //   this.downloaded = true;
                //   this.breadcrumCol = dataKey;
                //   this.collections = rs;
                //   this.editions = "";
                // }
                // if (type == "Resource") {
                //   this.resources.push(res);
                //   this.downloaded2 = true;
                //   this.breadcrumRs = dataKey;
                //   this.editions = rs;
                // }
              });
          });
        });
      } else {
        if (type == "Resource" || dataType == "load more") {
          var data = this.editions;
        } else if (type == "Collection") {
          data = this.collections;
        }
        var subCols = ARCHErdfQuery(
          {
            expiry: 14,
            subject: null,
            predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
            object: dataKey,
            paginate: [this.paginationStart, this.paginationEnd],
          },
          data
        );
        subCols.value.forEach((el) => {
          var res = {};
          var cols = {};
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
                if (el.type) {
                  type = el.type.object.replace(
                    "https://vocabs.acdh.oeaw.ac.at/schema#",
                    ""
                  );
                }
              });
              if (type == "Resource") {
                rss.value.forEach((el) => {
                  console.log(type);
                  if (el.type) {
                    res["type"] = el.type.object.replace(
                      "https://vocabs.acdh.oeaw.ac.at/schema#",
                      ""
                    );
                  }
                  if (el.hasTitle) {
                    res["title"] = el.hasTitle.object;
                  }
                  if (el.hasDescription) {
                    res["description"] = el.hasDescription.object;
                  }
                  if (el.hasIdentifier) {
                    if (el.hasIdentifier.object.includes("api")) {
                      res["identifier"] = el.hasIdentifier.object;
                      console.log(el.hasIdentifier.object);
                    }
                  }
                  if (el.isNewVersionOf) {
                    res["isNewVersionOf"] = el.isNewVersionOf.object;
                  }
                  if (el.isPartOf) {
                    res["isPartOf"] = el.isPartOf.object;
                  }
                  console.log(res);
                });
              } else if (type == "Collection") {
                rss.value.forEach((el) => {
                  console.log(type);
                  if (el.type) {
                    cols["type"] = el.type.object.replace(
                      "https://vocabs.acdh.oeaw.ac.at/schema#",
                      ""
                    );
                  } else if (el.hasTitle) {
                    cols["title"] = el.hasTitle.object;
                  } else if (el.hasDescription) {
                    cols["description"] = el.hasDescription.object;
                  } else if (el.hasIdentifier) {
                    if (el.hasIdentifier.object.includes("api")) {
                      cols["identifier"] = el.hasIdentifier.object;
                      console.log(el.hasIdentifier.object);
                    }
                  } else if (el.isNewVersionOf) {
                    cols["isNewVersionOf"] = el.isNewVersionOf.object;
                  } else if (el.isPartOf) {
                    cols["isPartOf"] = el.isPartOf.object;
                  }
                  console.log(cols);
                });
              }
            })
            .then(() => {
              this.resources.push(res);
              this.childCollection.push(cols);
              if (dataType == "Collection") {
                this.downloaded = true;
                this.breadcrumCol = dataKey;
                this.collections = data;
              }
              if (dataType == "Resource") {
                this.downloaded2 = true;
                this.breadcrumRs = dataKey;
                this.editions = data;
              }
              if (dataType == "load more") {
                this.downloaded2 = true;
              }
              console.log(this.childCollection);
              console.log(this.resources);
              // if (type == "childCols") {
              //   this.childCollection.push(res);
              //   this.downloaded = true;
              //   this.breadcrumCol = dataKey;
              //   this.collections = data;
              //   this.editions = "";
              // }
              // if (type == "Collection") {
              //   this.childCollection.push(res);
              //   this.downloaded = true;
              //   this.breadcrumCol = dataKey;
              //   this.collections = data;
              //   this.editions = "";
              // }
              // if (type == "Resource") {
              //   this.resources.push(res);
              //   this.downloaded2 = true;
              //   this.breadcrumRs = dataKey;
              //   this.editions = data;
              // }
              // if (type == "load more") {
              //   this.resources.push(res);
              //   this.downloaded2 = true;
              // }
            });
        });
      }
    },
    loadxml(event) {
      this.html = "";
      this.htmlObject = "";
      this.downloaded = false;
      this.downloaded2 = false;
      this.downloaded3 = false;
      this.downloaded4 = false;
      this.resources = [];
      var element = event.currentTarget;
      var dataKey = element.getAttribute("data-key");
      // console.log(dataKey);
      getFile(
        "https://raw.githubusercontent.com/linxOD/vue-app/main/public/tmp/tei-editions.sef.json"
      ).then((data) => {
        // console.log(data);
        this.json = data;
      });
      getFile(dataKey).then((data) => {
        // console.log(data);
        this.xml = data;
      });
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
          this.downloaded4 = true;
        });
      }, 500);
    },
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
  padding: 0.5em;
}
.card-footer span a {
  cursor: pointer;
  color: #42b983;
}
th {
  width: 30%;
}
</style>
