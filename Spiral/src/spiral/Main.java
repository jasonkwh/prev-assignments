package spiral;

import javax.swing.JFrame;

/**
 * Main class
 * @author jasonkwh
 *
 */
public class Main extends JFrame {
	
	/**
	 * Constructor of a Main window (including panel, title, and size)
	 */
	public Main() {
		this.add(new MainPannel());
		this.setTitle("Cellular Automata of Predator-Prey System");
		this.setSize(400, 450);
	}

	/**
	 * Main function.
	 * @param args
	 */
	public static void main(String[] args) {
		JFrame GUIframe = new Main();
		GUIframe.setVisible(true);
	}
}
