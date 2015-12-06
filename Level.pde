import java.util.ListIterator;

public PVector crToXY(PVector rc) {
  float x = Map.WALL_WIDTH_PX + rc.x * (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX);
  float y = Map.WALL_WIDTH_PX + rc.y * (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX);
  return new PVector((int) x, (int) y);
}

public PVector xyToCR(PVector xy) {
  int y = (int) ((xy.y) / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX));
  int x = (int) ((xy.x) / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX));
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

  private final HashMap<Bat, ArrayList<PVector>> routes;

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
    this.routes = new HashMap<Bat, ArrayList<PVector>>();

    initLives(5, lives);
    spawnBats(5, bats, routes, character, map);
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

  private void spawnBats(int numBats, ArrayList<Bat> bats, HashMap<Bat, ArrayList<PVector>> r, Human c, Map m) {
    for (int i=0; i < numBats; i++) {
      bats.add(new Bat(character));
    }

    for (Bat b : bats)
      r.put(b, m.astar(
        xyToCR(b.bound.anchor), 
        xyToCR(c.bound.anchor), 
        m.adjacency)
        );
  }

  public void addProjectile() {
    projectiles.add(new Projectile(character));
  }

  public void update() {
    character.update();

    for (Bat b : bats)
      if (!routes.get(b).contains(xyToCR(character.bound.anchor)))
        routes.put(b, map.astar( xyToCR(b.bound.anchor), xyToCR(character.bound.anchor), map.adjacency));

    ArrayList<PVector> path;
    PVector target, centering = new PVector(0, 0);
    for (Bat b : bats) {
      path = routes.get(b);
      int i = path.indexOf(xyToCR(b.bound.anchor));
      if (i > 0)
        target = crToXY(path.get(i - 1));
      else
        target = character.bound.anchor;
      b.update(PVector.add(centering, target));
    }

    for (Projectile p : projectiles)
      p.update();
  }

  public void paintRoutes() {
    PVector centering = new PVector(25, 25);
    pushStyle();
    strokeWeight(2);
    ArrayList<PVector> path;
    for (Bat b : bats) {
      path = routes.get(b);
      PVector prev = PVector.add(crToXY(path.get(0)), centering), current;
      for (int i = 1; i < path.size(); i++) {
        current = PVector.add(centering, crToXY(path.get(i)));
        line(prev.x, prev.y, current.x, current.y);
        prev = current;
      }
    }
    popStyle();
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
    if (livesScaleInc > 0)
      livesScaleInc -= (Heart.SCALE_INC / LIVES_POP_DURATION);
  }

  public void handleCollisions() {
    //Character wall intersection
    for (BoundingBox b : grid.getColliding(character.bound)) {
      if (b.intersects(character.bound)) {
        PVector proj = b.overlap(character.bound);
        character.bound.shift(proj.x, proj.y);
      }
    }

    //Bat wall intersection
    for (Bat bt : bats) {
      for (BoundingBox b : grid.getColliding(bt.bound)) {
        if (b.intersects(bt.bound)) {
          PVector proj = b.overlap(bt.bound);
          bt.bound.shift(proj.x, proj.y);
        }
      }
    }

    //Player bat intersection
    ListIterator<Bat> bIter = bats.listIterator();
    while (bIter.hasNext()) {
      Bat b = bIter.next();
      if (b.bound.intersects(character.bound)) {
        routes.remove(b);
        bIter.remove();

        Bat newBat = new Bat(character);
        bIter.add(newBat);
        routes.put(newBat, map.astar(xyToCR(newBat.bound.anchor), xyToCR(character.bound.anchor), map.adjacency));

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
          routes.remove(bats.get(i));
          Bat newBat = new Bat(character);
          bats.set(i, newBat);
          routes.put(newBat, map.astar(xyToCR(newBat.bound.anchor), xyToCR(character.bound.anchor), map.adjacency));

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