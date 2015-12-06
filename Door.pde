public class Door {
  final BoundingBox bound;
  private final float SCALE = 1;

  Door(PVector p) {
    this.bound = new BoundingBox(p, (int)(40 * SCALE), (int)(50 * SCALE));
  }

  public void draw() {
    pushStyle();
    fill(200, 20, 20);
    strokeWeight(2);
    stroke(#A28852);
    
    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    scale(SCALE, 0.99 * SCALE);
    translate(20, 30);
    beginShape();
    vertex(-20, 20);
    vertex(-20, -20);
    vertex(-10, -30);
    vertex(10, -30);
    vertex(20, -20);
    vertex(20, 20);
    vertex(-20, 20);
    endShape();
    line(0, -30, 0, 20);
    noStroke();
    fill(0);
    ellipse(-5, 0, 5, 5);
    ellipse(5, 0, 5, 5);
    popMatrix();

    popStyle();
  }
}