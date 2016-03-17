package spiral;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JPanel;

/**
 * MainPannel class
 */
public class MainPannel extends JPanel implements ActionListener {

	/**
	 * Initialise CellularAutomaton and Animator object
	 */
	private CellularAutomaton auto;
	private Animator animator;
	
	/**
	 * Initialise the button switch for play and pause
	 */
	private JButton button;
	
	/** Controls play or stop of the animator */
	private boolean animatorControl = true;

	/**
	 * Initialise this MainPannel.
	 */
	public MainPannel() {
		auto = new CellularAutomaton(100, 1.0, 1.0); //create a new CellularAutomaton with the gridSize 100x100
		//auto = new CellularAutomaton();
		animator = new Animator(auto);
		animator.play();

		// Play button
		button = new JButton("Pause");
		button.addActionListener(this);

		//GridBagLayout
		setLayout(new GridBagLayout());

		// animator
		add(animator, 0, 0, 1, 5, 1.0, 1.0, GridBagConstraints.CENTER, GridBagConstraints.BOTH);

		// control buttons
		add(button, 0, 5, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL);
	}

	/**
	 * Button actions
	 */
	public void actionPerformed(ActionEvent event) {
		JButton source = (JButton) event.getSource();
		if ((source == button) && (animatorControl == true)) {
			button.setText("Resume");
			animatorControl = false;
			changeAnimatorState(animatorControl);
		} else if ((source == button) && (animatorControl == false)) {
			button.setText("Pause");
			animatorControl = true;
			changeAnimatorState(animatorControl);
		}
	}
	
	/**
	 * Switch the state of animator (either play or stop)
	 * @param ac
	 */
	public void changeAnimatorState(boolean ac) {
		if(ac==true) {
			animator.play();
		}
		else {
			animator.stop();
		}
	}

	/**
	 * Main pannel is displayed by GridBagLayout.
	 * 
	 * @param com
	 * @param gridx
	 * @param gridy
	 * @param gridwidth
	 * @param gridheight
	 * @param weightx
	 * @param weighty
	 * @param anchor
	 * @param fill
	 */
	private void add(JComponent com, int gridx, int gridy, int gridwidth, int gridheight, double weightx, double weighty, int anchor, int fill) {
		GridBagConstraints c = new GridBagConstraints(gridx, gridy, gridwidth, gridheight, weightx, weighty, anchor, fill, new Insets(5, 5, 5, 5), 0, 0);
		add(com, c);
	}

}
