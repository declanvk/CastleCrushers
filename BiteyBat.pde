public class Bat 
{
  private final float SCALE = 0.25;
  final float ENEMYSPEED;

  public PVector p = new PVector();
  public PVector dir=new PVector();

  public BoundingBox bound;

  Bat(Human ch) 
  {
    this.ENEMYSPEED = ch.MOVESPEED;
    this.bound = new BoundingBox(PVector.add(new PVector(10, 10), crToXY(new PVector((int) random(width / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX)), (int) random(height / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX))))), (int)(SCALE * 140), (int)(SCALE * 140));
  }

  public void draw() 
  {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(255);
    rect(bound.anchor.x, bound.anchor.y, bound.width, bound.height);
    popStyle();

    pushStyle();
    pushMatrix();
    translate(this.bound.anchor.x, this.bound.anchor.y);
    scale(SCALE);
    translate(70, 80);
    this.drawDirection(dir.copy().normalize());
    popMatrix();
    popStyle();
  }

  public void update(PVector target) 
  {
    this.dir = PVector.sub(target, this.bound.anchor);
    this.dir.normalize();
    this.dir.mult(ENEMYSPEED);
    this.bound.anchor.add(this.dir);
  }

  public void drawDirection(PVector direction) 
  {
    strokeWeight(3);
    if (direction.x > 0) {
      batRight();
    } else if (direction.x < 0) {
      batLeft();
    } else if (direction.y < 0) {
      batUp();
    } else {
      batDown();
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

  void batLeft()
  {

    //feet
    fill(70, 70, 68); //bat grey
    strokeWeight(2);
    //L
    beginShape();
    vertex(-33, 38);
    vertex(-34, 45);
    vertex(-32, 50);
    vertex(-29, 47);
    vertex(-29, 46);
    vertex(-25, 52);
    vertex(-24, 48);
    vertex(-21, 51);
    vertex(-18, 45);
    endShape();
    //R
    beginShape();
    vertex(-3, 49);
    vertex(-1, 55);
    vertex(2, 53);
    vertex(4, 56);
    vertex(7, 53);
    vertex(11, 54);
    vertex(13, 49);
    endShape();
    strokeWeight(3);

    ellipse(0, 0, 100, 100); //body

    //L ear overlap
    noStroke();
    quad(-48, -17, -48, -44, -46, -44, -40, -27); //ear filler
    noStroke();
    fill(70, 70, 68); //bat grey
    quad(-51, -54, -43, -53, -28, -36, -42, -24);
    stroke(0);
    strokeWeight(3);

    //mouth
    rectMode(CENTER);
    pushMatrix();
    translate(28, 14);
    rotate(radians(2));
    fill(255, 44, 115); //lighter mouth
    rect(-20, 2, 50, 34, 12); //mouth
    popMatrix();

    fill(180, 44, 100); //darker mouth
    noStroke();
    quad(-15, -1, 32, 0, 32, 15, -15, 13); //top of mouth
    stroke(0);

    //ears
    //L
    pushMatrix();
    scale(0.9);
    translate(-4, -3);
    pushMatrix();
    translate(-49, -55);
    rotate(-radians(16));
    fill(70, 70, 68); //bat grey
    arc(0, 0, 60, 85, 5*PI/8, 19*PI/16);
    popMatrix();
    beginShape();
    curveVertex(-156, -118);
    curveVertex(-79, -72);
    curveVertex(-59, -58);
    curveVertex(8, 11);
    endShape();
    line(-59, -60, -43, -57);
    line(-43, -57, -30, -42);
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

    noStroke();
    fill(70, 70, 68); //bat grey
    quad(-51, -54, -43, -53, -28, -36, -42, -24);
    stroke(0);
    strokeWeight(3);

    //hair
    pushMatrix();
    translate(-20, -44);
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

    //inner ear
    strokeWeight(2);
    line(-18, 24, -45, -2);
    fill(255, 44, 115); //lighter mouth
    beginShape();
    curveVertex(-36, -33);
    curveVertex(-27, 26);
    curveVertex(-45, -2);
    curveVertex(-21, 33);
    endShape();
    noStroke();
    fill(255, 44, 115); //lighter mouth
    triangle(-22, 21, -26, 27, -43, 1);
    stroke(0);
    strokeWeight(3);
    popMatrix();

    //teeth
    fill(230);
    strokeWeight(2);
    // T L
    beginShape();
    vertex(0, -3);
    vertex(-2, 8);
    vertex(-7, 15);
    vertex(-10, 9);
    vertex(-13, 7);
    vertex(-16, -3);
    endShape(CLOSE);
    //T R
    beginShape();
    vertex(19, -1);
    vertex(20, 5);
    vertex(19, 12);
    vertex(30, 8);
    vertex(32, 4);
    endShape();
    //B L
    beginShape();
    vertex(-14, 29);
    vertex(-12, 24);
    vertex(-8, 24);
    vertex(-5, 22);
    vertex(-4, 28);
    vertex(-5, 31);
    endShape(CLOSE);
    //B R
    beginShape();
    vertex(19, 32);
    vertex(21, 24);
    vertex(29, 25);
    vertex(28, 31);
    endShape(CLOSE);
    strokeWeight(3);

    //eyes
    fill(241, 28, 50); //red eyes
    ellipse(-15, -9, 25, 25); //L eye
    ellipse(36, -7, 25, 25); //R eye
    noStroke();
    fill(240);
    ellipse(-11, -11, 11, 11); //L eye shine
    ellipse(40, -9, 11, 11); //R eye shine
    stroke(0);

    //wings
    fill(70, 70, 68); //bat grey
    //L
    pushMatrix();
    //rotate(
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
    //R
    pushMatrix();
    //rotate();
    beginShape();
    vertex(49, 15);
    vertex(55, 34);
    vertex(48, 48);
    vertex(45, 35);
    vertex(40, 35);
    vertex(40, 31);
    vertex(43, 24);
    endShape(CLOSE);
    popMatrix();
  }

  void batRight()
  {

    //feet
    fill(70, 70, 68); //bat grey
    strokeWeight(2);
    //L
    beginShape();
    vertex(-33, 38);
    vertex(-34, 45);
    vertex(-32, 50);
    vertex(-29, 47);
    vertex(-29, 46);
    vertex(-25, 52);
    vertex(-24, 48);
    vertex(-21, 51);
    vertex(-18, 45);
    endShape();
    //R
    beginShape();
    vertex(-3, 49);
    vertex(-1, 55);
    vertex(2, 53);
    vertex(4, 56);
    vertex(7, 53);
    vertex(11, 54);
    vertex(13, 49);
    endShape();
    strokeWeight(3);

    ellipse(0, 0, 100, 100); //body

    //L ear overlap
    noStroke();
    quad(-48, -17, -48, -44, -46, -44, -40, -27); //ear filler
    noStroke();
    fill(70, 70, 68); //bat grey
    quad(-51, -54, -43, -53, -28, -36, -42, -24);
    stroke(0);
    strokeWeight(3);

    //mouth
    rectMode(CENTER);
    pushMatrix();
    translate(28, 14);
    rotate(radians(2));
    fill(255, 44, 115); //lighter mouth
    rect(-20, 2, 50, 34, 12); //mouth
    popMatrix();

    fill(180, 44, 100); //darker mouth
    noStroke();
    quad(-15, -1, 32, 0, 32, 15, -15, 13); //top of mouth
    stroke(0);

    //ears
    //L
    pushMatrix();
    scale(0.9);
    translate(-4, -3);
    pushMatrix();
    translate(-49, -55);
    rotate(-radians(16));
    fill(70, 70, 68); //bat grey
    arc(0, 0, 60, 85, 5*PI/8, 19*PI/16);
    popMatrix();
    beginShape();
    curveVertex(-156, -118);
    curveVertex(-79, -72);
    curveVertex(-59, -58);
    curveVertex(8, 11);
    endShape();
    line(-59, -60, -43, -57);
    line(-43, -57, -30, -42);
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

    noStroke();
    fill(70, 70, 68); //bat grey
    quad(-51, -54, -43, -53, -28, -36, -42, -24);
    stroke(0);
    strokeWeight(3);

    //hair
    pushMatrix();
    translate(-20, -44);
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

    //inner ear
    strokeWeight(2);
    line(-18, 24, -45, -2);
    fill(255, 44, 115); //lighter mouth
    beginShape();
    curveVertex(-36, -33);
    curveVertex(-27, 26);
    curveVertex(-45, -2);
    curveVertex(-21, 33);
    endShape();
    noStroke();
    fill(255, 44, 115); //lighter mouth
    triangle(-22, 21, -26, 27, -43, 1);
    stroke(0);
    strokeWeight(3);
    popMatrix();

    //teeth
    fill(230);
    strokeWeight(2);
    // T L
    beginShape();
    vertex(0, -3);
    vertex(-2, 8);
    vertex(-7, 15);
    vertex(-10, 9);
    vertex(-13, 7);
    vertex(-16, -3);
    endShape(CLOSE);
    //T R
    beginShape();
    vertex(19, -1);
    vertex(20, 5);
    vertex(19, 12);
    vertex(30, 8);
    vertex(32, 4);
    endShape();
    //B L
    beginShape();
    vertex(-14, 29);
    vertex(-12, 24);
    vertex(-8, 24);
    vertex(-5, 22);
    vertex(-4, 28);
    vertex(-5, 31);
    endShape(CLOSE);
    //B R
    beginShape();
    vertex(19, 32);
    vertex(21, 24);
    vertex(29, 25);
    vertex(28, 31);
    endShape(CLOSE);
    strokeWeight(3);

    //eyes
    fill(241, 28, 50); //red eyes
    ellipse(-15, -9, 25, 25); //L eye
    ellipse(36, -7, 25, 25); //R eye
    noStroke();
    fill(240);
    ellipse(-11, -11, 11, 11); //L eye shine
    ellipse(40, -9, 11, 11); //R eye shine
    stroke(0);

    //wings
    fill(70, 70, 68); //bat grey
    //L
    pushMatrix();
    //rotate(
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
    //R
    pushMatrix();
    //rotate();
    beginShape();
    vertex(49, 15);
    vertex(55, 34);
    vertex(48, 48);
    vertex(45, 35);
    vertex(40, 35);
    vertex(40, 31);
    vertex(43, 24);
    endShape(CLOSE);
    popMatrix();
  }

  void batDown()
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

    //inner ears
    //R
    pushMatrix();
    scale(1.0, 1.0);
    fill(255, 44, 115); //lighter mouth
    strokeWeight(2);
    beginShape();
    vertex(37, -44);
    vertex(50, -58);
    vertex(46, -30);
    endShape();
    popMatrix();
    //L
    pushMatrix();
    scale(-1.0, 1.0);
    fill(255, 44, 115); //lighter mouth
    strokeWeight(2);
    beginShape();
    vertex(37, -44);
    vertex(50, -58);
    vertex(46, -30);
    endShape();
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

    //mouth
    pushMatrix();
    translate(-8, 0);
    rotate(-radians(2));
    rectMode(CENTER);
    pushMatrix();
    translate(28, 14);
    rotate(radians(2));
    fill(255, 44, 115); //lighter mouth
    rect(-20, 2, 50, 34, 12); //mouth
    popMatrix();

    fill(180, 44, 100); //darker mouth
    noStroke();
    pushMatrix();
    translate(0, 0);
    rotate(radians(2));
    quad(-15, 0, 32, 0, 32, 13, -15, 13); //top of mouth
    popMatrix();

    stroke(0);

    //teeth
    fill(230);
    strokeWeight(2);
    // T L
    beginShape();
    vertex(0, -3);
    vertex(-2, 8);
    vertex(-7, 15);
    vertex(-10, 9);
    vertex(-13, 7);
    vertex(-16, -3);
    endShape(CLOSE);
    //T R
    beginShape();
    vertex(19, -1);
    vertex(20, 5);
    vertex(19, 12);
    vertex(30, 8);
    vertex(32, 4);
    endShape();
    //B L
    beginShape();
    vertex(-14, 29);
    vertex(-12, 24);
    vertex(-8, 24);
    vertex(-5, 22);
    vertex(-4, 28);
    vertex(-5, 31);
    endShape(CLOSE);
    //B R
    beginShape();
    vertex(19, 32);
    vertex(21, 24);
    vertex(29, 25);
    vertex(28, 31);
    endShape(CLOSE);
    strokeWeight(3);

    //eyes
    fill(241, 28, 50); //red eyes
    ellipse(-15, -9, 25, 25); //L eye
    ellipse(36, -7, 25, 25); //R eye
    noStroke();
    fill(240);
    pushMatrix();
    translate(-4, 2);
    ellipse(-11, -11, 11, 11); //L eye shine
    ellipse(40, -9, 11, 11); //R eye shine
    popMatrix();
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
}













































//// KEEP THIS STUFF BC LEFT ISNT WORKING FOR ME AND TRYING TO FIX


public void Lbat(int bx, int by, float rB, float sB) {
  pushStyle();
  strokeWeight(3);

  pushMatrix();
  translate(bx, by);
  rotate(rB);
  scale(sB);
  scale(-1.0, 1.0);

  //feet
  fill(70, 70, 68); //bat grey
  strokeWeight(2);
  //L
  beginShape();
  vertex(-33, 38);
  vertex(-34, 45);
  vertex(-32, 50);
  vertex(-29, 47);
  vertex(-29, 46);
  vertex(-25, 52);
  vertex(-24, 48);
  vertex(-21, 51);
  vertex(-18, 45);
  endShape();
  //R
  beginShape();
  vertex(-3, 49);
  vertex(-1, 55);
  vertex(2, 53);
  vertex(4, 56);
  vertex(7, 53);
  vertex(11, 54);
  vertex(13, 49);
  endShape();
  strokeWeight(3);

  ellipse(0, 0, 100, 100); //body

  //L ear overlap
  noStroke();
  quad(-48, -17, -48, -44, -46, -44, -40, -27); //ear filler
  noStroke();
  fill(70, 70, 68); //bat grey
  quad(-51, -54, -43, -53, -28, -36, -42, -24);
  stroke(0);
  strokeWeight(3);

  //mouth
  rectMode(CENTER);
  pushMatrix();
  translate(28, 14);
  rotate(radians(2));
  fill(255, 44, 115); //lighter mouth
  rect(-20, 2, 50, 34, 12); //mouth
  popMatrix();

  fill(180, 44, 100); //darker mouth
  noStroke();
  quad(-15, -1, 32, 0, 32, 15, -15, 13); //top of mouth
  stroke(0);

  //ears
  //L
  pushMatrix();
  scale(0.9);
  translate(-4, -3);
  pushMatrix();
  translate(-49, -55);
  rotate(-radians(16));
  fill(70, 70, 68); //bat grey
  arc(0, 0, 60, 85, 5*PI/8, 19*PI/16);
  popMatrix();
  beginShape();
  curveVertex(-156, -118);
  curveVertex(-79, -72);
  curveVertex(-59, -58);
  curveVertex(8, 11);
  endShape();
  line(-59, -60, -43, -57);
  line(-43, -57, -30, -42);
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

  noStroke();
  fill(70, 70, 68); //bat grey
  quad(-51, -54, -43, -53, -28, -36, -42, -24);
  stroke(0);
  strokeWeight(3);

  //hair
  pushMatrix();
  translate(-20, -44);
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

  //inner ear
  strokeWeight(2);
  line(-18, 24, -45, -2);
  fill(255, 44, 115); //lighter mouth
  beginShape();
  curveVertex(-36, -33);
  curveVertex(-27, 26);
  curveVertex(-45, -2);
  curveVertex(-21, 33);
  endShape();
  noStroke();
  fill(255, 44, 115); //lighter mouth
  triangle(-22, 21, -26, 27, -43, 1);
  stroke(0);
  strokeWeight(3);
  popMatrix();

  //teeth
  fill(230);
  strokeWeight(2);
  // T L
  beginShape();
  vertex(0, -3);
  vertex(-2, 8);
  vertex(-7, 15);
  vertex(-10, 9);
  vertex(-13, 7);
  vertex(-16, -3);
  endShape(CLOSE);
  //T R
  beginShape();
  vertex(19, -1);
  vertex(20, 5);
  vertex(19, 12);
  vertex(30, 8);
  vertex(32, 4);
  endShape();
  //B L
  beginShape();
  vertex(-14, 29);
  vertex(-12, 24);
  vertex(-8, 24);
  vertex(-5, 22);
  vertex(-4, 28);
  vertex(-5, 31);
  endShape(CLOSE);
  //B R
  beginShape();
  vertex(19, 32);
  vertex(21, 24);
  vertex(29, 25);
  vertex(28, 31);
  endShape(CLOSE);
  strokeWeight(3);

  //eyes
  fill(241, 28, 50); //red eyes
  ellipse(-15, -9, 25, 25); //L eye
  ellipse(36, -7, 25, 25); //R eye
  noStroke();
  fill(240);
  ellipse(-11, -11, 11, 11); //L eye shine
  ellipse(40, -9, 11, 11); //R eye shine
  stroke(0);

  //wings
  fill(70, 70, 68); //bat grey
  //L
  pushMatrix();
  //rotate(
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
  //R
  pushMatrix();
  //rotate();
  beginShape();
  vertex(49, 15);
  vertex(55, 34);
  vertex(48, 48);
  vertex(45, 35);
  vertex(40, 35);
  vertex(40, 31);
  vertex(43, 24);
  endShape(CLOSE);
  popMatrix();

  popMatrix();
  popStyle();
}

void Rbat(int bx, int by, float rB, float sB) {
  pushStyle();
  strokeWeight(3);

  pushMatrix();
  translate(bx, by);
  rotate(rB);
  scale(sB); 

  //feet
  fill(70, 70, 68); //bat grey
  strokeWeight(2);
  //L
  beginShape();
  vertex(-33, 38);
  vertex(-34, 45);
  vertex(-32, 50);
  vertex(-29, 47);
  vertex(-29, 46);
  vertex(-25, 52);
  vertex(-24, 48);
  vertex(-21, 51);
  vertex(-18, 45);
  endShape();
  //R
  beginShape();
  vertex(-3, 49);
  vertex(-1, 55);
  vertex(2, 53);
  vertex(4, 56);
  vertex(7, 53);
  vertex(11, 54);
  vertex(13, 49);
  endShape();
  strokeWeight(3);

  ellipse(0, 0, 100, 100); //body

  //L ear overlap
  noStroke();
  quad(-48, -17, -48, -44, -46, -44, -40, -27); //ear filler
  noStroke();
  fill(70, 70, 68); //bat grey
  quad(-51, -54, -43, -53, -28, -36, -42, -24);
  stroke(0);
  strokeWeight(3);

  //mouth
  rectMode(CENTER);
  pushMatrix();
  translate(28, 14);
  rotate(radians(2));
  fill(255, 44, 115); //lighter mouth
  rect(-20, 2, 50, 34, 12); //mouth
  popMatrix();

  fill(180, 44, 100); //darker mouth
  noStroke();
  quad(-15, -1, 32, 0, 32, 15, -15, 13); //top of mouth
  stroke(0);

  //ears
  //L
  pushMatrix();
  scale(0.9);
  translate(-4, -3);
  pushMatrix();
  translate(-49, -55);
  rotate(-radians(16));
  fill(70, 70, 68); //bat grey
  arc(0, 0, 60, 85, 5*PI/8, 19*PI/16);
  popMatrix();
  beginShape();
  curveVertex(-156, -118);
  curveVertex(-79, -72);
  curveVertex(-59, -58);
  curveVertex(8, 11);
  endShape();
  line(-59, -60, -43, -57);
  line(-43, -57, -30, -42);
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

  noStroke();
  fill(70, 70, 68); //bat grey
  quad(-51, -54, -43, -53, -28, -36, -42, -24);
  stroke(0);
  strokeWeight(3);

  //hair
  pushMatrix();
  translate(-20, -44);
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

  //inner ear
  strokeWeight(2);
  line(-18, 24, -45, -2);
  fill(255, 44, 115); //lighter mouth
  beginShape();
  curveVertex(-36, -33);
  curveVertex(-27, 26);
  curveVertex(-45, -2);
  curveVertex(-21, 33);
  endShape();
  noStroke();
  fill(255, 44, 115); //lighter mouth
  triangle(-22, 21, -26, 27, -43, 1);
  stroke(0);
  strokeWeight(3);
  popMatrix();

  //teeth
  fill(230);
  strokeWeight(2);
  // T L
  beginShape();
  vertex(0, -3);
  vertex(-2, 8);
  vertex(-7, 15);
  vertex(-10, 9);
  vertex(-13, 7);
  vertex(-16, -3);
  endShape(CLOSE);
  //T R
  beginShape();
  vertex(19, -1);
  vertex(20, 5);
  vertex(19, 12);
  vertex(30, 8);
  vertex(32, 4);
  endShape();
  //B L
  beginShape();
  vertex(-14, 29);
  vertex(-12, 24);
  vertex(-8, 24);
  vertex(-5, 22);
  vertex(-4, 28);
  vertex(-5, 31);
  endShape(CLOSE);
  //B R
  beginShape();
  vertex(19, 32);
  vertex(21, 24);
  vertex(29, 25);
  vertex(28, 31);
  endShape(CLOSE);
  strokeWeight(3);

  //eyes
  fill(241, 28, 50); //red eyes
  ellipse(-15, -9, 25, 25); //L eye
  ellipse(36, -7, 25, 25); //R eye
  noStroke();
  fill(240);
  ellipse(-11, -11, 11, 11); //L eye shine
  ellipse(40, -9, 11, 11); //R eye shine
  stroke(0);

  //wings
  fill(70, 70, 68); //bat grey
  //L
  pushMatrix();
  //rotate(
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
  //R
  pushMatrix();
  //rotate();
  beginShape();
  vertex(49, 15);
  vertex(55, 34);
  vertex(48, 48);
  vertex(45, 35);
  vertex(40, 35);
  vertex(40, 31);
  vertex(43, 24);
  endShape(CLOSE);
  popMatrix();

  popMatrix();
  popStyle();
}

void UDbat(int bx, int by, float rB, float sB) {
  pushStyle();
  strokeWeight(3);

  pushMatrix();
  translate(bx, by);
  rotate(rB);
  scale(sB); 

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

  //inner ears
  //R
  pushMatrix();
  scale(1.0, 1.0);
  fill(255, 44, 115); //lighter mouth
  strokeWeight(2);
  beginShape();
  vertex(37, -44);
  vertex(50, -58);
  vertex(46, -30);
  endShape();
  popMatrix();
  //L
  pushMatrix();
  scale(-1.0, 1.0);
  fill(255, 44, 115); //lighter mouth
  strokeWeight(2);
  beginShape();
  vertex(37, -44);
  vertex(50, -58);
  vertex(46, -30);
  endShape();
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

  //mouth
  pushMatrix();
  translate(-8, 0);
  rotate(-radians(2));
  rectMode(CENTER);
  pushMatrix();
  translate(28, 14);
  rotate(radians(2));
  fill(255, 44, 115); //lighter mouth
  rect(-20, 2, 50, 34, 12); //mouth
  popMatrix();

  fill(180, 44, 100); //darker mouth
  noStroke();
  pushMatrix();
  translate(0, 0);
  rotate(radians(2));
  quad(-15, 0, 32, 0, 32, 13, -15, 13); //top of mouth
  popMatrix();

  stroke(0);

  //teeth
  fill(230);
  strokeWeight(2);
  // T L
  beginShape();
  vertex(0, -3);
  vertex(-2, 8);
  vertex(-7, 15);
  vertex(-10, 9);
  vertex(-13, 7);
  vertex(-16, -3);
  endShape(CLOSE);
  //T R
  beginShape();
  vertex(19, -1);
  vertex(20, 5);
  vertex(19, 12);
  vertex(30, 8);
  vertex(32, 4);
  endShape();
  //B L
  beginShape();
  vertex(-14, 29);
  vertex(-12, 24);
  vertex(-8, 24);
  vertex(-5, 22);
  vertex(-4, 28);
  vertex(-5, 31);
  endShape(CLOSE);
  //B R
  beginShape();
  vertex(19, 32);
  vertex(21, 24);
  vertex(29, 25);
  vertex(28, 31);
  endShape(CLOSE);
  strokeWeight(3);

  //eyes
  fill(241, 28, 50); //red eyes
  ellipse(-15, -9, 25, 25); //L eye
  ellipse(36, -7, 25, 25); //R eye
  noStroke();
  fill(240);
  pushMatrix();
  translate(-4, 2);
  ellipse(-11, -11, 11, 11); //L eye shine
  ellipse(40, -9, 11, 11); //R eye shine
  popMatrix();
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

  popMatrix();
  popStyle();
}