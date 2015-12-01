public class Human {
  final int MOVESPEED=5;
  public float pointX, pointY, size, LegR, ArmR, walk, wd, ht;
  public boolean movingUp, movingDown, movingRight, movingLeft, LegDown, ArmDown, walking;
  public PImage img;
  public String position, last;
  public Point p;

  Human(float x, float y, float sz) {
    this.pointX=x;
    this.pointY=y;
    this.size=sz;
    this.wd=sz*18;
    this.ht=sz*35;
    this.position="RIGHT";
  }

  public void drawPosition(String pos) {
    if (pos=="UP") {

      // Legs 
      fill(255);
      rect(5, 23, 4, 10+walk);
      rect(9, 23, 4, 10-walk);

      // Arms
      rect(0, 15, 4, 11-walk);
      rect(-1, 26 - walk, 6, 2);
      rect(14, 15, 4, 11+walk);
      rect(13, 26 + walk, 6, 2);

      // Body
      beginShape();
      vertex(0, 15);
      vertex(18, 15);
      vertex(14, 27);
      vertex(4, 27);
      vertex(0, 15);
      endShape();

      // Helmet
      fill(205, 50, 50);
      beginShape();
      vertex(1, 0);
      vertex(1, 16);
      vertex(9, 23);
      vertex(17, 16);
      vertex(17, 0);
      vertex(9, -2);
      vertex(1, 0);
      endShape();
    }

    if (pos=="LEFT") {

      // Right Arm 
      pushMatrix();
      fill(255);
      translate(7, 19);
      rotate(ArmR);
      translate(-7, -19);
      fill(255);
      rect(10, 19, -7, 3);
      rect(2, 18, 2, 5);
      fill(100);
      beginShape();
      vertex(2, 18);
      vertex(1, 12);
      vertex(3, 8);
      vertex(3, 18);
      vertex(2, 18);
      endShape();
      beginShape();
      vertex(4, 18);
      vertex(5, 12);
      vertex(3, 8);
      vertex(3, 18);
      endShape();
      popMatrix();

      // Legs 
      pushMatrix();
      fill(255);
      translate(7, 5);
      translate(0, 19);
      rotate(LegR);
      translate(0, -19);
      rect(0, 18, 4, 10);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(5, 5);
      translate(3, 19);
      rotate(-LegR);
      translate(-3, -19);
      rect(3, 18, 4, 10);
      popMatrix();

      // Body
      fill(255);
      ellipse(10, 20, 10, 15);

      // Helmet
      fill(205, 50, 50);
      beginShape();
      vertex(0, 0);
      vertex(0, 20);
      vertex(15, 15);
      vertex(15, 0);
      vertex(7, -2);
      vertex(0, 0);
      endShape();

      // Faceplate
      fill(255);
      beginShape();
      vertex(0, 3);
      vertex(4, 1);
      vertex(4, 8);
      vertex(10, 8);
      vertex(10, 14);
      vertex(4, 14);
      vertex(4, 21);
      vertex(0, 21);
      vertex(0, 3);
      endShape();

      // Eyes
      fill(0);
      triangle(3, 12, 7, 9, 7, 12);

      // Ear Plate
      fill(205, 50, 50);
      ellipse(10, 11, 3, 6);

      // Left Arm 
      pushMatrix();
      fill(255);
      translate(11, 19);
      rotate(-ArmR);
      translate(-11, -19);
      fill(255);
      rect(10, 19, -7, 3);
      rect(2, 18, 2, 5);
      fill(100);
      popMatrix();
    }

    if (pos=="DOWN") {
      // Legs 
      fill(255);
      rect(5, 23, 4, 10+walk);
      rect(9, 23, 4, 10-walk);

      // Arms
      rect(0, 15, 4, 11-walk);
      rect(-1, 26 - walk, 6, 2);
      rect(14, 15, 4, 11+walk);
      rect(13, 26 + walk, 6, 2);

      pushMatrix();
      fill(255);
      translate(9, 5);
      translate(0, 19);
      rotate(LegR);
      translate(0, -19);
      rect(0, 18, 4, 10);
      popMatrix();

      // Body
      fill(255);
      beginShape();
      vertex(0, 15);
      vertex(18, 15);
      vertex(14, 27);
      vertex(4, 27);
      vertex(0, 15);
      endShape();

      // Helmet
      fill(205, 50, 50);
      beginShape();
      vertex(1, 0);
      vertex(1, 16);
      vertex(9, 23);
      vertex(17, 16);
      vertex(17, 0);
      vertex(9, -2);
      vertex(1, 0);
      endShape();

      // Faceplate
      fill(255);
      beginShape();
      vertex(9, 3);
      vertex(13, 1);
      vertex(13, 8);
      vertex(17, 8);
      vertex(17, 14);
      vertex(13, 14);
      vertex(13, 20);
      vertex(9, 23);
      vertex(5, 20);
      vertex(5, 14);
      vertex(1, 14);
      vertex(1, 8);
      vertex(5, 8);
      vertex(5, 1);
      vertex(9, 3);
      endShape();

      // Eyes
      fill(0);
      triangle(6, 12, 3, 10, 3, 12);
      triangle(12, 12, 15, 10, 15, 12);
    }

    if (pos=="RIGHT") {

      // Legs
      pushMatrix();
      fill(255);
      translate(2, 5);
      translate(3, 19);
      rotate(-LegR);
      translate(-3, -19);
      rect(3, 18, 4, 10);
      rect(3, 28, 6, 2);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(3, 5);
      translate(3, 19);
      rotate(LegR);
      translate(-3, -19);
      rect(3, 18, 4, 10);
      rect(3, 28, 6, 2);
      popMatrix();

      // Left Arm 
      pushMatrix();
      fill(255);
      translate(7, 19);
      rotate(-ArmR);
      translate(-7, -19);
      fill(255);
      rect(6, 19, 7, 3);
      rect(12, 18, 2, 5);
      fill(100);
      popMatrix();

      // Body
      fill(255);
      ellipse(7, 20, 10, 15);

      // Helmet
      fill(205, 50, 50);
      beginShape();
      vertex(15, 0);
      vertex(15, 20);
      vertex(0, 15);
      vertex(0, 0);
      vertex(6, -2);
      vertex(15, 0);
      endShape();

      // Faceplate
      fill(255);
      beginShape();
      vertex(15, 3);
      vertex(11, 1);
      vertex(11, 8);
      vertex(5, 8);
      vertex(5, 14);
      vertex(11, 14);
      vertex(11, 21);
      vertex(15, 21);
      vertex(15, 3);
      endShape();

      // Eyes
      fill(0);
      triangle(12, 12, 8, 9, 8, 12);

      // Ear Plate
      fill(205, 50, 50);
      ellipse(5, 11, 3, 6);

      // Right Arm 
      pushMatrix();
      fill(255);
      translate(7, 19);
      rotate(ArmR);
      translate(-7, -19);
      fill(255);
      rect(6, 19, 7, 3);
      rect(12, 18, 2, 5);
      fill(100);
      beginShape();
      vertex(12, 18);
      vertex(11, 12);
      vertex(13, 8);
      vertex(13, 18);
      vertex(12, 18);
      endShape();
      beginShape();
      vertex(14, 18);
      vertex(15, 12);
      vertex(13, 8);
      vertex(13, 18);
      endShape();
      popMatrix();
    }
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    translate(this.pointX, this.pointY);
    scale(this.size); // I think a scale of 2x or 3x is best but we can discuss

    if (movingUp || movingLeft || movingDown || movingRight) {
      this.drawPosition(position);
    } else {
      drawPosition(last);
    }
    popMatrix();
    popStyle();
  }

  public void update() {
    this.last=this.position;

    if (movingRight)
    {
      if (this.pointX+this.wd+MOVESPEED<=width) {
        this.pointX+=MOVESPEED;
        this.position="RIGHT";
      } else {
        this.pointX=width-this.wd;
        this.position="RIGHT";
      }

      //  moving
      if (LegR < -radians(45)) {
        LegDown = false;
      } 
      if (LegR > radians(45)) {
        LegDown = true;
      }
      if (LegDown == true) {
        LegR -= .1;
      } else {
        LegR += .1;
      }
      if (ArmR < -radians(30)) {
        ArmDown = false;
      } 
      if (ArmR > radians(90)) {
        ArmDown = true;
      }
      if (ArmDown == true) {
        ArmR -= .12;
      } else {
        ArmR += .12;
      }
    }

    if (movingLeft)
    {
      if (this.pointX-MOVESPEED>=0) {
        this.pointX-=MOVESPEED;
        this.position="LEFT";
      } else {
        this.pointX=0;
        this.position="LEFT";
      }

      //  moving
      if (LegR < -radians(45)) {
        LegDown = false;
      } 
      if (LegR > radians(45)) {
        LegDown = true;
      }
      if (LegDown == true) {
        LegR -= .1;
      } else {
        LegR += .1;
      }
      if (ArmR < -radians(30)) {
        ArmDown = false;
      } 
      if (ArmR > radians(90)) {
        ArmDown = true;
      }
      if (ArmDown == true) {
        ArmR -= .12;
      } else {
        ArmR += .12;
      }
    } 

    if (movingUp)
    {
      if (this.pointY-MOVESPEED>=0) {
        this.pointY-=MOVESPEED;
        this.position="UP";
      } else {
        this.pointY=0;
        this.position="UP";
      }

      if (walking == true) {
        walk -= .3;
      } else {
        walk += .3;
      }
      if (walk < -1) {
        walking = false;
      } 
      if (walk > 1) {
        walking = true;
      }
    } 
    if (movingDown)
    {
      if (this.pointY+this.ht+MOVESPEED<=height) {
        this.pointY+=MOVESPEED;
        this.position="DOWN";
      } else {
        this.pointY=height-this.ht;
        this.position="DOWN";
      }


      if (walking == true) {
        walk -= .3;
      } else {
        walk += .3;
      }
      if (walk < -1) {
        walking = false;
      } 
      if (walk > 1) {
        walking = true;
      }
    }
  }
}

public class Enemy {
  Enemy() {
  }
}