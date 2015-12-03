
// 672 Frames

public class Animation {
  PVector Loc;
  PVector dir;
  float time, LegR, ArmR, sz, walk, xC, yC;
  boolean animate, turned, LegDown, ArmDown, walking = false;
  int num = 4;
  float[] cloudX = new float[num];
  float[] cloudY = new float[num];

  Animation() {
    this.sz = 5;
    this.Loc = new PVector(-20, 400);
    this.dir = new PVector(1, 0);
    this.time = 1;
    this.walk=1;
    for (int x = 0; x < num; x++) {
      if (x < num/2) {
        this.cloudX[x] = random(30, width/2);
      } else {
        this.cloudX[x] = random(width/2, width-30);
      }
      this.cloudY[x] = random(50, 200);
    }
  }

  public void draw() {
    background(12, 205, 216);
    fill(78, 155, 16);
    rect(0, height/2, width, height/2);
    path();
    tree(694, 320, 0.3, 65, 120, 80);
    castle(520, 310);
    tree(59, 340, 0.7, 106, 118, 94);
    tree(206, 388, 1.0, 99, 120, 52);
    Knight();
    animate();
    clouds();
    for (int x = 0; x < num; x++) {
      cloudX[x] += .1;
    }
    tree(365, 490, 2.2, 56, 117, 72);
    tree(1014, 335, 0.5, 98, 136, 43);
    tree(811, 400, 1.2, 80, 172, 49);
    tree(455, 350, 0.6, 65, 138, 76);
    tree(888, 470, 2.0, 68, 132, 95);
    tree(1108, 440, 1.6, 66, 178, 93);
  }

  public void Knight() {
    strokeWeight(.3);
    pushMatrix();
    translate(Loc.x, Loc.y);
    scale(sz);

    if (turned == true) {

      // Legs 
      pushMatrix();
      fill(255);
      rect(5, 23, 4, 10+walk);
      popMatrix();

      pushMatrix();
      fill(255);
      rect(9, 23, 4, 10-walk);
      popMatrix();

      // Arms
      pushMatrix();
      fill(255);
      rect(0, 15, 4, 11-walk);
      rect(-1, 26 - walk, 6, 2);
      popMatrix();

      pushMatrix();
      fill(255);
      rect(14, 15, 4, 11+walk);
      rect(13, 26 + walk, 6, 2);
      fill(#B47C02); 
      ellipse(16, 27+walk, 1, 1);
      fill(255);
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

    if (turned == false) {
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
    popMatrix();
  }

  public void animate() {
    if (Loc.x < 600) {
      Loc.x = Loc.x + dir.x*time;
      Loc.y = Loc.y + dir.y*time;
      // Legs moving
      if (LegR < -radians(35)) {
        LegDown = false;
      } 
      if (LegR > radians(40)) {
        LegDown = true;
      }
      if (LegDown == true) {
        LegR -= .04;
      } else {
        LegR += .04;
      }
      if (ArmR < radians(35)) {
        ArmDown = false;
      } 
      if (ArmR > radians(130)) {
        ArmDown = true;
      }
      if (ArmDown == true) {
        ArmR -= .04;
      } else {
        ArmR += .04;
      }
    } else if (Loc.x >= 600 && Loc.y >385) {
      dir.y=-1;
      sz-=0.08;
      turned = true;
      Loc.y = Loc.y + dir.y*time*.05;
      Loc.x = Loc.x + dir.x*time*.25;
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
    } else if (Loc.y <= 385) {
      sz = 0;
      frameRate(60);

      noLoop();
    }
  }

  public void castle(float a, float b) {
    pushMatrix();
    translate(a, b);
    scale(3);
    fill(200);
    stroke(0);
    for (int x = 0; x < 60; x+=10) {
      for (int y = 0; y < 30; y+=5) {
        rect(x, y, 10, 5);
      }
    }

    for (int x = 10; x < 50; x+=10) {
      for (int y = -15; y < 0; y+=5) {
        rect(x, y, 10, 5);
      }
    }
    fill(0);
    rect(20, 5, 20, 25);
    fill(200, 0, 0);
    triangle(10, -15, 30, -30, 50, -15);
    popMatrix();
  }

  public void clouds() {
    noStroke();
    fill(255);
    for (int i = 0; i < num; i++) {
      pushMatrix();
      ellipse(cloudX[i], cloudY[i], 40, 40);
      ellipse(cloudX[i]+35, cloudY[i], 40, 40);
      ellipse(cloudX[i]+65, cloudY[i], 40, 40);
      ellipse(cloudX[i]+15, cloudY[i]-20, 40, 40);
      ellipse(cloudX[i]+45, cloudY[i]-20, 40, 40);

      popMatrix();
    }
    stroke(0);
  }

  public void tree(int trex, float trey, float sz, int tR, int tG, int tB) {
    //tx is X value of upper left corner tree trunk
    float treeW=15;    //width of tree trunk
    float steppe=40;    //X spacing of tree branches/triangles
    noStroke();
    pushMatrix();
    translate(trex, trey);
    scale(sz);
    fill(100, 86, 70); //tree trunk color
    rect(0, 0, treeW, 60);
    fill(tR, tG, tB); //tree top color
    for (int j=0; j<5; j++) {
      float treeY= j*-20;    //Y spacing of tree branches/triangles
      triangle(0-steppe, 15+treeY, treeW/2, treeY-30, treeW+steppe, 15+treeY);  
      trey=trey-treeY; 
      steppe=3*steppe/4;
    } 
    popMatrix();
    stroke(0);
  }

  public void path() {
    for (int i=0; i<100; i++) {
      noStroke();
      fill(143, 114, 82);
      ellipse(613+0.3*i, 400+1.7*i, 20+0.6*i, 5);
      rectMode(CENTER);
      rect(6.1*i, 600, 10, 60);
      rectMode(CORNER);
      pushMatrix();
      translate(603, 569);
      rotate(-radians(0.9*i));
      rect(0, 0, 5, 78); 
      popMatrix();
    }
    rect(563, 536, 50, 50);
    fill(78, 155, 16); // grass green
    arc(565, 536, 75, 67, 0, 3.2);
    stroke(0);
  }
}