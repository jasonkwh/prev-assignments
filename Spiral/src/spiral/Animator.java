package spiral;

import java.awt.Graphics;
import java.awt.Image;

import javax.swing.JPanel;

/**
 * Defines the animation state
 */
public class Animator extends JPanel implements Runnable {
	/** Detect the animation is ON or OFF */
	private boolean run = false;
	
	/** Back buffer image.*/
	private Image backBufferImg;
	
	/** A animatable object.*/
	private Animatable animatable;
	
	/** The animation thread.*/
	private Thread animationThread;

	/**
	 * Constructor.
	 * Initialise this animator.
	 * @param animatable
	 */
	public Animator(Animatable animatable) {
		this.animatable = animatable;
	}
	
	/**
	 * Runnable interface of animation.
	 */
	public void run() {
		while (run == true) {
			try {
				Thread.sleep(80);
				animatable.step();
				repaint();
			} catch (InterruptedException e) {
				
			}
		}
	}

	/**
	 * Play the animation.
	 */
	public void play() {
		if (run == false) {
			animationThread = new Thread(this);
			animationThread.start();
			run = true;
		}
	}

	
	/**
	 * Stop the animation.
	 */
	public void stop() {
		if (run == true) {
			run = false;
		}
	}

	/**
	 * Creates the back buffer image, then paint.
	 */
	public void paintComponent(Graphics graphic) {
		if (backBufferImg == null) {
			backBufferImg = createImage(animatable.getWidth(), animatable.getHeight());
		}

		animatable.paint(backBufferImg.getGraphics());
		graphic.drawImage(backBufferImg, 0, 0, getWidth(), getHeight(), this);
	}

}