package spiral;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class SpiralTest {
	CellularAutomaton auto;
	Position newPosition;
	Position[] nb;
	int[][] autoGrid, result3, result4;
	
	@Before
	public void initiate() {
		auto = new CellularAutomaton(3, 1.0, 1.0); //Test condition: gridSize 3, PREY and PREDATOR 1.0
		newPosition = new Position(3,4);
		autoGrid = new int[][] {{auto.PREY, auto.PREDATOR, auto.NONE},{auto.PREDATOR, auto.PREY, auto.PREY},{auto.NONE, auto.NONE, auto.PREY}};
	}
	
	/**
	 * Test getHeight() and getWidth() of CellularAutomaton class
	 */
	@Test
	public void testGetWidthHeight() {
		assertTrue(auto.getHeight()==15);
		assertTrue(auto.getWidth()==15);
	}
	
	/**
	 * Test update(), step(), setGrid(), and getGrid() of CellularAutomaton class
	 */
	@Test
	public void testCellularAutomaton() {
		//Test update() function
		//Expect result
		//result1 = new int[][] {{auto.NONE, auto.PREDATOR, auto.PREDATOR},{auto.PREDATOR, auto.PREDATOR, auto.PREDATOR},{auto.PREY, auto.PREY, auto.PREY}};
		
		//use update() function
		//auto.update(autoGrid, auto.PREY, auto.PREDATOR, auto.preyProb);
		//result2 = auto.getGrid();
		
		//Compare each elements...
		/*for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				assertTrue(result1[i][j]==result2[i][j]);
			}
		}*/
		
		
		/**
		 * Test step() function
		 */
		//Expect result
		result3 = new int[][] {{auto.NONE, auto.PREDATOR, auto.PREY},{auto.PREDATOR, auto.PREDATOR, auto.PREDATOR},{auto.PREY, auto.PREY, auto.PREY}};
		
		//set grid as the preset autoGrid
		auto.setGrid(autoGrid);
		auto.step();
		
		//get the real actual result
		result4 = auto.getGrid();
		
		//Compare each elements...
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				assertTrue(result3[i][j]==result4[i][j]);
			}
		}
	}
	
	/**
	 * Test Position class
	 */
	@Test
	public void testPosition() {
		/**
		 * Test getX() and getY()
		 */
		assertEquals(newPosition.getX(), 3);
		assertEquals(newPosition.getY(), 4);
		
		/**
		 * Test getNeighborPositions(), getX(), and getY()
		 */
		nb = new Position[] {new Position(2, 3), new Position(3, 3), new Position(4, 3), new Position(2, 4), new Position(4, 4), new Position(2, 5), new Position(3, 5), new Position(4, 5)};
		
		//Compare each elements...
		for (int i = 0; i < 8; i++) {
			assertTrue(nb[i].getX()==newPosition.getNeighborPositions()[i].getX());
			assertTrue(nb[i].getY()==newPosition.getNeighborPositions()[i].getY());
		}
	}
}
