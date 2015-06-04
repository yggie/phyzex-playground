interface Integrator {
  void update(RigidBody body, float step);
}

class SemiImplicitEuler implements Integrator {
  SemiImplicitEuler() {
    // do nothing
  }
  
  void update(RigidBody body, float step) {
    body.pos.add(PVector.mult(body.vel, step));
  }
}
