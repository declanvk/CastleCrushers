//Oscar Jones //<>//
//Justis Mackaou
//Zachary Richardson
//Declan Kelly

Animation anim;
Level lev;
PVector start;
Key k;
void setup() {
  size(1210, 610);
  start = new PVector(0, (int) random(0, 10));
  lev = new Level(start, width, height);
  anim = new Animation();
  k = new Key(200, 500, 0.25);
  frameRate(60);
}

void draw() {
  //685
  if (frameCount < .685) {
    anim.draw();
  } else if (!lev.isGameOver()) {
    background(lev.getBackground());
    k.draw();
    //lev.update();
    lev.handleCollisions();
    lev.draw();
  } else {
    background(255, 0, 0);
  }
}


void keyPressed() {
  switch(keyCode) {
  case 37:
    lev.character.movingLeft = true;
    break;
  case 38:
    lev.character.movingUp = true;
    break;
  case 39:
    lev.character.movingRight = true;
    break;
  case 40:
    lev.character.movingDown=true;
    break;
  case 87:
    lev.character.MOVESPEED++;
    println(lev.character.MOVESPEED);
    break;
  case 83:
    lev.character.MOVESPEED--;
    println(lev.character.MOVESPEED);
    break;
  case 65:
    println(frameRate);
    break;
  default:
    println(keyCode, key);
  }
}

void keyReleased() {
  switch(keyCode) {
  case 37:
    lev.character.movingLeft=false;
    break;
  case 38:
    lev.character.movingUp=false;
    break;
  case 39:
    lev.character.movingRight=false;
    break;
  case 40:
    lev.character.movingDown=false;
    break;
  case 81: //q
    lev.addProjectile();
    break;
  }
}

int doorY = 0;
void spawnDoor() {
  doorY = ((int)random(0, 10)) * (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) + Map.WALL_WIDTH_PX;
}

void drawDoor() {
  if (doorY == 0) return;

  pushStyle();
  pushMatrix();
  translate(width - Map.WALL_WIDTH_PX, doorY);
  fill(124, 50, 0);
  rect(0, 0, Map.WALL_WIDTH_PX, Map.CELL_HEIGHT_PX);
  popMatrix();
  popStyle();
}