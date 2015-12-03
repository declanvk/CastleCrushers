public class Projectile {

  private int x, y, speedX;
  private boolean visible;

  public Projectile(int startX, int startY) {
    x = startX;
    y = startY;
    speedX = 7;
    visible = true;
  }

  public void update() {

    x += speedX;
    if (x > 800) {
      visible = false;
    }
  }


  public int getSpeedX() {
    return speedX;
  }

  public boolean isVisible() {
    return visible;
  }


  public void setSpeedX(int speedX) {
    this.speedX = speedX;
  }

  public void setVisible(boolean visible) {
    this.visible = visible;
  }
}