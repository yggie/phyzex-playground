import java.util.Collection;
import java.util.UUID;
import java.lang.Exception;

class World {
  private final Integrator integrator;
  private final HashMap<String, RigidBody> registry;
  
  World(Integrator integrator) {
    this.integrator = integrator;
    this.registry = new HashMap();
  }
  
  RigidBody[] bodies() {
    Collection<RigidBody> list = this.registry.values();
    Object[] objects = list.toArray();
    RigidBody[] bodies = new RigidBody[objects.length];
    for (int i = 0; i < objects.length; i++) {
      bodies[i] = (RigidBody)objects[i];
    }
    return bodies;
  }
  
  String add(RigidBody body) {
    // low probability of duplicates, reasonable for throwaway code
    String key = UUID.randomUUID().toString();
    
    if (this.registry.containsKey(key)) {
      println("[ERROR] Ooops, what are the odds, duplicate keys!!!");
    }
    
    this.registry.put(key, body);
    return key;
  }
  
  void update(float step) {
    RigidBody[] bodies = this.bodies();
    final int length = bodies.length;
    
    for (int i = 0; i < length; i++) {
      this.integrator.update(bodies[i], step);
    }
    
    for (int i = 0; i < length; i++) {
      for (int j = i + 1; j < length; j++) {
        final Overlap overlap = this.computeOverlap(bodies[i], bodies[j]);
        
        if (overlap != null) {
          println("Overlap detected!");
        }
      }
    }
  }
  
  Overlap computeOverlap(RigidBody A, RigidBody B) {
    return null;
  }
}
