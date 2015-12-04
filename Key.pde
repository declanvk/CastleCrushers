public class Key {
  private final int HEIGHT_PX = 10, WIDTH_PX = 10;

  BoundingBox bound;

  public Key(PVector p) {
    this.bound = new BoundingBox(p, HEIGHT_PX, WIDTH_PX);
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    rect(0, 0, bound.width, bound.height);
    popMatrix();
    popStyle();
  }
}