import java.util.ArrayList;

class QuadNode {

  final int QT_NODE_CAPACITY = 4;

  ArrayList<BoundingBox> containers = new ArrayList<BoundingBox>(QT_NODE_CAPACITY);

  BoundingBox boundary;

  QuadNode q1, q2, q3, q4;

  QuadNode(BoundingBox bound) {
    this.boundary = bound;
  }

  public boolean insert(BoundingBox b) {
    if (!boundary.contains(b))
      return false;

    if (containers.size() < QT_NODE_CAPACITY) {
      containers.add(b);
      return true;
    }

    if (q1 == null)
      subdivide();

    if (q1.insert(b)) return true;
    if (q2.insert(b)) return true;
    if (q3.insert(b)) return true;
    if (q4.insert(b)) return true;

    return false;
  }
  
  public ArrayList<BoundingBox> query(BoundingBox range) {
    ArrayList<BoundingBox> boxesInRange = new ArrayList<BoundingBox>();
    
    if(!boundary.intersection(range))
      return boxesInRange;
      
    for(BoundingBox b: containers) {
      if (range.contains(b))
        boxesInRange.add(b);
    }
    
    if (q1 == null)
      return boxesInRange;
      
    boxesInRange.addAll(q1.query(range));
    boxesInRange.addAll(q2.query(range));
    boxesInRange.addAll(q3.query(range));
    boxesInRange.addAll(q4.query(range));
    
    return boxesInRange;
  }

  private void subdivide() {
    Point p = this.boundary.anchor;
    int w = this.boundary.width / 2, h = this.boundary.height / 2;
    q1 = new QuadNode(new BoundingBox(new Point(p.x + w, p.y), w, h));
    q2 = new QuadNode(new BoundingBox(new Point(p.x, p.y), w, h));
    q3 = new QuadNode(new BoundingBox(new Point(p.x, p.y + h), w, h));
    q4 = new QuadNode(new BoundingBox(new Point(p.x + w, p.y + h), w, h));
  }
}