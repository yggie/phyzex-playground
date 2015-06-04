
final int CUBE = 0;

interface Geometry {
  int type();
}

class Cube implements Geometry {
  final float width;
  final float height;
  final float depth;
  
  Cube(final float width, final float height, final float depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;
  }
  
  int type() {
    return CUBE;
  }
}

