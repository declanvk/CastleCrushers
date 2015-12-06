public class Heart {
  public static final float SCALE = 0.015;
  public static final float SCALE_INC = 0.005;

  private int[][] black = new int[9][0];
  {
    black[0] = new int[]{2, 3, 5, 6};
    black[1] = new int[]{1, 4, 7};
    black[2] = new int[]{0, 8};
    black[3] = new int[]{0, 8};
    black[4] = new int[]{0, 8};
    black[5] = new int[]{1, 7};
    black[6] = new int[]{2, 6};
    black[7] = new int[]{3, 5};
    black[8] = new int[]{4};
  }
  
  private int[][] red = new int[9][0];
  {
    red[0] = new int[]{};
    red[1] = new int[]{2, 3, 5, 6};
    red[2] = new int[]{1, 3, 4, 5, 6, 7};
    red[3] = new int[]{1, 2, 3, 4, 5, 6, 7};
    red[4] = new int[]{2, 3, 4, 5, 6};
    red[5] = new int[]{3, 4, 5};
    red[6] = new int[]{4};
    red[7] = new int[]{};
    red[8] = new int[]{};
  }
  
  private int[][] darkRed = new int[9][0];
  {
    darkRed[0] = new int[]{};
    darkRed[1] = new int[]{};
    darkRed[2] = new int[]{};
    darkRed[3] = new int[]{};
    darkRed[4] = new int[]{1, 7};
    darkRed[5] = new int[]{2, 6};
    darkRed[6] = new int[]{3, 5};
    darkRed[7] = new int[]{4};
    darkRed[8] = new int[]{};
  }

  public void draw(PVector pos, float scale) {
    pushStyle();
    pushMatrix();
    translate(pos.x, pos.y);
    scale(scale);
    noStroke();
    fill(0);
    for(int i = 0; i < black.length; i++)
      for(int j = 0; j < black[i].length; j++)
        rect(black[i][j] * 100, i * 100,  100, 100);
    
    fill(color(245, 0, 0));
    for(int i = 0; i < red.length; i++)
      for(int j = 0; j < red[i].length; j++)
        rect(red[i][j] * 100, i * 100,  100, 100);
        
    fill(color(80, 0, 0));
    for(int i = 0; i < darkRed.length; i++)
      for(int j = 0; j < darkRed[i].length; j++)
        rect(darkRed[i][j] * 100, i * 100,  100, 100);
        
    fill(255);
    rect(200, 200, 100, 100);
    popMatrix();
    popStyle();
  }
}