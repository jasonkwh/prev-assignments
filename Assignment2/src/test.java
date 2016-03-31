/** Assignment 2 + Practical Week 8
 *
 * @author Jason Huang
 * @version 1.0 Dec 21, 2011.
 */

public class test {
	
	//Constructor
	public test(Payment systemC, boolean checkC)
	{
		systemCash = systemC;
		checkCash = checkC;
	}
	
	//Methods
	public Payment testChange(float cost, Payment amountUserTendered)
	{
		//calculate the value of changes
		float changeValue = amountUserTendered.valueOfPayment() - cost;
		int dollarsValue = (int)changeValue;
		int centsValue = (int)((changeValue*100)%100);
		
		//transfer system cash to test (container A to container B)
		testCash.registerFiveC = systemCash.registerFiveC;
		testCash.registerTenC = systemCash.registerTenC;
		testCash.registerTwentyC = systemCash.registerTwentyC;
		testCash.registerFiftyC = systemCash.registerFiftyC;
		testCash.registerOneD = systemCash.registerOneD;
		testCash.registerTwoD = systemCash.registerTwoD;
		testCash.registerFiveD = systemCash.registerFiveD;
		testCash.registerTenD = systemCash.registerTenD;
		testCash.registerTwentyD = systemCash.registerTwentyD;
		testCash.registerFiftyD = systemCash.registerFiftyD;
		testCash.registerHundredD = systemCash.registerFiftyD;

		changePayment.registerFiveC = 0;
		changePayment.registerTenC = 0;
		changePayment.registerTwentyC = 0;
		changePayment.registerFiftyC = 0;
		changePayment.registerOneD = 0;
		changePayment.registerTwoD = 0;
		changePayment.registerFiveD = 0;
		changePayment.registerTenD = 0;
		changePayment.registerTwentyD = 0;
		changePayment.registerFiftyD = 0;
		changePayment.registerHundredD = 0;
		
		for(;dollarsValue > 0;)
		{
			for(;dollarsValue >= 100;dollarsValue -= 100)
			{
				if(testCash.registerHundredD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerHundredD --;
					changePayment.registerHundredD ++;
				}
			}
			for(;dollarsValue >= 50;dollarsValue -= 50)
			{
				if(testCash.registerFiftyD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerFiftyD --;
					changePayment.registerFiftyD ++;
				}
				
			}
			for(;dollarsValue >= 20;dollarsValue -= 20)
			{
				if(testCash.registerTwentyD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerTwentyD --;
					changePayment.registerTwentyD ++;
				}	
			}
			for(;dollarsValue >= 10;dollarsValue -= 10)
			{
				if(testCash.registerTenD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerTenD --;
					changePayment.registerTenD ++;
				}
			}
			for(;dollarsValue >= 5;dollarsValue -= 5)
			{
				if(testCash.registerFiveD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerFiveD --;
					changePayment.registerFiveD ++;
				}
			}
			for(;dollarsValue >= 2;dollarsValue -= 2)
			{
				if(testCash.registerTwoD <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerTwoD --;
					changePayment.registerTwoD ++;
				}
			}
			for(;dollarsValue >= 1;dollarsValue -= 1)
			{
				if(testCash.registerOneD <= 0)
				{
					centsValue +=100;
					dollarsValue -= 1;
					continue;
				}
				else
				{
					testCash.registerOneD --;
					changePayment.registerOneD ++;
				}
			}
		}
		for (;centsValue > 0;)
		{
			for(;centsValue > 50;centsValue -= 50)
			{
				if(testCash.registerFiftyC <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerFiftyC --;
					changePayment.registerFiftyC ++;
				}
			}

			for(;centsValue >= 20;centsValue -= 20)
			{
				if(testCash.registerTwentyC <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerTwentyC --;
					changePayment.registerTwentyC ++;
				}
			}
			for(;centsValue >= 10;centsValue -= 10)
			{
				if(testCash.registerTenC <= 0)
				{
					continue;
				}
				else
				{
					testCash.registerTenC --;
					changePayment.registerTenC ++;
				}
			}
			
			for(;centsValue >= 5;centsValue -= 5)
			{
				if(testCash.registerFiveC <= 0)
				{
					checkCash = false;
					System.err.println("ERROR! System does not have enough cash for changes.");
					continue;
				}
				else
				{
					testCash.registerFiveC --;
					changePayment.registerFiveC ++;
				}		
			}
		}
		if(checkCash = true){
			testCash.registerFiveC = systemCash.registerFiveC + amountUserTendered.registerFiveC;
			testCash.registerTenC = systemCash.registerTenC + amountUserTendered.registerTenC;
			testCash.registerTwentyC = systemCash.registerTwentyC + amountUserTendered.registerTwentyC;
			testCash.registerFiftyC = systemCash.registerFiftyC + amountUserTendered.registerFiftyC;
			testCash.registerOneD = systemCash.registerOneD + amountUserTendered.registerOneD;
			testCash.registerTwoD = systemCash.registerTwoD + amountUserTendered.registerTwoD;
			testCash.registerFiveD = systemCash.registerFiveD + amountUserTendered.registerFiveD;
			testCash.registerTenD = systemCash.registerTenD + amountUserTendered.registerTenD;
			testCash.registerTwentyD = systemCash.registerTwentyD + amountUserTendered.registerTwentyD;
			testCash.registerFiftyD = systemCash.registerFiftyD + amountUserTendered.registerFiftyD;
			testCash.registerHundredD = systemCash.registerHundredD + amountUserTendered.registerHundredD;
		}
		return changePayment;
	}
	
	//add system cash to test, if the system has enough cash for changes
	public static Payment testSystemMoney()
	{
		if(checkCash==true)
		{
			//transfer system cash to test (container A to container B)
			testCash.registerFiveC = systemCash.registerFiveC;
			testCash.registerTenC = systemCash.registerTenC;
			testCash.registerTwentyC = systemCash.registerTwentyC;
			testCash.registerFiftyC = systemCash.registerFiftyC;
			testCash.registerOneD = systemCash.registerOneD;
			testCash.registerTwoD = systemCash.registerTwoD;
			testCash.registerFiveD = systemCash.registerFiveD;
			testCash.registerTenD = systemCash.registerTenD;
			testCash.registerTwentyD = systemCash.registerTwentyD;
			testCash.registerFiftyD = systemCash.registerFiftyD;
			testCash.registerHundredD = systemCash.registerFiftyD;
			return testCash;
		}
		else
			return systemCash;
	}

	//to define whether or not the system has cash
	private static boolean checkCash;
	private static Payment testCash = new Payment(0,0,0,0,0,0,0,0,0,0,0);
	private Payment changePayment = new Payment(0,0,0,0,0,0,0,0,0,0,0);
	private static Payment systemCash;
}
