private final boolean DEBUG = false;

class Map {
  private final int CELL_HEIGHT_PX = 50;
  private final int WALL_WIDTH_PX = 10;


  private final PImage woodTile, stoneTile;

  private final int width, height;
  private final PGraphics floor, walls;
  private final PGraphics maze;
  private final PGraphics output;

  private final PImage background;

  private int[] mazeColumn;
  private int setNumber;

  private final LinkedNode root;
  private final Grid grid;

  Map(int w, int h) {
    this.woodTile = loadImage("wood_floor.png");
    this.stoneTile = loadImage("stone_wall.png");
    this.width = w;
    this.height = h;
    this.floor = generateBackground(woodTile, w, h);
    this.walls = generateBackground(stoneTile, w, h);
    this.output = createGraphics(width, height);

    BoundingBox firstWall = new BoundingBox(new PVector(0, 0), WALL_WIDTH_PX, height);
    this.root = new LinkedNode(null, null, firstWall);

    this.mazeColumn = new int[h / (CELL_HEIGHT_PX + WALL_WIDTH_PX)];
    for (setNumber = 0; setNumber < mazeColumn.length; setNumber++)
      mazeColumn[setNumber] = setNumber + 1;

    this.grid = new Grid(width, height, CELL_HEIGHT_PX + WALL_WIDTH_PX);
    grid.add(firstWall);
    this.maze = generateMaze();

    this.background = generateBackground();
  }

  private PGraphics generateBackground(PImage tile, int w, int h) {
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
    LinkedNode node = root;

    seedColumns(node);
    while (node.next != null)
      node = node.next;

    int i = 0;
    int num = width / 60;
    do {
      mazeColumn = processColumnEllers(node, mazeColumn, new PVector(i * (CELL_HEIGHT_PX + WALL_WIDTH_PX) + WALL_WIDTH_PX, 0), i == num - 1);
      while (node.next != null)
        node = node.next;
      i++;
    } while (i < num);

    drawMaze(root, maze, fullAlpha);
    return maze;
  }

  private void seedColumns(LinkedNode node) {
    for (int y = WALL_WIDTH_PX + CELL_HEIGHT_PX; y < height; y += WALL_WIDTH_PX + CELL_HEIGHT_PX) {
      for (int x = WALL_WIDTH_PX + CELL_HEIGHT_PX; x < width; x += WALL_WIDTH_PX + CELL_HEIGHT_PX) {
        node = addBox(new PVector(x, y), WALL_WIDTH_PX, WALL_WIDTH_PX, node);
      }
    }
  }

  private int[] processColumnEllers(LinkedNode prev, int[] column, PVector start, boolean end) {
    LinkedNode node = prev;
    node = addBox(new PVector(start.x, 0), CELL_HEIGHT_PX + WALL_WIDTH_PX, WALL_WIDTH_PX, node);
    node = addBox(new PVector(start.x, height - WALL_WIDTH_PX), CELL_HEIGHT_PX + WALL_WIDTH_PX, WALL_WIDTH_PX, node);

    //Union sets
    for (int i = 0; i < column.length - 1; i++) {
      if (column[i] != column[i + 1] && random(1) > 0.5) {
        int val = column[i + 1];
        int a = 1;
        while (i + a < column.length) {
          if (column[i + a] == val)
            column[i + a] = column[i];
          a++;
        }
      } else if (!end || (end && column[i] == column[i + 1])) {//draw wall
        node = addBox(new PVector(start.x, (i + 1) * (CELL_HEIGHT_PX + WALL_WIDTH_PX)), WALL_WIDTH_PX + CELL_HEIGHT_PX - 10, WALL_WIDTH_PX, node);
      }
    }

    int[] nextColumn = new int[column.length];
    //Decide which parts of each set continue to next row and add walls where it does not
    //TODO make sure each set gets at least one
    boolean[] transfer = determineContinue(column);
    for (int i = 0; i < column.length; i++) {
      if (transfer[i] && !end)
        nextColumn[i] = column[i];
      else {
        node = addBox(new PVector(start.x + 0 + CELL_HEIGHT_PX, i * (WALL_WIDTH_PX + CELL_HEIGHT_PX) + 10), WALL_WIDTH_PX, (WALL_WIDTH_PX + CELL_HEIGHT_PX) + -10, node);
      }
    }

    for (int i = 0; i < nextColumn.length; i++)
      if (nextColumn[i] == 0)
        nextColumn[i] = setNumber++;
    return nextColumn;
  }

  private boolean[] determineContinue(int[] col) {
    boolean[] res = new boolean[col.length];

    if (DEBUG) {
      //print array
      print("{");
      for (int i = 0; i < res.length; i++)
        print((col[i] >= 10 ? col[i] : " " + col[i]) + (i == res.length - 1 ? "}\n" : ", "));
    }

    int start = 0, val = 0, end = 0, j = 0;
    for (int i = 0; i < res.length; i++) {
      j = 0;
      start = i;
      val = col[start];
      while (start + j < res.length && col[start + j] == val) {
        end = start + j;
        j++;
      }

      int lim = 1 + round(abs(randomGaussian()));

      if (DEBUG && lim > 1)
        println(lim);

      for (int k = 0; k < lim; k++)
        res[(int) random(start, end)] = true;

      i = end;
    }

    if (DEBUG) {
      //print array
      print("{");
      for (int i = 0; i < res.length; i++)
        print((res[i] ? " t" : " f") + (i == res.length - 1 ? "}\n" : ", "));
    }


    return res;
  }

  private LinkedNode addBox(PVector p, int w, int h, LinkedNode prev) {
    BoundingBox box = new BoundingBox(p, w, h);
    LinkedNode next = new LinkedNode(prev, null, box);
    prev.next = next;

    grid.add(box);

    return next;
  }

  private void drawMaze(LinkedNode start, PGraphics pg, color c) {
    LinkedNode node = start;
    while (node != null) {
      node.content.draw(pg, c);
      node = node.next;
    }
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
}

class LinkedNode {
  LinkedNode prev, next;

  final BoundingBox content;

  LinkedNode(LinkedNode p, LinkedNode n, BoundingBox b) {
    this.prev = p;
    this.next = n;
    this.content = b;
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
    for(int i = 0; i < axes.length; i++) {
      distOnAxis[i] = axes[i].copy().mult(dist.dot(axes[i]));
      distOnAxis[i] = distOnAxis[i].add(new PVector(thisHalfAxis.x * axes[i].x, thisHalfAxis.y * axes[i].y));
      distOnAxis[i] = distOnAxis[i].add(new PVector(bHalfAxis.x * axes[i].x, bHalfAxis.y * axes[i].y));
    }
    

    PVector res = distOnAxis[0];
    for(PVector v: distOnAxis)
      if(v.magSq() < res.magSq())
        res = v;
    return res.mult(-1);
  }

  void shift(float dx, float dy) {
    this.anchor.x += dx;
    this.anchor.y += dy;
  }
}