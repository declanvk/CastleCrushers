public class BoundingBox {
  //Upper left corner point
  PVector anchor;
  int width, height;

  BoundingBox(PVector p, int w, int h) {
    this.anchor = new PVector(p.x, p.y);
    this.width = w;
    this.height = h;
  }

  void draw(PGraphics pg, color c) {
    pg.beginDraw();

    pg.pushStyle();
    pg.noStroke();
    pg.fill(c);

    pg.rect(anchor.x, anchor.y, width, height);
    pg.popStyle();

    pg.endDraw();
  }

  //Intersection of point and box
  boolean contains(PVector p) {
    return (p.x > this.anchor.x && p.x < this.anchor.x + this.width) && (p.y > this.anchor.y && p.y < this.anchor.y + this.height);
  }

  //Box completely contains another box
  boolean contains(BoundingBox b) {
    return this.contains(b.anchor) && this.contains(new PVector(b.anchor.x + b.width, b.anchor.y + b.height));
  }

  //Intersection between two boxes
  boolean intersects(BoundingBox b) {
    return !(b.left() > this.right() || b.right() < this.left() || b.top() > this.bottom() || b.bottom() < this.top());
  }

  float left() {
    return this.anchor.x;
  }

  float right() {
    return this.anchor.x + this.width;
  }

  float top() {
    return this.anchor.y;
  }

  float bottom() {
    return this.anchor.y + this.height;
  }

  PVector center() {
    return new PVector(anchor.x + width / 2, anchor.y + height / 2);
  }

  private final PVector[] axes = {new PVector(1, 0), new PVector(0, 1), new PVector(-1, 0), new PVector(0, -1)};
  PVector overlap(BoundingBox b) {
    PVector dist = b.center().sub(this.center());
    PVector thisHalfAxis = new PVector(this.width / 2, this.height / 2);
    PVector bHalfAxis = new PVector(b.width / 2, b.height / 2);

    PVector[] distOnAxis = new PVector[axes.length];
    for (int i = 0; i < axes.length; i++) {
      distOnAxis[i] = axes[i].copy().mult(dist.dot(axes[i]));
      distOnAxis[i] = distOnAxis[i].add(new PVector(thisHalfAxis.x * axes[i].x, thisHalfAxis.y * axes[i].y));
      distOnAxis[i] = distOnAxis[i].add(new PVector(bHalfAxis.x * axes[i].x, bHalfAxis.y * axes[i].y));
    }


    PVector res = distOnAxis[0];
    for (PVector v : distOnAxis)
      if (v.magSq() <= res.magSq())
        res = v;
    return res.mult(-1);
  }

  void shift(float dx, float dy) {
    this.anchor.x += dx;
    this.anchor.y += dy;
  }
}