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
  k = new Key(200, 200);
  frameRate(60);
  println(lev.map.astar(start, new PVector(start.x + 1, start.y), lev.map.adjacency));
}

void draw() {
  //685
  if (frameCount < .685) {
    anim.draw();
  } else if (!lev.isGameOver()) {
    background(lev.getBackground());
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