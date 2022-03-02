// const { default: fetch } = require('node-fetch');

/*The MIT License (MIT)
Copyright (c) 2016 - 2020 Node Fetch Team
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
https://github.com/node-fetch/node-fetch*/

// module.exports.openFile = async(filepath, callback) => {
//     const options = {
//         method: 'GET'
//     };
//     try {
//         const response = await fetch(filepath, options);
//         const body = await response.text();
//         console.log("statusCode:", response.statusCode);
//         console.log("headers:", response.headers);
//         return callback(body);
//     } catch (error) {
//         console.log(error);
//     }
// }

const { ARCHErdfQuery, ARCHEdownloadResourceIdM2 } = require("arche-api/src");

module.exports.getFile = async (url) => {
  const resp = await fetch(url);
  const data = await resp.text();
  return data;
};

module.exports.ARCHEsearchText = async (id) => {
  var url =
    "https://arche-curation.acdh-dev.oeaw.ac.at/api/search?" +
    new URLSearchParams({
      "property[0]": "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
      "value[0]": id,
      "operator[0]": "=",
    });
  console.log(url);
  try {
    var response = await fetch(url, {
      method: "GET",
      headers: {
        Accept: "application/n-triples",
      },
    });
    var text = await response.text();
    return text;
  } catch (error) {
    console.log(error);
  }
};

module.exports.getARCHEdata = async (options) => {
  ARCHEdownloadResourceIdM2({
    host: options.host,
    format: "application/n-triples",
    resourceId: options.key.replace(options.host + "/", ""),
    readMode: "neighbors",
  }).then((rs) => {
    return rs;
  });
};

module.exports.parseARCHEdata = (options, data) => {
  console.log(data);
  var subCols = ARCHErdfQuery(
    {
      expiry: 14,
      subject: null,
      predicate: "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf",
      object: options.key,
      paginate: [options.paginationStart, options.paginationEnd],
    },
    data
  );
  subCols.value.forEach((el) => {
    var res = {};
    ARCHEdownloadResourceIdM2({
      host: options.host,
      format: "application/n-triples",
      resourceId: el.isPartOf.subject.replace(options.host + "/", ""),
      readMode: "resource",
    })
      .then((rs) => {
        var rss = ARCHErdfQuery(
          {
            expiry: 14,
            subject: null,
            predicate: null,
            object: null,
            paginate: false,
          },
          rs
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
        console.log(res);
        return res;
      });
  });
};
