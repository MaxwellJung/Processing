public class Grid {
  Block[][] block;
  private final int COLS;
  private final int ROWS;
  private int score;
  
  public Grid(int cols, int rows) {
    COLS = cols;
    ROWS = rows;
    block = new Block[COLS][ROWS];
    initBlocks();  // initializes all blocks to empty blocks
  }
    
  public Block getBlock(int col, int row) {
    return block[col][row];
  }
  
  public void setBlock(int col, int row, int value, boolean changed) {
    block[col][row] = new Block(value, changed);
  }
  
  public void setBlock(int col, int row, int value) {
    setBlock(col, row, value, false);
  }
  
  public void setBlock(int col, int row) {
    setBlock(col, row, 0, false);
  }
  
  public void setBlock(int col, int row, Block b) {
    block[col][row] = b;
  }
  
  public void initBlocks() {
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        setBlock(col, row, 0);
      }
    }
  }
  
  public boolean isValid(int col, int row) {
    return 0 <= col && col < COLS && 0 <= row && row < ROWS;
  }
  
  public void swap(int col1, int row1, int col2, int row2) {
    if (isValid(col1, row1) && isValid(col2, row2))
    {
      Block temp = block[col1][row1];
      block[col1][row1] = block[col2][row2];
      block[col2][row2] = temp;
    }
  }
  
  public boolean canMerge(int col1, int row1, int col2, int row2) {
    if (isValid(col1, row1) && isValid(col2, row2) && !getBlock(col1, row1).isEmpty() && !getBlock(col2, row2).isEmpty())
    {
      return getBlock(col1, row1).getValue() == getBlock(col2, row2).getValue();
    }
    else
    {
      return false;
    }
  }
  
  public void clearChangedFlags() {
    for(int col = 0; col < COLS; col++) {
      for(int row = 0; row < ROWS; row++) {
        block[col][row].setChanged(false);
      }
    }
  }
 
  // Is there an open space on the grid to place a new block?
  public boolean canPlaceBlock() {
    return getEmptyLocations().size() > 0;
  }
  
  public ArrayList<Location> getEmptyLocations() {
    // Put all locations that are currently empty into locs
    ArrayList<Location> locs = new ArrayList<Location>();
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        if (getBlock(col, row).isEmpty())
        {
          locs.add(new Location(col, row));
        }
      }
    }
    return locs;
  }
  
  public Location selectLocation(ArrayList<Location> locs) {
    return locs.get((int) (Math.random()*locs.size()));
  }
  
  // Randomly select an open location to place a block.
  public void placeBlock() {
    Location loc = selectLocation(getEmptyLocations());
    if (Math.random() < 7/8.0)
    {
      setBlock(loc.getCol(), loc.getRow(), 2, false);
    }
    else
    {
      setBlock(loc.getCol(), loc.getRow(), 4, false);
    }
  }
  
  // Are there any adjacent blocks that contain the same value?
  public boolean hasCombinableNeighbors() {
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        if (canMerge(col, row, col-1, row) || canMerge(col, row, col+1, row) || canMerge(col, row, col, row-1) || canMerge(col, row, col, row+1))
        {
          return true;
        }
      }
    }
    return false;
  }
   
  // Notice how an enum can be used as a data type
  //
  // This is called ) method  the KeyEvents tab
  public boolean someBlockCanMoveInDirection(DIR dir) {
    int e = 0, d = 0;
    if (dir == DIR.NORTH) {d = -1;}
    else if (dir == DIR.SOUTH) {d = 1;}
    else if (dir == DIR.WEST) {e = -1;}
    else if (dir == DIR.EAST) {e = 1;}
    
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        if (!getBlock(col, row).isEmpty())
        {
          if (isValid(col+e, row+d))
          {
            if (canMerge(col, row, col+e, row+d) || getBlock(col+e, row+d).isEmpty())
            {
              return true;
            }
          }
        }
      }
    }
    return false;
  }
  
  // Computes the number of points that the player has scored
  public void computeScore() {
    score = 0;
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        int i = getBlock(col, row).getValue();
        score += calculatePoints(i);
      }
    }
  }
  
  private int calculatePoints(int i)
  {
    if (i <= 2)
    {
      return 0;
    }
    else if (i == 4)
    {
      return 4;
    }
    else
    {
      return i + 2*calculatePoints(i/2);
    }
  }
  
  public int getScore() {
    return score;
  }
  
  public void showScore() {
      textFont(scoreFont);
      fill(#000000);
      text("Score: " + getScore(), width/2, SCORE_Y_OFFSET);
      textFont(blockFont);
  }
  
  public void showBlocks() {
    for (int row = 0; row < ROWS; row++) {
      for (int col = 0; col < COLS; col++) {
        Block b = block[col][row];
        if (!b.isEmpty()) {
          float adjustment = (log(b.getValue()) / log(2)) - 1;
          fill(color(242 , 241 - 8*adjustment, 239 - 8*adjustment));
          rect(GRID_X_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*col, GRID_Y_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*row, BLOCK_SIZE, BLOCK_SIZE, BLOCK_RADIUS);
          fill(color(108, 122, 137));
          text(str(b.getValue()), GRID_X_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*col + BLOCK_SIZE/2, GRID_Y_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*row + BLOCK_SIZE/2 - Y_TEXT_OFFSET);
        } else {
          fill(BLANK_COLOR);
          rect(GRID_X_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*col, GRID_Y_OFFSET + (BLOCK_SIZE + BLOCK_MARGIN)*row, BLOCK_SIZE, BLOCK_SIZE, BLOCK_RADIUS);
        }
      }
    }
  }
  
  // Copy the contents of another grid to this one
  public void gridCopy(Grid other) {
    for (int row = 0; row < ROWS; row++)
    {
      for (int col = 0; col < COLS; col++)
      {
        setBlock(col, row, other.getBlock(col, row));
      }
    }
  }
  
  public boolean isGameOver() {
    return !someBlockCanMoveInDirection(DIR.NORTH) && !someBlockCanMoveInDirection(DIR.SOUTH) && !someBlockCanMoveInDirection(DIR.EAST) && !someBlockCanMoveInDirection(DIR.WEST);
  }
  
  public void showGameOver() {
    fill(#0000BB);
    text("GAME OVER", GRID_X_OFFSET + 2*BLOCK_SIZE + 15, GRID_Y_OFFSET + 2*BLOCK_SIZE + 15);
  }
  
  public String toString() {
    String str = "";
    for (int row = 0; row < ROWS; row++) {
      for (int col = 0; col < COLS; col++) {
        str += block[col][row].getValue() + " ";
      }
      str += "\n";   // "\n" is a newline character
    }
    return str;
  }
}