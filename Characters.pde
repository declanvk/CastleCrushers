public class Human {
  final int MOVESPEED = 1;
  public float size, rotateLeg, rotateArm;
  public BoundingBox bound;
  public boolean movingUp, movingDown, movingRight, movingLeft;
  public PImage img;
  public String position, last;
  public Point p;

  Human(float x, float y, float sz) {
    this.bound = new BoundingBox(new Point(x, y), (int)(sz * 18), (int)(sz * 35));
    this.size=sz;
    this.rotateLeg=0;
    this.position="RIGHT";
  }

  public void drawPosition(String pos) {
    if (pos=="UP") {
      // Legs 

      pushMatrix();
      fill(255);
      translate(0, 5);
      translate(5, 19);
      rotate(-rotateLeg);
      translate(-5, -19);
      rect(5, 18, 4, 10);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(9, 5);
      translate(0, 19);
      rotate(rotateLeg);
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
    }

    if (pos=="LEFT") {

      // Legs 

      pushMatrix();
      fill(255);
      translate(5, 5);
      translate(5, 19);
      rotate(-rotateLeg);
      translate(-5, -19);
      rect(5, 18, 4, 10);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(7, 5);
      translate(0, 19);
      rotate(rotateLeg);
      translate(0, -19);
      rect(0, 18, 4, 10);
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
    }

    if (pos=="DOWN") {

      // Legs 

      pushMatrix();
      fill(255);
      translate(0, 5);
      translate(5, 19);
      rotate(-rotateLeg);
      translate(-5, -19);
      rect(5, 18, 4, 10);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(9, 5);
      translate(0, 19);
      rotate(rotateLeg);
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
      translate(5, 19);
      rotate(-rotateLeg);
      translate(-5, -19);
      rect(5, 18, 4, 10);
      popMatrix();

      pushMatrix();
      fill(255);
      translate(3, 5);
      translate(0, 19);
      rotate(rotateLeg);
      translate(0, -19);
      rect(0, 18, 4, 10);
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
    }
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    translate(this.bound.anchor.x, this.bound.anchor.y);
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
      if (this.bound.anchor.x + this.bound.width + MOVESPEED <= width) {
        this.bound.anchor.x += MOVESPEED;
        this.position="RIGHT";
      } else {
        this.bound.anchor.x = width - this.bound.width;
        this.position="RIGHT";
      }
    }

    if (movingLeft)
    {
      if (this.bound.anchor.x - MOVESPEED >= 0) {
        this.bound.anchor.x -= MOVESPEED;
        this.position="LEFT";
      } else {
        this.bound.anchor.x = 0;
        this.position="LEFT";
      }
    } 

    if (movingUp)
    {
      if (this.bound.anchor.y - MOVESPEED >= 0) {
        this.bound.anchor.y -= MOVESPEED;
        this.position="UP";
      } else {
        this.bound.anchor.y = 0;
        this.position="UP";
      }
    } 
    if (movingDown)
    {
      if (this.bound.anchor.y + this.bound.height + MOVESPEED <= height) {
        this.bound.anchor.y += MOVESPEED;
        this.position="DOWN";
      } else {
        this.bound.anchor.y = height - this.bound.height;
        this.position="DOWN";
      }
    }
  }
}

public class Enemy {
  Enemy() {
  }
}