Human character; //<>// //<>// //<>//
Bat bitey;
Animation anim;
Map map;
int x = 0;
void setup() {
  size(1210, 610);
  map = new Map(width, height);
  character = new Human(25, 20, 1);
  bitey = new Bat(200, 200, .25);
  anim = new Animation();
  frameRate(120);
}

void draw() {
  //println(frameRate);
  if (frameCount < 0) {
    anim.draw();
  } else {
    //println(frameRate);
    background(map.getBackground());
    character.update();
    handleCollisions(character, map.query(character.bound));
    character.draw();
    bitey.draw();
  }
}

void handleCollisions(Human chr, ArrayList<BoundingBox> bs) {
  pushStyle();
  rect(chr.bound.anchor.x, chr.bound.anchor.y, chr.bound.width, chr.bound.height);
  for (BoundingBox b : bs)
    if (b.intersects(chr.bound)) {
      PVector proj = b.overlap(chr.bound);
      PVector center = b.center();
      rect(b.anchor.x, b.anchor.y, b.width, b.height);
      line(center.x, center.y, center.x + proj.x, center.y + proj.y);
      chr.bound.shift(proj.x, proj.y);
    }
  popStyle();
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
  case 87:
    character.MOVESPEED++;
    println(character.MOVESPEED);
    break;
  case 83:
    character.MOVESPEED--;
    println(character.MOVESPEED);
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