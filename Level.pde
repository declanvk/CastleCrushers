public class Level {
  private final int NUM_KEYS = 3;

  private final int height, width;
  private final PVector startPos;
  private final Map map;
  private final Grid grid;

  private final Human character;
  private final ArrayList<Bat> bats;
  private final ArrayList<Projectile> projectiles;

  private final ArrayList<Key> keys;
  private int numKeysCollected;

  Level(PVector start, int h, int w) {
    this.startPos = start;
    this.height = h;
    this.width = w;
    this.map = new Map(h, w, startPos);
    this.grid = new Grid(h, w, Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX);
    this.character = new Human(Map.WALL_WIDTH_PX + 15, Map.WALL_WIDTH_PX + 10 + (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) * start.y, 1);
    this.bats = new ArrayList<Bat>();
    this.projectiles = new ArrayList<Projectile>();
    this.keys = new ArrayList<Key>(NUM_KEYS);
    this.numKeysCollected = 0;
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
      
    for (Key k: keys)
      k.draw();
  }

  public void handleCollisions() {
    for (BoundingBox b : grid.getColliding(character.bound))
      if (b.intersects(character.bound)) {
        PVector proj = b.overlap(character.bound);
        character.bound.shift(proj.x, proj.y);
      }
  }
}