public class Key {
  final BoundingBox bound;
  private final float SCALE = 0.25;

  Key(float x, float y) {
    this.bound = new BoundingBox(new PVector(x, y), (int)(60 * SCALE), (int)(160 * SCALE));
  }

  public void draw() {
    pushStyle();
    noStroke();
    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    scale(SCALE);
    translate(30, 105);
    rectMode(CENTER);
    fill(255, 207, 64); //gold color
    rect(0, 0, 14, 100);
    rectMode(CORNER);
    rect(7, 42, 20, 7);
    rect(7, 30, 14, 6);
    rect(7, 16, 20, 7);
    for (int i=0; i<=550; i++) {
      float x, y;
      x=24*cos(i/4)*cos(radians(i));
      y=24*cos(i/4)*sin(radians(i));
      ellipse(x, y-75, 2, 2);
    }
    popMatrix();
    popStyle();
  }
}