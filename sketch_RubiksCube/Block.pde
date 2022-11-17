public class Block
{
  public int index;
  public color main, side1, side2;
  public int squareLength = 100;
  public Face[] faces = new Face[6];
  
  public Block(int index)
  {
    this.index = index;
    for (int i = 0; i < 6; i++)
    {
      color faceColor = #000000;
      if (i == 0) {faceColor = #00FF00;} //green, front
      else if (i == 1) {faceColor = #FF0000;} //red, right
      else if (i == 2) {faceColor = #0000FF;} //blue, back
      else if (i == 3) {faceColor = #FF8C00;} //orange, left
      else if (i == 4) {faceColor = #FFFFFF;} //white, top
      else if (i == 5) {faceColor = #FFFF00;} //yellow, bottom
      faces[i] = new Face(faceColor);
    }
  }
  
  public void drawBlock()
  {
    fill(#FFFFFF);
    box(squareLength);
    for (int i = 0; i <= 5; i++)
    {
      fill(faces[i].getColor());
      if (i < 4) //colors for front, right, back, left
      {
        rotateY(i*HALF_PI);
        translate(0, 0, 0.5*squareLength);
        box(squareLength, squareLength, 1);
        translate(0, 0, -0.5*squareLength);
        rotateY(i*-HALF_PI);
      }
      else if (i == 4) //color for top
      {
        rotateX(HALF_PI);
        translate(0, 0, 0.5*squareLength);
        box(squareLength, squareLength, 1);
        translate(0, 0, -0.5*squareLength);
        rotateX(-HALF_PI);
      }
      else if (i == 5) //color for bottom
      {
        rotateX(-HALF_PI);
        translate(0, 0, 0.5*squareLength);
        box(squareLength, squareLength, 1);
        translate(0, 0, -0.5*squareLength);
        rotateX(HALF_PI);
      }
    }
  }
}
