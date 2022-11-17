public class Face
{
  private ArrayList<Block> blocks = new ArrayList<Block>(9);
  public color main;
  
  public Face(color main)
  {
    this.main = main;
  }
  
  public color getColor()
  {
    return main;
  }
}