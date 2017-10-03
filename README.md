# Mosaic-by-image-gathering
This Processing sketch searches on an image API and creates a mosaic art using the search results.

## Guides
- This branch is created for MOT festival.
- This code works offline.
- The sketch will automatically slide between photos infinitely.
- In order to change photos
    1. `cd` into `jsScrape/`
    2. `npm install` to install nodeJS packages.
    3. `npm run rm` to clear out the old pictures in processing sketch folder. <br>(WARNING: relocation of path to processing folder will cause error here.)
    4.  Overwrite the `q` param of config.json file to chagne search keyword.
    5. `npm start` will fetch images. 