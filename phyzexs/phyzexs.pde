import peasy.*;

PeasyCam camera;
World world;

final float TOLERANCE = 1e-6;

final float[] SPEEDS = new float[] { 0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1 };
int speedLevel = 4;

void setup() {
  size(640, 480, P3D);

  camera = new PeasyCam(this, 200);
  camera.setMinimumDistance(60);
  camera.setMaximumDistance(1000);

  reset();
}

void reset() {
  world = new World(new SemiImplicitEuler());

  world.add(new RigidBody(new Cube(1, 1, 1), new PVector(-3, 0, 0), new PVector(1, 0, 0), new Quat(), new PVector(0, 0, 0)));
  world.add(new RigidBody(new Cube(1, 1, 1), new PVector(3, 0, 0), new PVector(-1, 0, 0), quatFromAxisAngle(new PVector(1, 1, 0), TAU/4), new PVector(TAU/10, 0, 0)));
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
      final Quat q = body.rot();
      translate(body.pos().x, body.pos().y, body.pos().z);
      rotate(2*acos(q.w), q.x, q.y, q.z);

      final Geometry geometry = body.geometry();
      fill(255);
      switch (geometry.type()) {
        case CUBE:
          Cube cube = (Cube)geometry;
          box(cube.width(), cube.height(), cube.depth());
          
          final float[] eulerAngles = camera.getRotations();
          final PVector dir = new PVector(
            sin(eulerAngles[0]) * sin(eulerAngles[2]) - cos(eulerAngles[0]) * sin(eulerAngles[1]) * cos(eulerAngles[2]),
            sin(eulerAngles[0]) * cos(eulerAngles[2]) + cos(eulerAngles[0]) * sin(eulerAngles[1]) * sin(eulerAngles[2]),
            cos(eulerAngles[0]) * cos(eulerAngles[1])
          );
          final PVector transformedDir = q.inverse().applyTo(dir);
          final LinkedList<PVector> supportPoints = cube.supportPointsFor(transformedDir);
          for (PVector point : supportPoints) {
            pushMatrix();
              translate(point.x, point.y, point.z);
              fill(0, 255, 255);
              box(cube.width() / 10, cube.height() / 10, cube.depth() / 10);
            popMatrix();
          }
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
