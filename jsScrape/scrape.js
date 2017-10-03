const fs = require('fs');
const axios = require('axios');

axios.get('https://pixabay.com/api/?key=5940765-473ab300ba0823791f930fc29')
     .then((res) => {
         const hits = res.data.hits;
         hits.forEach( (hit, i) =>{
             const url = hit.userImageURL;
             console.log('fetching: ', url);

             axios.get(url, {responseType: 'arraybuffer'}).then(
                 (res) => {
                    const data = res.data;
                    const buf = new Buffer(data, 'base64');
                    const imageName = url.replace('https://cdn.pixabay.com/user/', '');
                    const stream = fs.createWriteStream('../processing/data/' + i + '.jpg');
                    stream.write(buf);
                    stream.end();
                 }
             );

             if(i > 20){
                 return;
             }
         });
     });