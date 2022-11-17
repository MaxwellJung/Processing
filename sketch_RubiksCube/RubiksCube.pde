public class RubiksCube
{
  public boolean front, right, back, left = true, top, bottom;
  color color1, color2, color3, color4, color5, color6;
  Block[] blocks = new Block[27];
  private float topAngle, bottomAngle, leftAngle, rightAngle, frontAngle, backAngle = 0;
  private float epsilon = 0.033;
  
  public RubiksCube()
  {
    for (int i = 0; i < 27; i++)
    {
      blocks[i] = new Block(i);
    }
  }
  
  public void rotateLeft(float radians)
  {
    leftAngle = rotateFace(leftAngle, radians);
  }
  
  public void rotateRight(float radians)
  {
    rightAngle = rotateFace(rightAngle, radians);
  }
  
  public void rotateTop(float radians)
  {
    topAngle = rotateFace(topAngle, radians);
  }
  
  public void rotateBottom(float radians)
  {
    bottomAngle = rotateFace(bottomAngle, radians);
  }
  
  public void rotateBack(float radians)
  {
    backAngle = rotateFace(backAngle, radians);
  }
  
  public void rotateFront(float radians)
  {
    frontAngle = rotateFace(frontAngle, radians);
  }
  
  
  public float rotateFace(float faceAngle, float radians)
  {
    float angle = faceAngle;
    float newAngle = (angle + radians)%TWO_PI;
    
    if (Math.abs(newAngle-Math.round(newAngle/HALF_PI)*HALF_PI) < epsilon)
    {
      angle = Math.round(newAngle/HALF_PI)*HALF_PI;
    }
    else
    {
      angle = newAngle;
    }
    
    return angle;
  }
  
  void drawCube()
  {
    int i = 0, l;
    for (int x = -1; x <= 1; x++)
    {
      for (int y = -1; y <= 1; y++)
      {
        for (int z = -1; z <= 1; z++)
        {
          l = blocks[i].squareLength;
          if (left == true)
          {
            if (x == -1) //left
            {
              translate(x*l, (float) (y*l*Math.cos(leftAngle)+z*l*Math.sin(leftAngle)), (float) (-y*l*Math.sin(leftAngle)+z*l*Math.cos(leftAngle)));
              rotateX(-leftAngle);
              blocks[i].drawBlock();
              rotateX(leftAngle);
              translate(-x*l, (float) (-y*l*Math.cos(leftAngle)-z*l*Math.sin(leftAngle)), (float) (y*l*Math.sin(leftAngle)-z*l*Math.cos(leftAngle)));
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          else if (right == true)
          {
            if (x == 1) //right
            {
              translate(x*l, (float) (y*l*Math.cos(rightAngle)+z*l*Math.sin(rightAngle)), (float) (-y*l*Math.sin(rightAngle)+z*l*Math.cos(rightAngle)));
              rotateX(-rightAngle);
              blocks[i].drawBlock();
              rotateX(rightAngle);
              translate(-x*l, (float) (-y*l*Math.cos(rightAngle)-z*l*Math.sin(rightAngle)), (float) (y*l*Math.sin(rightAngle)-z*l*Math.cos(rightAngle)));
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          else if (top == true)
          {
            if (y == -1) //top
            {
              translate((float) (x*l*Math.cos(topAngle)-z*l*Math.sin(topAngle)), y*l, (float) (x*l*Math.sin(topAngle)+z*l*Math.cos(topAngle)));
              rotateY(-topAngle);
              blocks[i].drawBlock();
              rotateY(topAngle);
              translate((float) (-x*l*Math.cos(topAngle)+z*l*Math.sin(topAngle)), -y*l, (float) (-x*l*Math.sin(topAngle)-z*l*Math.cos(topAngle)));
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          else if (bottom == true)
          {
            if (y == 1) //bottom
            {
              translate((float) (x*l*Math.cos(bottomAngle)-z*l*Math.sin(bottomAngle)), y*l, (float) (x*l*Math.sin(bottomAngle)+z*l*Math.cos(bottomAngle)));
              rotateY(-bottomAngle);
              blocks[i].drawBlock();
              rotateY(bottomAngle);
              translate((float) (-x*l*Math.cos(bottomAngle)+z*l*Math.sin(bottomAngle)), -y*l, (float) (-x*l*Math.sin(bottomAngle)-z*l*Math.cos(bottomAngle)));
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          else if (back == true)
          {
            if (z == -1) //back
            {
              translate((float) (x*l*(Math.cos(backAngle))+y*l*Math.sin(backAngle)), (float) (-x*l*Math.sin(backAngle)+y*l*(Math.cos(backAngle))), z*l);
              rotateZ(-backAngle);
              blocks[i].drawBlock();
              rotateZ(backAngle);
              translate((float) (-x*l*(Math.cos(backAngle))-y*l*Math.sin(backAngle)), (float) (x*l*Math.sin(backAngle)-y*l*(Math.cos(backAngle))), -z*l);
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          else if (front == true)
          {
            if (z == 1) //front
            {
              translate((float) (x*l*(Math.cos(frontAngle))+y*l*Math.sin(frontAngle)), (float) (-x*l*Math.sin(frontAngle)+y*l*(Math.cos(frontAngle))), z*l);
              rotateZ(-frontAngle);
              blocks[i].drawBlock();
              rotateZ(frontAngle);
              translate((float) (-x*l*(Math.cos(frontAngle))-y*l*Math.sin(frontAngle)), (float) (x*l*Math.sin(frontAngle)-y*l*(Math.cos(frontAngle))), -z*l);
            }
            else
            {
              translate(x*l, y*l, z*l);
              blocks[i].drawBlock();
              translate(-x*l, -y*l, -z*l);
            }
          }
          i++;
        }
      }
    }
  }
}
