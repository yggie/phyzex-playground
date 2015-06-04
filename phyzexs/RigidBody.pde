class RigidBody {
  private final Geometry geometry;
  
  private final PVector pos;
  private final PVector vel;
  
  RigidBody(Geometry geometry, PVector pos, PVector vel) {
    this.geometry = geometry;
    this.pos = pos;
    this.vel = vel;
  }
  
  PVector pos() {
    return this.pos;
  }
  
  Geometry geometry() {
    return this.geometry;
  }
}
