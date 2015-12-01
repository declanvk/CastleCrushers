Human character; //<>//
Animation anim;
Map map;
int x = 0;
void setup() {
  size(1210, 610);
  map = new Map(width, height);
  character = new Human(100, 100, 1);
  anim = new Animation();
  frameRate(60);
}

void draw() {
  //if (frameCount < 672) {
  // anim.draw();
  // } else {
  println(frameRate);
  background(map.getBackground());
  character.update();
  BoundingBox chrBox = new BoundingBox(new Point(character.pointX, character.pointY), (int)character.wd, (int)character.ht);
  println(map.query(chrBox).size());
  character.draw();
  //drawBat();
  //}
}

void keyPressed() {
  switch(keyCode) {
  case 37:
    character.movingLeft=true;
    break;
  case 38:
    character.movingUp=true;
    break;
  case 39:
    character.movingRight=true;
    break;
  case 40:
    character.movingDown=true;
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case 37:
    character.movingLeft=false;
    break;
  case 38:
    character.movingUp=false;
    break;
  case 39:
    character.movingRight=false;
    break;
  case 40:
    character.movingDown=false;
    break;
  }
}