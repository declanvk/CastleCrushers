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










void batUp()
{
  //feet
  fill(70, 70, 68); //bat grey
  strokeWeight(2);
  //L
  pushMatrix();
  translate(0, 0);
  scale(-1.0, 1.0);
  rotate(-radians(20));
  beginShape();
  vertex(-3, 49);
  vertex(-1, 55);
  vertex(2, 53);
  vertex(4, 56);
  vertex(7, 53);
  vertex(11, 54);
  vertex(13, 49);
  endShape();
  popMatrix();
  //R
  pushMatrix();
  translate(0, 0);
  scale(1.0, 1.0);
  rotate(-radians(20));
  beginShape();
  vertex(-3, 49);
  vertex(-1, 55);
  vertex(2, 53);
  vertex(4, 56);
  vertex(7, 53);
  vertex(11, 54);
  vertex(13, 49);
  endShape();
  popMatrix();

  strokeWeight(3);

  ellipse(0, 0, 100, 100); //body

  //ears
  //L
  pushMatrix();
  scale(-1.0, 1.0);
  translate(38, -48);
  rotate(radians(10));
  fill(70, 70, 68); //bat grey
  arc(0, 0, 40, 65, 5*PI/3, 7.17);
  noFill();
  beginShape();
  vertex(10, -28);
  vertex(-1, -5);
  vertex(-12, 0);
  vertex(-13, 4);
  endShape();

  stroke(70, 70, 68);
  strokeWeight(4);
  noFill();
  beginShape();
  curveVertex(25, 55);
  curveVertex(11, 21);
  curveVertex(-11, 4);
  curveVertex(-54, -8);
  endShape();

  noStroke();
  fill(70, 70, 68); //bat grey
  quad(8, 15, -11, 3, -11, 1, -2, -4);
  triangle(13, 24, 7, -18, -3, -2);
  rotate(-radians(10));
  quad(-5, 17, -16, 7, -9, -2, 5, 5);
  stroke(0);
  strokeWeight(3);     
  popMatrix();   

  //R
  pushMatrix();
  translate(38, -48);
  rotate(radians(10));
  fill(70, 70, 68); //bat grey
  arc(0, 0, 40, 65, 5*PI/3, 7.17);
  noFill();
  beginShape();
  vertex(10, -28);
  vertex(-1, -5);
  vertex(-12, 0);
  vertex(-13, 4);
  endShape();

  stroke(70, 70, 68);
  strokeWeight(4);
  noFill();
  beginShape();
  curveVertex(25, 55);
  curveVertex(11, 21);
  curveVertex(-11, 4);
  curveVertex(-54, -8);
  endShape();

  noStroke();
  fill(70, 70, 68); //bat grey
  quad(8, 15, -11, 3, -11, 1, -2, -4);
  triangle(13, 24, 7, -18, -3, -2);
  rotate(-radians(10));
  quad(-5, 17, -16, 7, -9, -2, 5, 5);
  stroke(0);
  strokeWeight(3);     
  popMatrix();   
  strokeWeight(3);

  noStroke();
  fill(70, 70, 68); //bat grey
  //quad(-51,-54, -43,-53, -28,-36, -42,-24);
  stroke(0);
  strokeWeight(3);

  //hair
  pushMatrix();
  rotate(radians(7));
  translate(-24, -44);
  beginShape();
  vertex(0, 0); //first
  vertex(-1, -5);
  vertex(4, -4);
  vertex(6, -8);
  vertex(12, -4);
  vertex(14, -11);
  vertex(20, -7);
  vertex(24, -11);
  vertex(28, -6);
  vertex(30, -12);
  vertex(34, -6);
  vertex(37, -9);
  vertex(40, -3);
  vertex(42, -1); //last
  endShape();
  popMatrix();
  stroke(0);
  //wings
  fill(70, 70, 68); //bat grey
  //L
  pushMatrix();
  translate(0, 0);
  rotate(radians(5));
  scale(1.0, 1.0);
  beginShape();
  vertex(-48, 10);
  vertex(-55, 34);
  vertex(-46, 48);
  vertex(-46, 37);
  vertex(-40, 37);
  vertex(-40, 31);
  vertex(-33, 29);
  endShape();
  popMatrix();
  pushMatrix();
  translate(1, 0);
  scale(-1.0, 1.0);
  rotate(radians(5));
  beginShape();
  vertex(-48, 10);
  vertex(-55, 34);
  vertex(-46, 48);
  vertex(-46, 37);
  vertex(-40, 37);
  vertex(-40, 31);
  vertex(-33, 29);
  endShape();
  popMatrix();
}