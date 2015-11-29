Human character;
Map map;
int x = 0;
void setup() {
  size(610, 610);
  map = new Map(width, height);
  character = new Human(100, 100, 2);
  frameRate(60);
}

void draw() {
  background(map.getBackground());
  character.update();
  character.draw();
  //drawBat();
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