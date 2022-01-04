<template>
  <div class="content">
    <h2>{{ title }}</h2>
    <h4>Number of resources found: {{ numberOfItems }}</h4>
    <div class="row">
      <div v-for="value in childCollection" :key="value.title">
        <table>
          <tbody>
            <tr>
              <td>Title</td>
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
          </tbody>
        </table>
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

export default {
  name: "GotStarted",
  data() {
    return {
      title: "",
      numberOfItems: 0,
      childCollection: [],
    };
  },
  mounted() {
    var options = {
      host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
      format: "application/n-triples",
      resourceId: "146747",
      readMode: "resource",
    };
    ARCHEdownloadResourceIdM2(options).then((data) => {
      const options = {
        expiry: 14,
        subject: null,
        predicate: null,
        object: null,
        paginate: false,
      };
      var topCol = ARCHErdfQuery(options, data);
      // console.log(topCol);
      topCol.value.forEach((el) => {
        if (el.hasTitle) {
          var hasTitle = el.hasTitle;
          this.title = hasTitle.object;
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
    });
    var options2 = {
      host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
      format: "application/n-triples",
      resourceId: "146747",
      readMode: "neighbors",
    };
    ARCHEdownloadResourceIdM2(options2).then((data) => {
      const options = {
        expiry: 14,
        subject: null,
        predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
        object: "https://arche-curation.acdh-dev.oeaw.ac.at/api/146747",
        paginate: false,
      };
      var childCol = ARCHErdfQuery(options, data);
      // console.log(childCol);
      childCol.value.forEach((el) => {
        // var rsID = `col_${Math.random().toString(16).slice(2)}`;
        var collections = {};
        // console.log(el);
        var id = el.isPartOf.subject.replace(
          "https://arche-curation.acdh-dev.oeaw.ac.at/api/",
          ""
        );
        const options = {
          host: "https://arche-curation.acdh-dev.oeaw.ac.at/api",
          format: "application/n-triples",
          resourceId: id,
          readMode: "resource",
        };
        ARCHEdownloadResourceIdM2(options).then((data) => {
          const options = {
            expiry: 14,
            subject: null,
            predicate: null,
            object: null,
            paginate: false,
          };
          var child_col = ARCHErdfQuery(options, data);
          // console.log(child_col);
          child_col.value.forEach((el) => {
            if (el.hasTitle) {
              collections["title"] = el.hasTitle.object;
            }
            if (el.hasDescription) {
              collections["description"] = el.hasDescription.object;
            }
            if (el.hasVersion) {
              collections["version"] = el.hasVersion.object;
            }
            // console.log(collections);
          });
        });
        this.childCollection.push(collections);
      });
      console.log(this.childCollection);
    });
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
