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
  private final int NUM_BATS = 5;
  private final int LIVES_POP_MULT = 5;
  private final int LIVES_POP_DURATION = 2;
  
  private final PFont SCORE_FONT = createFont("TerminusTTF-4.39.ttf", 32);
  private final int SCORE_INC = 100;
  private final int SCORE_DEC = 50;
  
  private final int rows, columns;
  
  private final PVector startPos, endPos;
  //TODO change
  public final Map map;
  private final Grid grid;

  final Human character;
  private final ArrayList<Bat> bats;
  private final ArrayList<Projectile> projectiles;

  private final ArrayList<Key> keys;
  private int numKeysCollected;
  private final Door enterDoor, exitDoor;
  private boolean drawDoor;

  private final ArrayList<Heart> lives;
  private float livesScaleInc = 0.0;

  private final HashMap<Bat, ArrayList<PVector>> routes;
  
  private int score;

  private boolean gameOver = false;
  private boolean levelOver = false;

  Level(PVector start, int l, int s) {
    this.rows = (height - Map.WALL_WIDTH_PX) / (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX);
    this.columns = (width - Map.WALL_WIDTH_PX) / (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX);
    this.startPos = start;
    this.endPos = new PVector(this.columns - 1, (int) random(0, rows));
    this.grid = new Grid(Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX);
    this.map = new Map(startPos, grid);
    this.character = new Human(Map.WALL_WIDTH_PX + 15, Map.WALL_WIDTH_PX + 10 + (Map.WALL_WIDTH_PX + Map.CELL_HEIGHT_PX) * start.y, 1);
    this.bats = new ArrayList<Bat>();
    this.projectiles = new ArrayList<Projectile>();
    this.keys = new ArrayList<Key>(NUM_KEYS);
    this.numKeysCollected = 0;
    this.drawDoor = false;
    this.enterDoor = new Door(PVector.add(new PVector(5, 0), crToXY(startPos)));
    this.exitDoor = new Door(PVector.add(new PVector(5, 0), crToXY(endPos)));
    this.lives = new ArrayList<Heart>(5);
    this.routes = new HashMap<Bat, ArrayList<PVector>>();
    this.score = s;

    initLives(l, lives);
    spawnBats(NUM_BATS, bats, routes, character, map);
    spawnKeys(NUM_KEYS, keys);
  }

  private void initLives(int numLives, ArrayList<Heart> lives) {
    for (int i = 0; i < numLives; i++)
      lives.add(new Heart());
  }

  private void spawnKeys(int numKeys, ArrayList<Key> keys) {
    int x, y;
    for (int i = 0; i < numKeys; i++) {
      x = ((int) random(0, width / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX))) * ((Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX)) + Map.WALL_WIDTH_PX + 15;
      y = ((int) random(0, height / (Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX))) * ((Map.CELL_HEIGHT_PX + Map.WALL_WIDTH_PX)) + Map.WALL_WIDTH_PX + 8;
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
    for (Bat b : bats) {
      path = routes.get(b);
      int i = path.indexOf(xyToCR(b.bound.center()));
      if (i > 0)
        b.update(crToXY(path.get(i - 1)), false);
      else if(i == 0)
        b.update(character.bound.anchor, true);
      else
        b.update(crToXY(path.get(path.size() - 1)), false);
      
    }

    for (Projectile p : projectiles)
      p.update();
  }

  public void draw() {
    enterDoor.draw();
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

    if (drawDoor)
      exitDoor.draw();
      
    drawScore(this.score);
  }
  
  private void drawScore(int score) {
    pushStyle();
    textFont(SCORE_FONT);
    textAlign(RIGHT);
    text(score, width - 10, 30);
    popStyle();
  }

  public void checkWinState() {
    if (numKeysCollected >= NUM_KEYS)
      drawDoor = true;
    if (endPos.equals(xyToCR(character.bound.anchor)))
      levelOver = true;
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
        
        score -= SCORE_DEC;
        if (lives.size() > 0) {
          lives.remove(0);
          livesScaleInc = Heart.SCALE_INC * LIVES_POP_MULT;
        }

        if (lives.size() <= 0)
          gameOver = true;
      }
    }

    //Projectiles hit bats
    boolean hit = false;
    for (int j = 0; j < projectiles.size(); j++) {
      hit = false;
      for (int i = 0; i < bats.size(); i++) {
        if (bats.get(i).bound.intersects(projectiles.get(j).bound)) {
          routes.remove(bats.get(i));
          Bat newBat = new Bat(character);
          bats.set(i, newBat);
          routes.put(newBat, map.astar(xyToCR(newBat.bound.anchor), xyToCR(character.bound.anchor), map.adjacency));
          
          score += SCORE_INC;
          hit |= true;
        }
      }
      if (hit)
        projectiles.remove(j);
    }

    //Projectiles hit walls
    ListIterator<Projectile> pIter = projectiles.listIterator();
    while (pIter.hasNext()) {
      Projectile p = pIter.next();
      for (BoundingBox b : grid.getColliding(p.bound)) {
        if (p.bound.intersects(b)) {
          pIter.remove();
          break;
        }
      }
    }

    //Character hits keys
    ListIterator<Key> kIter = keys.listIterator();
    while (kIter.hasNext()) {
      Key k = kIter.next();
      if (k.bound.intersects(character.bound)) {
        numKeysCollected++;
        kIter.remove();
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

  public int getNumLives() {
    return lives.size();
  }

  public PVector getEndPos() {
    return endPos;
  }
  
  public int getScore() {
    return score;
  }
}