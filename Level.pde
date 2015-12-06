import java.util.ListIterator;

public class Level {
  private final int NUM_KEYS = 3;

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

    spawnBats(5, bats);
    spawnKeys(NUM_KEYS, keys);
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
        character.lives--;
        bIter.remove();
        bIter.add(new Bat(character));
        livesVisible=true;
        livesSize=1;

        if (character.lives<=0)
          gameOver=true;
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