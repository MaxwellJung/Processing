int squareLength = 100;
float angleX = -0.5, angleY = -0.5, angleZ = 0, translZ = 0, sensitivity = 0.25;
int previousMouseX, previousMouseY;
color[] tiles = new color[54];
RubiksCube cube = new RubiksCube();

void setup()
{
  size(700, 700, P3D);
}

void draw()
{
  background(#FFFFFF);
  int arrowLength = 330, offset = 0;
  
  translate(width/2, height/2, translZ);
  rotateX(angleX);
  rotateY(angleY);
  stroke(#FF0000);
  line(offset, offset, offset, arrowLength, offset, offset);
  stroke(#00FF00);
  line(offset, offset, offset, offset, arrowLength, offset);
  stroke(#0000FF);
  line(offset, offset, offset, offset, offset, arrowLength);
  stroke(#000000);
  cube.drawCube();
  rotateX(-1*angleX);
  rotateY(-1*angleY);
  translate(-1*width/2, -1*height/2, translZ);
}
  
void mousePressed()
{
  previousMouseX = mouseX;
  previousMouseY = mouseY;
}

void mouseWheel(MouseEvent e)
{
  translZ -= e.getCount()*30;
}

void mouseDragged()
{
  int dx = mouseX - previousMouseX;
  int dy = mouseY - previousMouseY;
  
  if (mouseButton == LEFT)
  {
    cube.rotateLeft(PI/180*dy*sensitivity);
    cube.rotateRight(PI/180*dy*sensitivity);
    cube.rotateTop(PI/-180*dx*sensitivity);
    cube.rotateBottom(PI/-180*dx*sensitivity);
    cube.rotateBack(PI/-180*dx*sensitivity);
    cube.rotateFront(PI/-180*dx*sensitivity);
  }
  else if (mouseButton == RIGHT)
  {
    angleX -= PI/180*dy*sensitivity; //movement in y direction rotates the cube with respect to the x-axis
    angleY += PI/180*dx*sensitivity; //movment in x direction rotates the cube with respect to the y-axis.
  }
  
  previousMouseX = mouseX;
  previousMouseY = mouseY;
}
