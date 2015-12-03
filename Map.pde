import java.util.Collections;

private final boolean DEBUG = false;

class Map {
  public static final int CELL_HEIGHT_PX = 50;
  public static final int WALL_WIDTH_PX = 10;


  private final int MAZE_MODE_NEWEST = 0;
  private final int MAZE_MODE_RANDOM = 1;
  private final int MAZE_MODE_OLDEST = 2;

  private final PImage woodTile, stoneTile;

  private final int width, height, rows, columns;
  private final PGraphics floor, walls;
  private final PGraphics maze;
  private final PGraphics output;

  private final PImage background;

  private final ArrayList<BoundingBox> drawList;
  private final Grid grid;
  private final PVector startPos;

  Map(int w, int h, PVector start) {
    this.woodTile = loadImage("wood_floor.png");
    this.stoneTile = loadImage("stone_wall.png");
    this.width = w;
    this.height = h;
    this.rows = h / (CELL_HEIGHT_PX +WALL_WIDTH_PX);
    this.columns = w / (CELL_HEIGHT_PX +WALL_WIDTH_PX);
    this.floor = generateTiling(woodTile, w, h);
    this.walls = generateTiling(stoneTile, w, h);
    this.output = createGraphics(width, height);

    this.drawList = new ArrayList<BoundingBox>();

    this.startPos = start;
    this.grid = new Grid(width, height, CELL_HEIGHT_PX + WALL_WIDTH_PX);
    this.maze = generateMaze();
    
    this.background = generateBackground();
  }

  private PGraphics generateTiling(PImage tile, int w, int h) {
    PGraphics pg = createGraphics(w, h);
    int numX = w % tile.width == 0 ? w / tile.width : (w / tile.width) + 1;
    int numY = h % tile.height == 0 ? h / tile.height : (h / tile.height) + 1;

    pg.beginDraw();
    for (int y = 0; y < numY; y++) {
      for (int x = 0; x < numX; x++) {
        pg.image(tile, x * tile.width, y * tile.width);
      }
    }
    pg.endDraw();

    return pg;
  }

  private PGraphics generateMaze() {
    PGraphics maze = createGraphics(width, height);
    color fullAlpha = color(0, 0, 255);

    seedColumns(drawList);
    addWalls(drawList);
    growingTree(drawList, startPos, MAZE_MODE_RANDOM);

    drawMaze(drawList, maze, fullAlpha);
    return maze;
  }

  private void addWalls(ArrayList<BoundingBox> drawList) {
    addBox(new PVector(0, 0), WALL_WIDTH_PX, this.height, drawList);
    addBox(new PVector(this.width - WALL_WIDTH_PX, 0), WALL_WIDTH_PX, this.height, drawList);
    addBox(new PVector(WALL_WIDTH_PX, 0), this.width - 2 * WALL_WIDTH_PX, WALL_WIDTH_PX, drawList);
    addBox(new PVector(WALL_WIDTH_PX, this.height - WALL_WIDTH_PX), this.width - 2 * WALL_WIDTH_PX, WALL_WIDTH_PX, drawList);
  }

  private void seedColumns(ArrayList<BoundingBox> drawList) {
    for (int y = WALL_WIDTH_PX + CELL_HEIGHT_PX; y < height - WALL_WIDTH_PX; y += WALL_WIDTH_PX + CELL_HEIGHT_PX)
      for (int x = WALL_WIDTH_PX + CELL_HEIGHT_PX; x < width - WALL_WIDTH_PX; x += WALL_WIDTH_PX + CELL_HEIGHT_PX)
        addBox(new PVector(x, y), WALL_WIDTH_PX, WALL_WIDTH_PX, drawList);
  }

  private boolean addBox(PVector p, int w, int h, ArrayList<BoundingBox> drawList) {
    BoundingBox box = new BoundingBox(p, w, h);
    return drawList.add(box) && grid.add(box);
  }

  private void drawMaze(ArrayList<BoundingBox> drawList, PGraphics pg, color c) {
    for (BoundingBox b : drawList)
      b.draw(pg, c);
  }

  public ArrayList<BoundingBox> query(BoundingBox b) {
    return grid.getColliding(b);
  }

  PImage generateBackground() {
    output.beginDraw();
    output.background(255);
    floor.beginDraw();

    if (DEBUG) {
      output.background(255);
      output.image(maze, 0, 0);
    } else {
      output.image(floor, 0, 0);
      walls.mask(maze);
      output.image(walls, 0, 0);
    }

    floor.endDraw();
    output.endDraw();
    return output;
  }

  PImage getBackground() {
    return background;
  }

  private final ArrayList<PVector> directions = new ArrayList<PVector>();
  {
    directions.add(new PVector(1, 0));
    directions.add(new PVector(0, 1)); 
    directions.add(new PVector(-1, 0)); 
    directions.add(new PVector(0, -1));
  }

  private void growingTree(ArrayList<BoundingBox> drawList, PVector start, int mazeMode) {
    boolean[][] horizWalls = new boolean[this.columns][this.rows - 1];
    boolean[][] vertWalls = new boolean[this.columns - 1][this.rows];
    for (int i = 0; i < horizWalls.length; i++)
      for (int j = 0; j < horizWalls[i].length; j++)
        horizWalls[i][j] = true;

    for (int i = 0; i < vertWalls.length; i++)
      for (int j = 0; j < vertWalls[i].length; j++)
        vertWalls[i][j] = true;


    int[][] grid = new int[columns][rows];
    ArrayList<PVector> cells = new ArrayList<PVector>();
    cells.add(start);
    grid[(int) start.x][(int) start.y]++;

    int index;
    PVector current, neighbor;
    while (cells.size() > 0) {
      index = choose(cells.size(), mazeMode);
      current = cells.get(index);

      Collections.shuffle(directions);
      for (PVector direction : directions) {
        neighbor = PVector.add(current, direction);
        if (neighbor.x < 0 || neighbor.y < 0 || neighbor.x >= columns || neighbor.y >= rows)
          continue;
        else if ( grid[(int)neighbor.x][(int)neighbor.y] == 0) {
          grid[(int) neighbor.x][(int) neighbor.y]++;
          cells.add(neighbor);
          index = -1;

          if (direction.x == 1)
            vertWalls[(int) current.x][(int) current.y] = false;
          else if (direction.x == -1)
            vertWalls[(int) neighbor.x][(int) neighbor.y] = false;
          else if (direction.y == 1)
            horizWalls[(int) current.x][(int) current.y] = false;
          else
            horizWalls[(int) neighbor.x][(int) neighbor.y] = false;

          break;
        }
      }
      
      if (index > -1) {
        cells.remove(index);
      }
    }
    
    //Mark farthest
    //addBox(
    //  new PVector(
    //  WALL_WIDTH_PX + maxCell.x*(WALL_WIDTH_PX + CELL_HEIGHT_PX) + (CELL_HEIGHT_PX - WALL_WIDTH_PX) / 2,
    //  WALL_WIDTH_PX + maxCell.y*(WALL_WIDTH_PX + CELL_HEIGHT_PX) + (CELL_HEIGHT_PX - WALL_WIDTH_PX) / 2
    //  ), 
    //  WALL_WIDTH_PX, WALL_WIDTH_PX, drawList);
    
    //Add walls
    for (int x = 0; x < horizWalls.length; x++) {
      for (int y = 0; y < horizWalls[x].length; y++) {
        if (horizWalls[x][y]) {
          addBox(
            new PVector(
            (WALL_WIDTH_PX) + x * (WALL_WIDTH_PX + CELL_HEIGHT_PX), 
            (WALL_WIDTH_PX + CELL_HEIGHT_PX) + y * (WALL_WIDTH_PX + CELL_HEIGHT_PX)
            ), 
            CELL_HEIGHT_PX, 
            WALL_WIDTH_PX, 
            drawList
            );
        }
      }
    }

    for (int x = 0; x < vertWalls.length; x++) {
      for (int y = 0; y < vertWalls[x].length; y++) {
        if (vertWalls[x][y]) {
          addBox(
            new PVector(
            (WALL_WIDTH_PX + CELL_HEIGHT_PX) + x * (WALL_WIDTH_PX + CELL_HEIGHT_PX), 
            (WALL_WIDTH_PX) + y * (WALL_WIDTH_PX + CELL_HEIGHT_PX)
            ), 
            WALL_WIDTH_PX, 
            CELL_HEIGHT_PX, 
            drawList
            );
        }
      }
    }
  }

  private int choose(int length, int mazeMode) {
    switch(mazeMode) {
    case MAZE_MODE_OLDEST:
      return 0;
    case MAZE_MODE_RANDOM:
      return (int) random(length);
    case MAZE_MODE_NEWEST:
      return length - 1;
    default:
      return -1;
    }
  }
}

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
    if (DEBUG) {
      pg.noFill();
    } else {
      pg.noStroke();
      pg.fill(c);
    }

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