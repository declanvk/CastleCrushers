public class Human {
  final int MOVESPEED=5;
  public float centerX, centerY, size;
  public boolean movingUp, movingDown, movingRight, movingLeft;
  public PImage img;


  Human(float x, float y, float sz) {
    this.centerX=x;
    this.centerY=y;
    this.size=sz;
  }


  public void setImage() {
  }

  public void draw() {
    ellipse(this.centerX, this.centerY, this.size, this.size);
  }

  public void update() {
    if (movingRight && this.centerX+this.size/2+MOVESPEED<=width)
      this.centerX+=MOVESPEED;
    else if (movingRight)
      this.centerX=width-this.size/2;
    if (movingLeft && this.centerX-this.size/2-MOVESPEED>=0)
      this.centerX-=MOVESPEED;
    else if (movingLeft)
      this.centerX=0+this.size/2;
    if (movingUp && this.centerY-this.size/2-MOVESPEED>=0)
      this.centerY-=MOVESPEED;
    else if (movingUp)
      this.centerY=0+this.size/2;
    if (movingDown && this.centerY+this.size/2+MOVESPEED<=height)
      this.centerY+=MOVESPEED;
    else if (movingDown)
      this.centerY=height-this.size/2;
  }
}

public class Enemy {
  Enemy() {
  }
}