
//declraing an array of images
ImageBox[] boxImages;
int maxImages = 400; //total images
int imageIndex = 0; //initial image to be displayed is the first
float imgSize = 40;
float varX, pressX, varY, pressY = 0;

int loop;

import gifAnimation.*;
GifMaker gifExport;

void setup() {
  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(2);

  size(600, 600, P3D);

  pixelDensity(2);

  boxImages = new ImageBox[maxImages];

  float imgSize = 30;
  for (int i = 0; i < maxImages; i++) {
    boxImages[i] = new ImageBox(((i*imgSize)%width)+imgSize, (int((i*imgSize)/width)+1) * imgSize, imgSize/2, "img" + i + ".jpg");
  }

  frameRate(30);
}

void draw() {

  background(0);


  pushMatrix();
  rotateX(varX/100.0);
  rotateY(varY/100.0);
  // rotateY(PI/6.0);
  for (int i = 0; i < maxImages; i++) {
    boxImages[i].update();
    float rhytm = map(pow(abs(exp(sin(mouseX/6. * 0.03 - i * 0.01))), 50), 0, 1, -500, 500);
    // boxImages[i].setPos(boxImages[i].pos.x, boxImages[i].pos.y, rhytm );
  }
  popMatrix();

  if (loop%10 == 0) {
    if (loop < 400) {
      for (int i = 0; i < boxImages.length; i++) {
        // image swap
        int swap1 = i;
        int swap2 = loop;

        if (boxImages[swap1].avgColor.x < boxImages[swap2].avgColor.x ) {
          PImage imgTemp = boxImages[swap1].img;
          boxImages[swap1].imgSwap(boxImages[swap2].img);
          boxImages[swap2].img = imgTemp;
        }
      }
    }
  }

  // // image swap
  // int swap1 = int(random(0, boxImages.length));
  // int swap2 = int(random(0, boxImages.length));
  //
  // if (boxImages[swap1].avgColor.x < boxImages[swap2].avgColor.x ) {
  //   PImage imgTemp = boxImages[swap1].img;
  //   boxImages[swap1].imgSwap(boxImages[swap2].img);
  //   boxImages[swap2].img = imgTemp;
  // }

  if (mousePressed) {
    varX = pressX-mouseX;
    varY = pressY-mouseY;
  }

  // println(mouseX);

  // int frames = 60; // total output frames
  // int skips = 2; // skip frames
  // int startLoop = 0; // set to 0 to start from beginning
  // if (loop == startLoop + frames * skips) {
  //   gifExport.finish();
  //   println("GIF saved");
  // } else if (loop < frames * skips + startLoop && loop%skips == 0 && loop > startLoop) {
  //   println("frame: " + loop/skips + ", loop:" + loop);
  //   gifExport.setDelay(1);
  //   gifExport.addFrame();
  // }

  loop++;
}

void mousePressed()
{
  pressX = mouseX;
  pressY = mouseY;
}
