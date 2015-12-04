public class Key {
  PVector pos;
  float szk;

  Key(float x, float y, float sz) {
    this.pos.x=x;
    this.pos.y = y;
    this.szk = sz;
  }

  public void drawKey() {
    pushStyle();
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y);
    scale(szk);
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