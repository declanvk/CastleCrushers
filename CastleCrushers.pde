//Oscar Jones //<>// //<>//
//Justis Mackaou
//Zachary Richardson
//Declan Kelly
Animation anim;
Level lev;
DeathAnim DA;
Projectile p;
void setup() {
  size(1210, 610);
  lev = new Level(new PVector(0, (int) random(0, 10)), 5);
  anim = new Animation();
  DA = new DeathAnim();
  p = new Projectile(lev.character);
  frameRate(60);
}

void draw() {
  if (frameCount < .685) { //685
    anim.draw();
  } else if (!lev.isGameOver() && !lev.isLevelOver()) {
    background(lev.getBackground());
    lev.update();
    lev.handleCollisions();
    lev.checkWinState();
    lev.draw();
  } else if (lev.isGameOver()) {
    DA.draw();
  } else if (lev.isLevelOver()) {
    lev = new Level(new PVector(0, lev.getEndPos().y), lev.getNumLives());
    System.gc();
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
    lev.character.movingDown = true;
    break;
  case 87:
    lev.character.MOVESPEED += 0.5;
    println(lev.character.MOVESPEED);
    break;
  case 83:
    lev.character.MOVESPEED -= 0.5;
    println(lev.character.MOVESPEED);
    break;
  case 65:
    println(frameRate);
    break;
  case 80:
    println(lev.projectiles.size());
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case 37:
    lev.character.movingLeft = false;
    break;
  case 38:
    lev.character.movingUp = false;
    break;
  case 39:
    lev.character.movingRight = false;
    break;
  case 40:
    lev.character.movingDown = false;
    break;
  case 81: //q
    lev.addProjectile();
    break;
  }
}