package spiral;

/**
 * A position representing a location at (x, y).
 */
public class Position {

	/** the X and Y coordinate */
	private int x, y;

	/**
	 * Constructor.
	 * The initial position is (0,0).
	 */
	public Position() {
		this.x = 0;
		this.y = 0;
	}

	/**
	 * Set the position (x,y) of a new object
	 */
	public Position(int x, int y) {
		this.x = x;
		this.y = y;
	}

	/**
	 * Returns the X coordinate
	 * @return x
	 */
	public int getX() {
		return x;
	}

	/**
	 * Returns the Y coordinate
	 * @return y
	 */
	public int getY() {
		return y;
	}

	/**
	 * Return positions of neighbors
	 * @return Position[] which stores all neighbor positions
	 */
	public Position[] getNeighborPositions() {
		return new Position[] {
				new Position(x - 1, y - 1), 
				new Position(x, y - 1), 
				new Position(x + 1, y - 1), 
				new Position(x - 1, y), 
				new Position(x + 1, y),
				new Position(x - 1, y + 1), 
				new Position(x, y + 1),
				new Position(x + 1, y + 1) };
	}
}