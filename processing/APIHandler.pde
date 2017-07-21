class APIHandler {
  final String imgServer = "http://pixabay.com/api/";
  String baseURL;
  APIHandler(String APIKey){
    
    this.baseURL = imgServer + "/?key=" + APIKey;
  }
  void load(String imgURL, boolean isTarget) {
    ImageLoader imgLoader = new ImageLoader(imgURL);
    imgLoader.start();
    if (isTarget) {
      PImage target = loadImage(imgURL);
      dipictor.setTarget(target);
      dipictor.createPartials();
    }
  }
  ArrayList search(String searchParam) {
    ArrayList<String> searchResult = new ArrayList<String>();
    println("searching");
    for (int i = 1; i < PAGES + 1; i++) {
      String page = str(i);
      String url = searchParam+"&page="+page;
      String res = this.sendRequest(url);
      JSONArray hits = this.extractHits(res);
      for (int j = 0; j < hits.size(); j++) {
        JSONObject imgInstance = hits.getJSONObject(j);
        String imgURL = HttpsToHttp(imgInstance.getString("webformatURL"));
        searchResult.add(imgURL);
      }
    }
    println("Done Searching");
    return searchResult;
  }
  String sendRequest(String searchParam) {
    String url = baseURL + searchParam;
    GetRequest req = new GetRequest(url);
    req.send();
    String res = req.getContent();
    return res;
  }
  JSONArray extractHits(String res) {
    JSONObject json =  parseJSONObject(res);
    int totalHits = json.getInt("totalHits");
    //println("total hit: ", totalHits);
    JSONArray hits = json.getJSONArray("hits");
    return hits;
  }
}