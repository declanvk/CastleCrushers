public class Level {
  private final int NUM_KEYS = 3;

  private final int height, width;
  private final PVector startPos;
  private final Map map;
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
  }

  private void spawnBats(int numBats, ArrayList<Bat> bats) {
    for (int i=0; i < numBats; i++) {
      bats.add(new Bat(.25, character));
    }
  }
  
  public void addProjectile() {
    projectiles.add(new Projectile(character));
  }

  public void update() {
    character.update();
    for (Bat b : bats)
      b.update();

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

    for (Bat b : bats) {
      if (b.bound.intersects(character.bound)) {
        gameOver = true;
      }
    }

    for (Projectile p : projectiles) {
      for (int i = 0; i < bats.size(); i++) {
        if (bats.get(i).bound.intersects(p.bound)) {
          bats.set(i, new Bat(.25, character));
          p.bound.width = 0;
          p.bound.height = 0;
        }
      }
    }

    for (Key k : keys) {
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