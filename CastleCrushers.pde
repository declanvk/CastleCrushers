//Oscar Jones //<>// //<>// //<>// //<>// //<>// //<>//
//Justis Mackaou
//Zachary Richardson
//Declan Kelly
boolean gameOver=false, livesVisible;
Human character; //<>// //<>// //<>//
ArrayList<Bat> biteys = new ArrayList<Bat>();
Animation anim;
Map map;
ArrayList<Projectile> bullets = new ArrayList<Projectile>();
PVector start;
int x = 0, numBats=5, livesSize=0;
void setup() {
  size(1210, 610);
  start = new PVector(0, (int) random(0, 10));
  map = new Map(width, height, start);
  character = new Human(Map.WALL_WIDTH_PX + 15, Map.WALL_WIDTH_PX + 10 + (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) * start.y, 1);


  for (int i=0; i<numBats; i++)
  {
    biteys.add(new Bat(.25));
  }


  anim = new Animation();
  frameRate(60);
}

void draw() {
  //685
  if (frameCount < .685) {
    anim.draw();
  } else if (!gameOver) {
    background(map.getBackground());

    if (livesVisible)
    {
      pushStyle();
      pushMatrix();
      translate(character.bound.anchor.x, character.bound.anchor.y);
      if (livesSize<50)
        scale(livesSize);
      else
        scale(101-livesSize);
      fill(200, 50, 10);
      textSize(10);
      text(character.lives+" lives left!", 0, 0);
      popMatrix();
      popStyle();
      livesSize++;
      if (livesSize>100)
        livesVisible=false;
    }

    character.update();
    handleCollisions(character, map.query(character.bound));
    character.draw();

    for (int i=0; i<biteys.size(); i++)
    {
      Bat b=biteys.get(i);
      b.update();
      handleCollisions(character, b, i);
      b.draw();
    }

    for (int i=0; i<bullets.size(); i++)
    {
      Projectile b=bullets.get(i);
      b.update();
      for (int j=0; j<biteys.size(); j++)
      {
        Bat bt=biteys.get(j);
        handleCollisions(bt, b, j, i);
      }
      b.draw();
    }
  } else {
    background(255, 0, 0);
    color c=color(random(255), random(255), random(255));
    fill(c);
    textSize(50);
    text("GAME OVER", 200, height/2);
    if(frameCount%60==0)
    c=color(random(255), random(255), random(255));
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

void handleCollisions(Human chr, Bat bt, int batIndex) {
  pushStyle();
  if (bt.bound.intersects(chr.bound)) {
    biteys.set(batIndex, new Bat(.25));
    character.lives--;

    livesVisible=true;
    livesSize=1;

    if (character.lives<=0)
      gameOver=true;
  }
  popStyle();
}

void handleCollisions(Bat bt, Projectile bl, int batIndex, int bulIndex) {
  pushStyle();
  if (bt.bound.intersects(bl.bound) && bullets.get(bulIndex).bound.width!=0) {

    biteys.set(batIndex, new Bat(.25));
    bullets.get(bulIndex).bound.width = 0;
    bullets.get(bulIndex).bound.height = 0;
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
  case 81: //q
    bullets.add(new Projectile());
    break;
  }
}


float implCir(float cx, float cy, float r, float x, float y) {
  return (x-cx)*(x-cx)+(y-cy)*(y-cy)-r*r;
}