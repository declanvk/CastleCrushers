class Map {
  private final PImage woodTile;

  private final int width, height;
  private final PGraphics background;

  Map(int w, int h) {
    woodTile = loadImage("wood_floor.png");
    this.width = w;
    this.height = h;
    this.background = generateBackground(woodTile, w, h);
  }

  private PGraphics generateBackground(PImage tile, int w, int h) {
    PGraphics pg = createGraphics(w, h);
    int numX = w % tile.width == 0 ? w / tile.width : (w / tile.width) + 1;
    int numY = h % tile.height == 0 ? h / tile.height : (h / tile.height) + 1;
    pg.beginDraw();
    for (int y = 0; y < numY; y++) {
      for (int x = 0; x < numX; x++) {
        if(pg != null)
          pg.image(tile, x * tile.width, y * tile.width);
      }
    }
    pg.endDraw();

    return pg;
  }

  PImage getBackground() {
    return background;
  }
}