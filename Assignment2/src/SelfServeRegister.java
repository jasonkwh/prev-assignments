/** Assignment 2 + Practical Week 8
 *
 * @author Jason Huang
 * @version 1.0 Dec 21, 2011.
 */

public class SelfServeRegister {
	
	//Constructor
	public SelfServeRegister(Payment money, boolean checkC)
	{	
		registerContents = money;
		checkCash = checkC;
	}
	
	//Methods
	public Payment transact(float costOfItems, Payment amountTendered)
	{
		test testReg = new test(registerContents, checkCash);
		return testReg.testChange(costOfItems, amountTendered);
	}
	
	public Payment currentFloat()
	{
		test testReg = new test(registerContents, checkCash);
		return testReg.testSystemMoney();
	}
	
	//to define whether or not the system has cash
	boolean checkCash;
	private Payment registerContents;
	test testReg;
}
