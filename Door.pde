public class Door {
  final BoundingBox bound;
  private final float SCALE = 1;

  Door(float x, float y) {
    this.bound = new BoundingBox(new PVector(x, y), (int)(60 * SCALE), (int)(160 * SCALE));
    // PERSON WHO KNOWS BOUNDING ADJUST THIS FOR DOOR (SET FOR KEY CURRENTLY)
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    translate(bound.anchor.x, bound.anchor.y);
    fill(200, 20, 20);
    strokeWeight(2);
    stroke(#A28852);
    translate(width/2, height/2);
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