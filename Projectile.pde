public class Projectile {

  private float x, y, speedX;
  //private boolean visible;

  public BoundingBox bound;
  
  public String last;

  public Projectile(Human character) {
    this.bound = new BoundingBox(character.bound.anchor, 10, 5);
    speedX = 4;
    last=character.last;
    //visible = true;
  }

  public void draw() {
    pushStyle();
    fill(255, 255, 0);
    rect(this.bound.anchor.x, this.bound.anchor.y, this.bound.width, this.bound.height);
    popStyle();
  }

  public void update() {
    if (this.last=="RIGHT")
      this.bound.anchor.x += speedX;
    else if (this.last=="LEFT")
    this.bound.anchor.x-=speedX;
    else if(this.last=="UP")
    this.bound.anchor.y-=speedX;
    else if(this.last=="DOWN")
    this.bound.anchor.y+=speedX;
  }
}