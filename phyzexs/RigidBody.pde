class RigidBody {
  private final Geometry geometry;
  
  PVector pos;
  PVector vel;
  Quat rot;
  PVector angVel;
  
  RigidBody(Geometry geometry, PVector pos, PVector vel, Quat rot, PVector angVel) {
    this.geometry = geometry;
    this.pos = pos;
    this.vel = vel;
    this.rot = rot;
    this.angVel = angVel;
  }
  
  PVector pos() {
    return this.pos;
  }
  
  Quat rot() {
    return this.rot;
  }
  
  Geometry geometry() {
    return this.geometry;
  }
}
