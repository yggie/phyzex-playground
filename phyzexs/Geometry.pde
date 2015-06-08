import java.util.LinkedList;

final int CUBE = 0;

interface Geometry {
  int type();
  LinkedList<PVector> supportPointsFor(PVector dir);
}

class Cube implements Geometry {
  final float halfWidth;
  final float halfHeight;
  final float halfDepth;

  Cube(final float width, final float height, final float depth) {
    this.halfWidth = width / 2;
    this.halfHeight = height / 2;
    this.halfDepth = depth / 2;
  }

  float width() {
    return 2.0 * this.halfWidth;
  }

  float height() {
    return 2.0 * this.halfHeight;
  }

  float depth() {
    return 2.0 * this.halfDepth;
  }

  int type() {
    return CUBE;
  }

  LinkedList<PVector> supportPointsFor(final PVector dir) {
    LinkedList<PVector> list = new LinkedList();

    final float absX = abs(dir.x);
    final float absY = abs(dir.y);
    final float absZ = abs(dir.z);

    if (absX < TOLERANCE && absY < TOLERANCE) {
      final float halfDepth = (dir.z > 0) ? this.halfDepth : -this.halfDepth;

      list.push(new PVector( this.halfWidth,  this.halfHeight, halfDepth));
      list.push(new PVector(-this.halfWidth,  this.halfHeight, halfDepth));
      list.push(new PVector(-this.halfWidth, -this.halfHeight, halfDepth));
      list.push(new PVector( this.halfWidth, -this.halfHeight, halfDepth));
    } else if (absX < TOLERANCE && absZ < TOLERANCE) {
      final float halfHeight = (dir.y > 0) ? this.halfHeight : -this.halfHeight;

      list.push(new PVector( this.halfWidth, halfHeight,  this.halfDepth));
      list.push(new PVector(-this.halfWidth, halfHeight,  this.halfDepth));
      list.push(new PVector(-this.halfWidth, halfHeight, -this.halfDepth));
      list.push(new PVector( this.halfWidth, halfHeight, -this.halfDepth));
    } else if (absY < TOLERANCE && absZ < TOLERANCE) {
      final float halfWidth = (dir.x > 0) ? this.halfWidth : -this.halfWidth;

      list.push(new PVector(halfWidth,  this.halfHeight,  this.halfDepth));
      list.push(new PVector(halfWidth, -this.halfHeight,  this.halfDepth));
      list.push(new PVector(halfWidth, -this.halfHeight, -this.halfDepth));
      list.push(new PVector(halfWidth,  this.halfHeight, -this.halfDepth));
    } else if (absX < TOLERANCE) {
      final float halfHeight = (dir.y > 0) ? this.halfHeight : -this.halfHeight;
      final float halfDepth = (dir.z > 0) ? this.halfDepth : -this.halfDepth;

      list.push(new PVector( this.halfWidth, halfHeight, halfDepth));
      list.push(new PVector(-this.halfWidth, halfHeight, halfDepth));
    } else if (absY < TOLERANCE) {
      final float halfWidth = (dir.x > 0) ? this.halfWidth : -this.halfWidth;
      final float halfDepth = (dir.z > 0) ? this.halfDepth : -this.halfDepth;

      list.push(new PVector(halfWidth,  this.halfHeight, halfDepth));
      list.push(new PVector(halfWidth, -this.halfHeight, halfDepth));
    } else if (absZ < TOLERANCE) {
      final float halfWidth = (dir.x > 0) ? this.halfWidth : -this.halfWidth;
      final float halfHeight = (dir.y > 0) ? this.halfHeight : -this.halfHeight;

      list.push(new PVector(halfWidth, halfHeight,  this.halfDepth));
      list.push(new PVector(halfWidth, halfHeight, -this.halfDepth));
    } else {
      final float halfWidth = (dir.x > 0) ? this.halfWidth : -this.halfWidth;
      final float halfHeight = (dir.y > 0) ? this.halfHeight : -this.halfHeight;
      final float halfDepth = (dir.z > 0) ? this.halfDepth : -this.halfDepth;

      list.push(new PVector(halfWidth, halfHeight, halfDepth));
    }

    return list;
  }
}

