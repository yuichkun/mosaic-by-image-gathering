const fs = require('fs');
const axios = require('axios');
const queryString = require('query-string');
const config = require('./config.json');
const query = queryString.stringify(config);

axios.get('https://pixabay.com/api/?' + query)
     .then((res) => {
         const hits = res.data.hits;
        //  console.log(res.data);
         hits.forEach( (hit, i) =>{
             const url = hit.webformatURL;
             console.log(`fetching ${i} th image from ${url}`);
             if(url !==""){
                 axios.get(url, { responseType: 'arraybuffer' }).then(
                     (res) => {
                         const data = res.data;
                         const buf = new Buffer(data, 'base64');
                         const imageName = extractFileName(url);
                         const stream = fs.createWriteStream('../processing/data/' + i + imageName);
                         stream.write(buf);
                         stream.end();
                     }
                 );
             }
         });
     });

function extractFileName(url){
    const imageName = url.replace('https://cdn.pixabay.com/user/', '');
    const arr = imageName.split('/');
    return arr[arr.length-1];
}