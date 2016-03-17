package spiral;

import java.awt.Graphics;

/**
 * Implement this interface, represent the state of an animation.
 */
public interface Animatable {
	/** Step the animation state forward by one frame. */
	public void step();
	/** Paint the current state of the animation onto the graphics canvas. */
	public void paint(Graphics pGraphics);
	/** Get the width of this animation in pixels. */
	public int getWidth();
	/** Get the height of this animation in pixels. */
	public int getHeight();

}
