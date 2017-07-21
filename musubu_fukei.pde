import http.requests.*;

Dipictor dipictor;
APIHandler apiHandler;

final int IMG_PER_PAGE = 200;
final int PAGES = 1;
final String keyword = "temple";

int targetID = 1;
int GRID = 10;

void setup() {
  fullScreen();
  //size(1280, 720, P2D);
  frameRate(20);
  dipictor = new Dipictor();
  apiHandler = new APIHandler();
  ArrayList<String> imgURLs = apiHandler.search("&orientation=horizontal&image_type=photo" + "&q=" + keyword + "&per_page=" + str(IMG_PER_PAGE));
  for (int i = 0; i < imgURLs.size(); i++) {
    String imgURL = imgURLs.get(i);
    boolean isTarget = i == targetID;
    apiHandler.load(imgURL, isTarget);
  }
}


boolean flag = false;
void draw() {
  background(0);

  dipictor.updatePartials();

  if (flag) {
    dipictor.showTarget();
  } else {
    dipictor.showPartials();
  }
  ////dipictor.showGallery();
}

void mousePressed() {
  flag = !flag;
}

void keyPressed() {
  try {
    if (keyCode == RIGHT) {

      targetID++;
      ImageContainer target = dipictor.images.get(targetID);
      dipictor.changeTarget(target);
    }
    if (keyCode == LEFT) {
      if (targetID > 0) {
        targetID--;
        ImageContainer target = dipictor.images.get(targetID);
        dipictor.changeTarget(target);
      }
    }
  } 
  catch(IndexOutOfBoundsException e) {
  }
  if (keyCode == UP) {
    GRID = floor(GRID * 1.5);
    dipictor.updateGRID();
  }
  if (keyCode == DOWN) {
    if (GRID > 5) {
      GRID = floor(GRID / 1.5);
      dipictor.updateGRID();
    }
  }
}