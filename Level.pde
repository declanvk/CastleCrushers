import java.util.ListIterator;

public PVector columnRowToXY(PVector rc, int wallWidth, int cellSide) {
  float x = wallWidth + rc.x * (cellSide + wallWidth);
  float y = wallWidth + rc.y * (cellSide + wallWidth);
  return new PVector(x, y);
}

public PVector xyToColumnRow(PVector xy, int wallWidth, int cellSide) {
  float y = ((xy.y - wallWidth) / (cellSide + wallWidth));
  float x = ((xy.x - wallWidth) / (cellSide + wallWidth));
  return new PVector(x, y);
}

public class Level {
  private final int NUM_KEYS = 3;
  private final int LIVES_POP_MULT = 5;
  private final int LIVES_POP_DURATION = 2;

  private final int height, width;
  private final PVector startPos;
  //TODO change
  public final Map map;
  private final Grid grid;

  final Human character;
  private final ArrayList<Bat> bats;
  private final ArrayList<Projectile> projectiles;

  private final ArrayList<Key> keys;
  private int numKeysCollected;

  private final ArrayList<Heart> lives;
  private float livesScaleInc = 0.0;

  private boolean gameOver = false;
  private boolean levelOver = false;

  Level(PVector start, int h, int w) {
    this.startPos = start;
    this.height = h;
    this.width = w;
    this.grid = new Grid(h, w, Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX);
    this.map = new Map(h, w, startPos, grid);
    this.character = new Human(Map.WALL_WIDTH_PX + 15, Map.WALL_WIDTH_PX + 10 + (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) * start.y, 1);
    this.bats = new ArrayList<Bat>();
    this.projectiles = new ArrayList<Projectile>();
    this.keys = new ArrayList<Key>(NUM_KEYS);
    this.numKeysCollected = 0;
    this.lives = new ArrayList<Heart>(5);

    initLives(5, lives);
    spawnBats(5, bats);
    spawnKeys(NUM_KEYS, keys);
  }

  private void initLives(int numLives, ArrayList<Heart> lives) {
    for (int i = 0; i < numLives; i++)
      lives.add(new Heart());
  }

  private void spawnKeys(int numKeys, ArrayList<Key> keys) {
    int x, y;
    for (int i = 0; i < numKeys; i++) {
      y = ((int) random(0, this.width / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX))) * ((Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX)) + Map.WALL_WIDTH_PX + 5;
      x = ((int) random(0, this.height / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX))) * ((Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX)) + Map.WALL_WIDTH_PX + 12;
      keys.add(new Key(x, y));
    }
  }

  private void spawnBats(int numBats, ArrayList<Bat> bats) {
    for (int i=0; i < numBats; i++) {
      bats.add(new Bat(character));
    }
  }

  public void addProjectile() {
    projectiles.add(new Projectile(character));
  }

  public void update() {
    character.update();
    for (Bat b : bats)
      b.update(character.bound.anchor);

    for (Projectile p : projectiles)
      p.update();
  }

  public void draw() {
    character.draw();

    for (Bat b : bats)
      b.draw();

    for (Projectile p : projectiles)
      p.draw();

    for (Key k : keys)
      k.draw();

    for (float i = 0; i < lives.size(); i++)
      lives.get((int) i).draw(PVector.add(character.bound.anchor, new PVector((i - (lives.size() / 2)) * 15, -10)), Heart.SCALE + livesScaleInc);
    if(livesScaleInc > 0)
      livesScaleInc -= (Heart.SCALE_INC / LIVES_POP_DURATION);
  }

  public void handleCollisions() {
    for (BoundingBox b : grid.getColliding(character.bound)) {
      if (b.intersects(character.bound)) {
        PVector proj = b.overlap(character.bound);
        character.bound.shift(proj.x, proj.y);
      }
    }

    for (Bat bt : bats) {
      for (BoundingBox b : grid.getColliding(bt.bound)) {
        if (b.intersects(bt.bound)) {
          PVector proj = b.overlap(bt.bound);
          bt.bound.shift(proj.x, proj.y);
        }
      }
    }

    ListIterator<Bat> bIter = bats.listIterator();
    while (bIter.hasNext()) {
      Bat b = bIter.next();
      if (b.bound.intersects(character.bound)) {
        bIter.remove();
        bIter.add(new Bat(character));
        if (lives.size() > 0) {
          lives.remove(0);
          livesScaleInc = Heart.SCALE_INC * LIVES_POP_MULT;
        }

        if (lives.size() <= 0)
          gameOver = true;
      }
    }

    boolean hit = false;
    for (int j = 0; j < projectiles.size(); j++) {
      hit = false;
      for (int i = 0; i < bats.size(); i++) {
        if (bats.get(i).bound.intersects(projectiles.get(j).bound)) {
          bats.set(i, new Bat(character));

          hit |= true;
        }
      }
      if (hit)
        projectiles.remove(j);
    }

    ListIterator<Key> iter = keys.listIterator();
    while (iter.hasNext()) {
      Key k = iter.next();
      if (k.bound.intersects(character.bound)) {
        numKeysCollected++;
        iter.remove();
      }
    }
  }

  public PImage getBackground() {
    return map.getBackground();
  }

  public boolean isGameOver() {
    return gameOver;
  }

  public boolean isLevelOver() {
    return levelOver;
  }
}