//Oscar Jones //<>// //<>// //<>//
//Justis Mackaou
//Zachary Richardson
//Declan Kelly

Human character; //<>// //<>// //<>//
Bat bitey;
Animation anim;
Map map;
PVector start;
int x = 0;
void setup() {
  size(1210, 610);
  start = new PVector(0, (int) random(0, 10));
  map = new Map(width, height, start);
  character = new Human(Map.WALL_WIDTH_PX + 15, Map.WALL_WIDTH_PX + 10 + (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) * start.y, 1);
  bitey = new Bat(200, 200, .25);
  anim = new Animation();
  frameRate(60);
}

void draw() {
  //685
  if (frameCount < 685) {
    anim.draw();
  } else {
    background(map.getBackground());
    character.update();
    handleCollisions(character, map.query(character.bound));
    character.draw();
    
    bitey.update();
    bitey.draw();
  }
}

void handleCollisions(Human chr, ArrayList<BoundingBox> bs) {
  pushStyle();
  for (BoundingBox b : bs)
    if (b.intersects(chr.bound)) {
      PVector proj = b.overlap(chr.bound);
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