interface Integrator {
  void update(RigidBody body, float step);
}

class SemiImplicitEuler implements Integrator {
  SemiImplicitEuler() {
    // do nothing
  }
  
  void update(RigidBody body, float step) {
    body.pos.add(PVector.mult(body.vel, step));
    Quat w = new Quat(0, body.angVel.x * step, body.angVel.y * step, body.angVel.z * step);
    body.rot.add(w.mult(body.rot).mult(0.5)).normalize();
  }
}
