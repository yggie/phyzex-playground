class Quat {
  float w;
  float x;
  float y;
  float z;

  Quat() {
    this(1, 0, 0, 0);
  }
  
  Quat(Quat quat) {
    this(quat.w, quat.x, quat.y, quat.z);
  }

  Quat(final float w, final float x, final float y, final float z) {
    this.w = w;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Quat add(final Quat q) {
    this.w += q.w;
    this.x += q.x;
    this.y += q.y;
    this.z += q.z;

    return this;
  }

  Quat mult(final Quat q) {
    final float w = this.w*q.w - this.x*q.x - this.y*q.y - this.z*q.z;
    final float x = this.w*q.x + this.x*q.w + this.y*q.z - this.z*q.y;
    final float y = this.w*q.y - this.x*q.z + this.y*q.w + this.z*q.x;
    final float z = this.w*q.z + this.x*q.y - this.y*q.x + this.z*q.w;

    this.w = w;
    this.x = x;
    this.y = y;
    this.z = z;

    return this;
  }

  Quat mult(float scalar) {
    this.w *= scalar;
    this.x *= scalar;
    this.y *= scalar;
    this.z *= scalar;

    return this;
  }

  Quat normalize() {
    final float length = this.length();
    this.w = this.w / length;
    this.x = this.x / length;
    this.y = this.y / length;
    this.z = this.z / length;

    return this;
  }
  
  Quat invert() {
    final float lengthSq = this.lengthSq();
    this.w /=  lengthSq;
    this.x /= -lengthSq;
    this.y /= -lengthSq;
    this.z /= -lengthSq;
    
    return this;
  }
  
  Quat inverse() {
    return new Quat(this).invert();
  }
  
  PVector applyTo(final PVector vect) {
    final Quat qvect = new Quat(0, vect.x, vect.y, vect.z);
    final Quat result = new Quat(this).mult(qvect).mult(this.inverse());
    
    return new PVector(result.x, result.y, result.z);
  }

  float length() {
    return sqrt(this.lengthSq());
  }

  float lengthSq() {
    return this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
  }
}

Quat quatFromAxisAngle(final PVector axis, final float angle) {
  final float halfAngle = 0.5 * angle;
  final float l = axis.mag();
  final float cl = cos(halfAngle) / l;
  final float sl = sin(halfAngle) / l;

  return new Quat(cl, sl * axis.x, sl * axis.y, sl * axis.z);
}
