package spiral;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Cellular Automation class.
 */
public class CellularAutomaton implements Animatable {
	/** Constant PREY size 2, PREDATOR size 1, empty square size 0, SQUARE 5 */
	public final static int PREY = 2, PREDATOR = 1, NONE = 0, SQUARE = 5;
	
	/** check if remaining spaces... */
	private boolean remain;
	
	/** Grid size, and the array to represent the grid... */
	private int gridSize;
	private int[][] grid;
	
	/** Variable for repainting changedPositions. */
	private List<Position> changedPositions;
	
	/** Transition probability of PREDATOR & PREY. */
	public AtomicReference<Double> predatorProb, preyProb;
	
	/**
	 * Constructor.
	 * Initialize this CellularAutomaton object.
	 * 
	 * @param gridSize
	 * @param predatorProb
	 * @param preyProb
	 */
	public CellularAutomaton(int gridSize, double predatorPb, double preyPb) {
		this.gridSize = gridSize;
		this.predatorProb = new AtomicReference<Double>(predatorPb);
		this.preyProb = new AtomicReference<Double>(preyPb);
		this.grid = new int[gridSize][gridSize];
		
		Random random = new Random();
		int[] options = new int[] {PREDATOR, PREY, NONE, NONE};
		changedPositions = new ArrayList<Position>();
		for (int i = 0; i < gridSize; i++) {
			for (int j = 0; j < gridSize; j++) {
				grid[i][j] = options[random.nextInt(options.length)];
				
				//repaint squares not NONE (i.e., has color)
				if (grid[i][j]!=NONE) {
					changedPositions.add(new Position(j, i));
				}
			}
		}
		remain = true;
	}

	/**
	 * Get grid.
	 * @return grid
	 */
	public int[][] getGrid() {
		return grid;
	}

	/**
	 * Set grid.
	 * @param grid
	 */
	public void setGrid(int[][] grid) {
		this.grid = grid;
	}
	
	/** Get the width in pixels by gridSize * SQUARE */
	public int getWidth() {
		//System.out.println(gridSize * SQUARE);
		return gridSize * SQUARE;
	}
	
	/** Get the height in pixels by gridSize * SQUARE */
	public int getHeight() {
		//System.out.println(gridSize * SQUARE);
		return gridSize * SQUARE;
	}

	/** Step the animation state. */
	public synchronized void step() {
		int[][] newGrid = new int[gridSize][gridSize];
		
		//updates PREY
		newGrid = update(newGrid, PREY, NONE, preyProb);
		
		//updates PREDATOR
		newGrid = update(newGrid, PREDATOR, PREY, predatorProb);

		//PREDATOR to NONE
		for (int i = 0; i < gridSize; i++) {
			for (int j = 0; j < gridSize; j++) {
				if (newGrid[i][j] == PREDATOR) {
					boolean isPrey = false;
					Position position = new Position(j, i);
					Position[] neighbor = position.getNeighborPositions();
					for (int k = 0; k < (neighbor.length) && (isPrey==false); k++) {
						Position n = neighbor[k];
						int nx = n.getX();
						int ny = n.getY();
						if ((nx >= 0) && (nx < gridSize) && (ny >= 0) && (ny < gridSize) && (newGrid[ny][nx] == PREY)) {
							isPrey = true;
						}
					}
					
					if (isPrey==false) {
						newGrid[i][j] = NONE;
					}
				}
			}
		}

		//find and store changed positions
		for (int i = 0; i < gridSize; i++) {
			for (int j = 0; j < gridSize; j++) {
				if (newGrid[i][j] != grid[i][j]) {
					changedPositions.add(new Position(j, i));
				}
			}
		}
		
		//set grid as the new generated newGrid
		grid = newGrid;
	}
	
	/**
	 * Updates the animation double loop.
	 * 
	 * @param grid2
	 * @param STATE
	 * @param STATE2
	 * @param prob
	 * @return newGrid
	 */
	public int[][] update(int[][] grid2, int STATE, int STATE2, AtomicReference<Double> prob) {
		for (int i = 0; i < gridSize; i++) {
			for (int j = 0; j < gridSize; j++) {
				if (grid[i][j] == STATE) {
					grid2[i][j] = STATE;
					Position position = new Position(j,i);
					for (Position newPosition: position.getNeighborPositions()) {
						int nx = newPosition.getX();
						int ny = newPosition.getY();
						if ((nx >= 0) && (nx < gridSize) && (ny >= 0) && (ny < gridSize) && (grid[ny][nx] == STATE2) && (Math.random() < prob.get())) {
							grid2[ny][nx] = STATE;
						}
					}
				}
			}
		}
		return grid2;
	}

	/** Paint colour */
	public synchronized void paint(Graphics pGraphics) {
		if (remain == true) {
			pGraphics.setColor(Color.WHITE); // Fill background with white color
			pGraphics.fillRect(0, 0, getWidth(), getHeight());
			remain = false;
		}
		
		for (Position position: changedPositions) {
			int x = position.getX();
			int y = position.getY();
			
			//set PREDATOR as BLUE color
			if (grid[y][x] == PREDATOR) {
				pGraphics.setColor(Color.BLUE);
			}
			//set PREY as RED color
			else if (grid[y][x] == PREY) {
				pGraphics.setColor(Color.RED);
			}
			//set the NONE as WHITE color
			else {
				pGraphics.setColor(Color.WHITE);
			}

			pGraphics.fillRect(x * SQUARE, y * SQUARE, SQUARE, SQUARE);
		}
		
		changedPositions.clear();
	}

}
