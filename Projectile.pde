public class Projectile {

  private float speedX;
  private final float SCALE = 3;
  private final float ROT_INC = PI / 36;
  private float ROT = 0;
  private boolean toggle = true;

  public BoundingBox bound;

  public String last;

  public Projectile(Human character) {
    this.bound = new BoundingBox(character.bound.anchor, 10, 10);
    speedX = 4;
    last = character.last;
  }

  public void draw() {
    if (this.last == "RIGHT")
      drawRightLeft(true);
    else if (this.last == "LEFT")
      drawRightLeft(false);
    else if (this.last == "UP")
      drawUpDown(true);
    else if (this.last == "DOWN")
      drawUpDown(false);
  }
  
  public void drawRightLeft(boolean right) {
    pushStyle();
    noStroke();
    fill(255);

    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    scale(SCALE);
    rotate(ROT);
    translate(-5, -5);

    fill(85);
    triangle(3, 6, 5, 0, 5, 6);
    fill(170);
    triangle(5, 6, 5, 0, 7, 6);
    fill(10);
    rect(2, 6, 6, 1);
    rect(4, 6, 2, 4);
    fill(150);
    rect(4, 9, 2, 1);

    popMatrix();
    popStyle();
    ROT += right ? ROT_INC: -ROT_INC;
  }

  public void drawUpDown(boolean up) {
    pushStyle();
    noStroke();

    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    scale(SCALE, ROT);
    translate(-5, -5);

    fill(0);
    rect(4, 5, 2, 5);
    rect(3, 5, 4, 1);
    fill(150);
    rect(4, 8, 2, 2);
    fill(85);
    triangle(4, 5, 6, 5, 5, 0);

    popMatrix();
    popStyle();
    
    if (toggle)
      ROT += up ? ROT_INC : -ROT_INC;
    else
      ROT -= up ? ROT_INC : -ROT_INC;
      
    if ((up && ROT >= SCALE) || (!up && ROT <= -SCALE))
      toggle = false;
    else if ((up && ROT <= -SCALE) || (!up && ROT >= SCALE))
      toggle = true;
  }

  public void update() {
    if (this.last == "RIGHT")
      this.bound.anchor.x += speedX;
    else if (this.last == "LEFT")
      this.bound.anchor.x -= speedX;
    else if (this.last == "UP")
      this.bound.anchor.y -= speedX;
    else if (this.last == "DOWN")
      this.bound.anchor.y += speedX;
  }
}