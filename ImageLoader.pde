class ImageLoader extends Thread {
  String imgURL;
  ImageLoader(String imgURL) {
    this.imgURL = imgURL;
  }
  public void run() {
    //println("loading");
    try {
      PImage img = loadImage(imgURL);
      ImageContainer imgContainer = new ImageContainer(img);
      imgContainer.calcColor();
      dipictor.addImage(imgContainer);
      //println("Done Loading", dipictor.images.size());
    }
    catch(NullPointerException e) {
    }
  }
}