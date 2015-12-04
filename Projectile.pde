public class Projectile {

  private float x, y, speedX;
  private boolean visible;
  
  public BoundingBox bound;

  public Projectile() {
    this.bound = new BoundingBox(character.bound.anchor,10,5);
    speedX = 4;
    visible = true;
  }
  
  public void draw(){
    pushStyle();
    fill(255,255,0);
    rect(this.bound.anchor.x, this.bound.anchor.y, this.bound.width, this.bound.height);
    popStyle();
  }

  public void update() {
    this.bound.anchor.x += speedX;
    if (this.bound.anchor.x > width+5) {
      this.visible = false;
    }
  }

}