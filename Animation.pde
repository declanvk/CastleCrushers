//1404 total frames

public class Animation {
  PVector Loc, dir;
  PVector Bloc, Bdir;
  PVector casLoc, castle, cruLoc, crushers;
  PImage paper = loadImage("parchment.jpg");
  PImage stone = loadImage("stone_wall.png");
  float time, LegR, ArmR, sz, walk, xC, yC;
  boolean animate, turned, LegDown, ArmDown, walking = false;
  boolean birdFly, birdDown, wingDown;
  int num = 4;
  int t = 0;
  float Bangle = 0;
  float wingR = PI/8;
  PFont terminus = createFont("TerminusTTF-4.39.ttf",30);
  PFont luminari = loadFont("Luminari-Regular-48.vlw");
  
  float[] cloudX = new float[num];
  float[] cloudY = new float[num];
  
  Animation() {
    this.sz = 5;
    this.Loc = new PVector(-20, 400);
    this.dir = new PVector(1, 0);
    this.Bloc = new PVector(170,523);
    this.Bdir = new PVector(-1.5,-4.5);
    this.casLoc = new PVector(234,-120);
    this.cruLoc = new PVector(574,-120);
    this.castle = new PVector(0,6);
    this.crushers = new PVector(0, 6);
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
    if(frameCount<300) {
      for(int y=0; y<height; y+=64) {
        for(int x=0; x<width; x+=64) {
        pushMatrix();
          translate(x,y);
          image(stone,-3,-3);
        popMatrix();
        }
      }
      textFont(luminari,160);
      fill(0);
      text("Castle Crushers", width/2 - 300, height/2 - 200, 700,500);
    }
    if(frameCount>=300 && frameCount<660) {
      image(paper,0,0);
      textFont(luminari,72);
      fill(30);
      String s = "Lonely Sir Swordsby had the day off and felt compelled to explore deep into the woods...";
      text(s, 120,120, 990,515);  
    }
    
    if(frameCount >= 660) {
    
      background(12, 205, 216);
      noStroke();
      fill(78, 155, 16);
      rect(0, height/2, width, height/2);
      stroke(0);
      
      castle();
      crushers();
      path();
      tree(694, 320, 0.3, 65, 120, 80);
      castle(520, 310);
      tree(59, 340, 0.7, 106, 118, 94);
      tree(206, 388, 1.0, 99, 120, 52);
      
      if(t>300 && t<335) {
        Bangle = Bangle += -radians(1.5); 
      }
      if(t>=335 && t<345) {
        Bangle = Bangle += radians(1.5);
      }
      if(t>=345 && t<355) {
        Bangle = Bangle += -radians(1.5);
      }
      if(t>=355 && t<390) {
        Bangle = Bangle += radians(1.5);
      }
      if(t>=390) {
        Bangle = 0;
      }
      
      birdG(Bangle);
      
      if(frameCount > 1230) {
      princessCry();
      }
      
      if(frameCount <= 1404) {
       Knight(); 
      }
      animate();
      clouds();
      for (int x = 0; x < num; x++) {
        cloudX[x] += .1;
      }
      tree(365, 490, 2.2, 56, 117, 72);
      tree(1014, 335, 0.5, 98, 136, 43);
      tree(811, 400, 1.2, 80, 172, 49);
      tree(455, 350, 0.6, 65, 138, 76);
      tree(888, 445, 1.9, 68, 132, 95);
      tree(1108, 440, 1.6, 66, 178, 93);
      
      exclamation();

      t+=1;
    }
    
  }

  public void Knight() {
    pushStyle();
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
    popStyle();
  }

  public void animate() {
    //bird (raven)
    if(frameCount > 1250) {
      birdFly = true;  
    }
    if (birdFly == true) {
       Bloc.x = Bloc.x + Bdir.x*time;
       Bloc.y = Bloc.y + Bdir.y*time;
       
       if (wingR > PI/4) {
         wingDown = true;
       }
       if (wingR < -PI/6) {
         wingDown = false;  
       }
       
       if (wingDown == false) {
         wingR += .20;
       } else {
         wingR -= .20;  
       }
    }
    
    //knight
    if (frameCount < 1240) {
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
    } 
    if(frameCount > 1320 && Loc.x <600) {
      Loc.x = Loc.x + dir.x*time*2;
      Loc.y = Loc.y + dir.y*time*2;
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
    }
    if (Loc.x >= 600 && Loc.y >385) {
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
  
    if (frameCount>720 && casLoc.y<=150) {
      casLoc.x = casLoc.x + castle.x*time;
      casLoc.y = casLoc.y + castle.y*time;
    }
    if (frameCount>750 && cruLoc.y<=150) {
      cruLoc.x = cruLoc.x + crushers.x*time;
      cruLoc.y = cruLoc.y + crushers.y*time;
    }
  }

  public void castle(float a, float b) {
    pushStyle();
    pushMatrix();
    translate(a, b);
    scale(3);
    fill(200);
    stroke(0);
    strokeWeight(.3);
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
    popStyle();
  }

  public void clouds() {
    pushStyle();
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
    popStyle();
  }

  public void tree(int trex, float trey, float sz, int tR, int tG, int tB) {
    pushStyle();
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
    popStyle();
  }

  public void path() {
    pushStyle();
    for (int i=0; i<200; i++) {
      noStroke();
      fill(143, 114, 82);
      ellipse(613+0.15*i, 400+0.85*i, 20+0.3*i, 5);
      rectMode(CENTER);
      rect(6.1*i, 600, 10, 60);
      rectMode(CORNER);
      pushMatrix();
      translate(603, 569);
      rotate(-radians(0.45*i));
      rect(0, 0, 5, 78); 
      popMatrix();
    }
    rect(563, 536, 50, 50);
    fill(78, 155, 16); // grass green
    arc(565, 536, 75, 67, 0, 3.2);
    stroke(0);
    popStyle();
  }
  
  public void birdG(float bR) {
    
    if(frameCount > 1320) {
    birdFly = true;  
    }
    
    pushStyle();
    noStroke();
    pushMatrix();
    translate(Bloc.x,Bloc.y);
    //scale(0.7);
    fill(38,37,42); //raven grey 
      //legs
      pushMatrix();
        translate(7,18);
        rotate(radians(20));
        rect(-1,-6, 2,18);
        rect(-8,0,2,12);
      popMatrix(); 
      //feet
      pushMatrix();
        translate(3,29);
        rotate(radians(20));
        rect(-1,0, 1,8);
        rotate(-PI/6);
        rect(-1,0,1,8);
        rotate(PI/3);
        rect(-1,0,1,8);
      popMatrix();
      pushMatrix();
        translate(-4,26);
        rotate(radians(30));
        rect(-1,0, 1,8);
        rotate(-PI/6);
        rect(-1,0,1,8);
        rotate(PI/3);
        rect(-1,0,1,8);
      popMatrix();
      
      if(t > 200) {
         
      }
      rotate(bR); //rotates bird, not feet
      
      //body
      pushMatrix();
        rotate(radians(20));
        ellipse(0,0, 64,32);
      popMatrix();
      //tail
      pushMatrix();
        translate(25,5);
        rotate(radians(45));
        ellipse(0,0, 48,10);
      popMatrix();
     
      //head + beak
      pushMatrix();
      translate(-26,-17);
        fill(0);
        beginShape();
          curveVertex(18,27);
          curveVertex(0,5);
          curveVertex(-8,-2);
          curveVertex(-25,0);
          curveVertex(-28,3);
          curveVertex(-33,6);
        endShape();
        triangle(-24,2, -14,1, -11,4);
        fill(38,37,42);
        pushMatrix();
        rotate(PI/12);
          ellipse(0,0,30,20); //head
        popMatrix();  
          fill(0);
          ellipse(-8,-4,4,4); //eye
      popMatrix();
      
        if(birdFly == false) {
          pushMatrix();
          translate(-26,-17);
            stroke(0);
            fill(38,37,42);
            beginShape(); // wing
              curveVertex(4,-18);
              curveVertex(14,8);
              curveVertex(23,24);
              curveVertex(42,26);
              curveVertex(74,18);
            endShape();
          popMatrix();
        } else {
          pushStyle();
          pushMatrix();
            translate(-13,-11);
            rotate(wingR);
            fill(38,37,42);
            ellipse(37,4, 70,30);
          popMatrix();
          popStyle();
        }
     
    popMatrix();
    popStyle();
    
  }
  
  public void princessCry() {
    pushStyle();
    pushMatrix();   
      fill(255);
      noStroke();
      ellipse(715,276, 130,90);
      
      for (int i=0; i<90; i++) {
        float cx=  70*cos(radians(i)-PI/4);
        float cy= -70*sin(radians(i)-PI/4);
        pushMatrix();
          translate(610,300);
          rotate(PI/4);
          ellipse(cx,cy, 0.3*i, 5);   
        popMatrix();
      }
     
      textFont(terminus);
      fill(0);
      text("HELP!!!", 666,284); 
    
    popMatrix();
    popStyle();
  }
  
  public void castle() {
    pushStyle();
    pushMatrix();
      translate(casLoc.x, casLoc.y);
      textFont(luminari,100);
      fill(230,180);
      text("Castle",0,0);
    popMatrix();
    pushStyle();
  }
  
  public void crushers() {
    pushStyle();
    pushMatrix();
      translate(cruLoc.x, cruLoc.y);
      textFont(luminari,100);
      fill(230,180);
      text("Crushers",0,0);
    popMatrix();
    pushStyle();
  }
  
  public void exclamation() {
    pushStyle();
    pushMatrix();
      translate(660,430);
      scale(0.7);
      if(frameCount>1240 && frameCount<1320) {
        fill(255);
        noStroke();
        ellipse(0,25, 9,9);
        for(int i=0; i<30; i++) {
          rectMode(CENTER);
          rect(0,-20+1.2*i, 12-0.3*i,5);    
        }
      }
    popMatrix();
    popStyle();
  }
  
}
