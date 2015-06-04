import peasy.*;

PeasyCam camera;
World world;

final float[] SPEEDS = new float[] { 0.01, 0.03, 0.1, 0.3, 1 };
int speedLevel = 2;

void setup() {
  size(640, 480, P3D);
  
  camera = new PeasyCam(this, 200);
  camera.setMinimumDistance(60);
  camera.setMaximumDistance(1000);
  
  reset();
}

void reset() {
  world = new World(new SemiImplicitEuler());
  
  world.add(new RigidBody(new Cube(1, 1, 1), new PVector(-3, 0, 0), new PVector(1, 0, 0)));
  world.add(new RigidBody(new Cube(1, 1, 1), new PVector(3, 0, 0), new PVector(-1, 0, 0)));
}

void draw() {
  background(0);
  
  world.update(SPEEDS[speedLevel]);
  
  final float magnification = 20;
  strokeWeight(1 / magnification);
  scale(magnification);
  
  final RigidBody[] bodies = world.bodies();
  final int length = bodies.length;
  for (int i = 0; i < length; i++) {
    final RigidBody body = bodies[i];
    
    pushMatrix();
      translate(body.pos().x, body.pos().y, body.pos().z);
      
      final Geometry geometry = body.geometry();
      switch (geometry.type()) {
        case CUBE:
          Cube cube = (Cube)geometry;
          box(cube.width, cube.height, cube.depth);
          break;
          
        default:
          println("GEOMETRY NOT RECOGNIZED!!!");
          break;
      }
    popMatrix();
  }
}

void keyPressed(KeyEvent event) {
  switch (event.getKeyCode()) {
    case 82: // "r" key
      reset();
      break;
      
    case 38: // up arrow key
      speedLevel = (speedLevel < SPEEDS.length - 1) ? speedLevel + 1 : speedLevel;
      break;
      
    case 40: // down arrow key
      speedLevel = (speedLevel > 0) ? speedLevel - 1 : 0;
      break;
    
    default:
      println("Uncaught key event:", event.getKeyCode(), "\"" + event.getKey() + "\"");
      break;
  }
}
