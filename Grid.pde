public class Grid {

  private final BoundingBoxContainer[][] grid;
  private final int rows, cols;
  private final int cellSize;

  public Grid (int mapWidth, int mapHeight, int cellSize) {
    this.cellSize = cellSize;
    this.rows = (mapHeight + cellSize - 1) / cellSize;
    this.cols = (mapWidth + cellSize - 1) / cellSize;
    this.grid = new BoundingBoxContainer[cols][rows];

    for (int x = 0; x < grid.length; x++)
      for (int y = 0; y < grid[x].length; y++)
        grid[x][y] = new BoundingBoxContainer(new ArrayList<BoundingBox>());
  }

  public void clear() {
    for (int x=0; x<cols; x++)
      for (int y=0; y<rows; y++)
        grid[x][y].container.clear();
  }

  public void add(BoundingBox e) {
    int topLeftX = Math.max(0, (int) (e.anchor.x / cellSize));
    int topLeftY = Math.max(0, (int) (e.anchor.y / cellSize));
    int bottomRightX = Math.min(cols-1, (int) ((e.anchor.x + e.width -1) / cellSize));
    int bottomRightY = Math.min(rows-1, (int) ((e.anchor.y + e.height -1) / cellSize));

    for (int x = topLeftX; x <= bottomRightX; x++)
      for (int y = topLeftY; y <= bottomRightY; y++)
        grid[x][y].container.add(e);
  }

  private ArrayList<BoundingBox> queryList = new ArrayList<BoundingBox>();
  public ArrayList<BoundingBox> queryNearby(BoundingBox e) {
    queryList.clear();

    int topLeftX = Math.max(0, (int) (e.anchor.x / cellSize));
    int topLeftY = Math.max(0, (int) (e.anchor.y / cellSize));
    int bottomRightX = Math.min(cols-1, (int) ((e.anchor.x + e.width -1) / cellSize));
    int bottomRightY = Math.min(rows-1, (int) ((e.anchor.y + e.height -1) / cellSize));

    for (int x = topLeftX; x <= bottomRightX; x++)
      for (int y = topLeftY; y <= bottomRightY; y++)
        for (BoundingBox b : grid[x][y].container)
          if (!queryList.contains(b))
            queryList.add(b);

    return queryList;
  }

  private ArrayList<BoundingBox> collidingList = new ArrayList<BoundingBox>();
  public ArrayList<BoundingBox> getColliding(BoundingBox e) {
    collidingList.clear();

    for (BoundingBox b : queryNearby(e))
      if (e.intersects(b))
        collidingList.add(b);

    return collidingList;
  }

  public PImage draw(PGraphics pg) {
    pg.beginDraw();

    for (int x = 0; x < grid.length; x++)
      for (int y = 0; y < grid[x].length; y++)
        for (BoundingBox b : grid[x][y].container)
          b.draw(pg, color(255));

    pg.endDraw();

    return pg;
  }
}

public class BoundingBoxContainer {
  ArrayList<BoundingBox> container;

  BoundingBoxContainer(ArrayList<BoundingBox> bs) {
    this.container = bs;
  }
}