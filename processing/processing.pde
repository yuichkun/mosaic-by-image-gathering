Dipictor dipictor;

int targetID = 1;
int GRID = 10;
String path = sketchPath();
int GALLERY_SIZE;

void setup() {
  //fullScreen();
  size(1280, 720, P2D);
  frameRate(5);
  dipictor = new Dipictor();
  ;  
  File dir= new File(dataPath(""));
  File [] files= dir.listFiles();
  GALLERY_SIZE = files.length;
  for (int i = 0; i < files.length; i++) {
    String imgURL = files[i].getName();
    if (i == 0) {
      PImage target = loadImage("data/" + imgURL);
      dipictor.setTarget(target);
      dipictor.createPartials();
    } else {
      PImage img = loadImage(imgURL);
      ImageContainer imgContainer = new ImageContainer(img);
      imgContainer.calcColor();
      dipictor.addImage(imgContainer);
    }
  }
}


boolean shouldShowTarget = false;
void draw() {
  background(0);

  dipictor.updatePartials();

  if (shouldShowTarget) {
    dipictor.showTarget();
  } else {
    dipictor.showPartials();
  }
  if (frameCount % 5 == 0) {
    updateGallery();
  }
  //dipictor.showGallery();
}

void mousePressed() {
  shouldShowTarget = !shouldShowTarget;
}

void updateGallery() {
  if (GRID > 150) {
    GRID = 10;
    dipictor.updateGRID();
    switchPhoto();
  } else {
    GRID = floor(GRID * 1.5);
    dipictor.updateGRID();
  }
}

void switchPhoto() {
  if (targetID < GALLERY_SIZE-2) {
    targetID++;
  } else {
    targetID = 0;
  }
  ImageContainer target = dipictor.images.get(targetID);
  dipictor.changeTarget(target);
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
    if (GRID < 150) {
      GRID = floor(GRID * 1.5);
      dipictor.updateGRID();
    }
  }
  if (keyCode == DOWN) {
    if (GRID > 5) {
      GRID = floor(GRID / 1.5);
      dipictor.updateGRID();
    }
  }
}