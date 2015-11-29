private final boolean DEBUG = false;

class Map {
  private final int CELL_HEIGHT_PX = 50;
  private final int WALL_WIDTH_PX = 10;


  private final PImage woodTile, stoneTile;

  private final int width, height;
  private final PGraphics floor, walls;
  private final PGraphics maze;

  private int[] mazeColumn;
  private int setNumber;

  private final LinkedNode root;

  Map(int w, int h) {
    woodTile = loadImage("wood_floor.png");
    stoneTile = loadImage("stone_wall.png");
    this.width = w;
    this.height = h;
    this.floor = generateBackground(woodTile, w, h);
    this.walls = generateBackground(stoneTile, w, h);

    BoundingBox firstWall = new BoundingBox(new Point(0, 0), WALL_WIDTH_PX, height, null, null);
    this.root = new LinkedNode(null, null, firstWall);
    firstWall.links = root;

    this.mazeColumn = new int[h / (CELL_HEIGHT_PX + WALL_WIDTH_PX)];
    for (setNumber = 0; setNumber < mazeColumn.length; setNumber++)
      mazeColumn[setNumber] = setNumber + 1;

    this.maze = generateMaze();
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
    do {
      mazeColumn = processColumn(node, mazeColumn, new Point(i * (CELL_HEIGHT_PX + WALL_WIDTH_PX) + WALL_WIDTH_PX, 0), i == 9);
      while (node.next != null)
        node = node.next;
      i++;
    } while (i < 10);
    
    drawMaze(root, maze, fullAlpha);
    return maze;
  }

  private void seedColumns(LinkedNode node) {
    for (int y = WALL_WIDTH_PX + CELL_HEIGHT_PX; y < height; y += WALL_WIDTH_PX + CELL_HEIGHT_PX) {
      for (int x = WALL_WIDTH_PX + CELL_HEIGHT_PX; x < width; x += WALL_WIDTH_PX + CELL_HEIGHT_PX) {
        newBox(new Point(x, y), WALL_WIDTH_PX, WALL_WIDTH_PX, node);
        node = node.next;
      }
    }
  }

  private int[] processColumn(LinkedNode prev, int[] column, Point start, boolean end) {
    LinkedNode node = prev;
    newBox(new Point(start.x, 0), CELL_HEIGHT_PX + WALL_WIDTH_PX, WALL_WIDTH_PX, node);
    node = node.next;
    newBox(new Point(start.x, height - WALL_WIDTH_PX), CELL_HEIGHT_PX + WALL_WIDTH_PX, WALL_WIDTH_PX, node);
    node = node.next;

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
        newBox(new Point(start.x, (i + 1) * (CELL_HEIGHT_PX + WALL_WIDTH_PX)), WALL_WIDTH_PX + CELL_HEIGHT_PX - 10, WALL_WIDTH_PX, node);
        node = node.next;
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
        newBox(new Point(start.x + 0 + CELL_HEIGHT_PX, i * (WALL_WIDTH_PX + CELL_HEIGHT_PX) + 10), WALL_WIDTH_PX, (WALL_WIDTH_PX + CELL_HEIGHT_PX) + -10, node);
        node = node.next;
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
      
      if(DEBUG && lim > 1)
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

  private BoundingBox newBox(Point p, int w, int h, LinkedNode prev) {
    BoundingBox wall = new BoundingBox(p, w, h, null, null);
    LinkedNode next = new LinkedNode(prev, null, wall);
    prev.next = next;
    wall.links = root;

    return wall;
  }

  private void drawMaze(LinkedNode start, PGraphics pg, color c) {
    LinkedNode node = start;
    while (node != null) {
      node.content.draw(pg, c);
      node = node.next;
    }
  }

  PImage getBackground() {
    PGraphics output = createGraphics(width, height);
    output.beginDraw();
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

class QuadNode {
  final Point anchor;
  final int width, height;
  QuadNode parent, q1, q2, q3, q4;

  final BoundingBox content;

  QuadNode(Point p, int w, int h, BoundingBox b, QuadNode par, QuadNode q1, QuadNode q2, QuadNode q3, QuadNode q4) {
    this.anchor = p;
    this.width = w;
    this.height = h;
    this.parent = par;
    this.q1 = q1;
    this.q2 = q2;
    this.q3 = q3;
    this.q4 = q4;
    this.content = b;
  }
}

public class BoundingBox {

  //Upper left corner point
  Point anchor;
  int width, height;
  LinkedNode links;
  QuadNode bound;

  BoundingBox(Point p, int w, int h, LinkedNode l, QuadNode q) {
    this.anchor = new Point(p.x, p.y);
    this.width = w;
    this.height = h;
    this.links = l;
    this.bound = q;
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
}

public class Point {
  final float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}