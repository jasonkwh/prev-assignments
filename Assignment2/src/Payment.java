/** Assignment 2 + Practical Week 8
 *
 * @author Jason Huang
 * @version 1.0 Dec 21, 2011.
 */

public class Payment {

	//Constructor
	public Payment(int fiveC, int tenC, int twentyC, int fiftyC, int oneD, int twoD, int fiveD, int tenD, int twentyD, int fiftyD, int hundredD)
	{
		registerFiveC = fiveC;
		registerTenC = tenC;
		registerTwentyC = twentyC;
		registerFiftyC = fiftyC;
		registerOneD = oneD;
		registerTwoD = twoD;
		registerFiveD = fiveD;
		registerTenD = tenD;
		registerTwentyD = twentyD;
		registerFiftyD = fiftyD;
		registerHundredD = hundredD;
	}
	
	//Methods
	public void setValues(int fiveC, int tenC, int twentyC, int fiftyC, int oneD, int twoD, int fiveD, int tenD, int twentyD, int fiftyD, int hundredD)
	{
		setFiveCents(fiveC);
		setTenCents(tenC);
		setTwentyCents(twentyC);
		setFiftyCents(fiftyC);
		setOneDollar(oneD);
		setTwoDollars(twoD);
		setFiveDollars(fiveD);
		setTenDollars(tenD);
		setTwentyDollars(twentyD);
		setFiftyDollars(fiftyD);
		setHundredDollars(hundredD);
 	}
	
	public void setFiveCents(int value)
	{
		fiveCents = value * 5;
	}
	
	public void setTenCents(int value)
	{
		tenCents = value * 10;
	}
	
	public void setTwentyCents(int value)
	{
		twentyCents = value * 20;
	}
	
	public void setFiftyCents(int value)
	{
		fiftyCents = value * 50;
	}
	
	public void setOneDollar(int value)
	{
		oneDollar = value * 1;
	}
	
	public void setTwoDollars(int value)
	{
		twoDollars = value * 2;
	}
	
	public void setFiveDollars(int value)
	{
		fiveDollars = value * 5;
	}
	
	public void setTenDollars(int value)
	{
		tenDollars = value * 10;
	}
	
	public void setTwentyDollars(int value)
	{
		twentyDollars = value *20;
	}
	
	public void setFiftyDollars(int value)
	{
		fiftyDollars = value * 50;
	}
	
	public void setHundredDollars(int value)
	{
		hundredDollars = value * 100;
	}
	
	public int getFiveCents()
	{
		return registerFiveC;
	}
	
	public int getTenCents()
	{
		return registerTenC;
	}
	
	public int getTwentyCents()
	{
		return registerTwentyC;
	}
	
	public int getFiftyCents()
	{
		return registerFiftyC;
	}
	
	public int getOneDollar()
	{
		return registerOneD;
	}
	
	public int getTwoDollars()
	{
		return registerTwoD;
	}
	
	public int getFiveDollars()
	{
		return registerFiveD;
	}
	
	public int getTenDollars()
	{
		return registerTenD;
	}
	
	public int getTwentyDollars()
	{
		return registerTwentyD;
	}
		
	public int getFiftyDollars()
	{
		return registerTwentyD;
	}
	
	public int getHundredDollars()
	{
		return registerHundredD;
	}
	
	//getting the value of dollars
	public int valueOfDollars()
	{
		valueDollars = oneDollar + twoDollars + fiveDollars + tenDollars + twentyDollars + fiftyDollars + hundredDollars;
		valueDollars = valueDollars + (fiveCents + tenCents + twentyCents + fiftyCents)/100;
		return valueDollars;
	}
	
	//getting the value of cents
	public int valueOfCents()
	{
		return valueCents = (fiveCents + tenCents + twentyCents + fiftyCents)%100;
	}
	
	//total = dollar + cents
	public float valueOfPayment()
	{
		return valuePayment = valueOfDollars() + (float)valueOfCents()/100;
	}
	
	//11 types of notes
	private int fiveCents;
	private int tenCents;
	private int twentyCents;
	private int fiftyCents;
	private int oneDollar;
	private int twoDollars;
	private int fiveDollars;
	private int tenDollars;
	private int twentyDollars;
	private int fiftyDollars;
	private int hundredDollars;
	
	//11 types of notes (REGISTER), main class can call this as well
	public int registerFiveC;
	public int registerTenC;
	public int registerTwentyC;
	public int registerFiftyC;
	public int registerOneD;
	public int registerTwoD;
	public int registerFiveD;
	public int registerTenD;
	public int registerTwentyD;
	public int registerFiftyD;
	public int registerHundredD;
	
	//for cash values
	private int valueDollars;
	private int valueCents;
	private float valuePayment;
}
