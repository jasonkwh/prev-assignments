/** Assignment 2 + Practical Week 8
 *
 * @author Jason Huang
 * @version 1.0 Dec 21, 2011.
 */

import java.io.*;
import java.text.NumberFormat;
import java.util.*;

public class MainSystemRev8 {
	
	//to define whether or not the system has cash
	public static boolean hasEnoughCash = false;
	
	public static void main(String args[])
	{
		//11 types of notes (original numbers in the system)
		int fiveCmain = 0;
		int tenCmain = 0;
		int twentyCmain = 0;
		int fiftyCmain = 0;
		int oneDmain = 0;
		int twoDmain = 0;
		int fiveDmain = 0;
		int tenDmain = 0;
		int twentyDmain = 0;
		int fiftyDmain = 0;
		int hundredDmain = 0;

	    try {
	    	//read text file
	    	FileInputStream fstream = new FileInputStream("/Volumes/PRIVATE/transactions.txt");
	        DataInputStream in = new DataInputStream(fstream);
	        BufferedReader br = new BufferedReader(new InputStreamReader(in));
	        
	        //string for first line text
	        String str = br.readLine();
	        
	        //array for storing numbers from first line string
	        String[] strArray = str.split(" ");
	        	
	        //store the value from text to int (numbers of notes in the system)
	        fiveCmain = Integer.parseInt(strArray[0]);
	        tenCmain = Integer.parseInt(strArray[1]);
	        twentyCmain = Integer.parseInt(strArray[2]);
	        fiftyCmain = Integer.parseInt(strArray[3]);
	        oneDmain = Integer.parseInt(strArray[4]);
	        twoDmain = Integer.parseInt(strArray[5]);
	        fiveDmain = Integer.parseInt(strArray[6]);
	        tenDmain = Integer.parseInt(strArray[7]);
	        twentyDmain = Integer.parseInt(strArray[8]);
	        fiftyDmain = Integer.parseInt(strArray[9]);
	        hundredDmain = Integer.parseInt(strArray[10]);
	        
	        //input cash into system
    		Payment notesInSystem = new Payment(fiveCmain,tenCmain,twentyCmain,fiftyCmain,oneDmain,twoDmain,fiveDmain,tenDmain,twentyDmain,fiftyDmain,hundredDmain);
	        SelfServeRegister newRegister = new SelfServeRegister(notesInSystem,hasEnoughCash);
	        
	        if(fiveCmain > 0 && tenCmain > 0 && twentyCmain > 0 && fiftyCmain > 0 && oneDmain > 0 && twoDmain > 0 && fiveDmain >0 && tenDmain > 0 && twentyDmain > 0 && fiftyDmain > 0 && hundredDmain > 0)
	        {
	        	hasEnoughCash = true;

		        //remove the separation "\n" from the data by StringTokenizer
		        String str2;
		        String tokenizedString = "";
		        
		        //create the vector to store the tokens
		        Vector<String> data = new Vector<String>();
		        while ((str2 = br.readLine())!= null)
		        {
		        	//remove the separation "\n"
		        	StringTokenizer token = new StringTokenizer(str2,"\n");
		        	while(token.hasMoreTokens())
		        	{
		        		tokenizedString = token.nextToken();
		        		data.add(tokenizedString);
		        	}
		        }
		        
		        //remove the last vector "0"
		        data.remove(data.size()-1);
		        
		        //Transactions
		        //cost
		        Vector<Float> cost = new Vector<Float>();
		        
		        for(int i=0;i<data.size();i+=2)
		        {
		        	//transfer values from data (string vector) to cost (float vector)
		        	cost.add(Float.parseFloat(data.elementAt(i)));
		        }
		        
		        //user paid
		        //a array for deleting the " " in the string
		        String[] userTenderedTemp = new String[11];
		        
		        //a new vector for data excluding the cost
		        Vector<String> newData = new Vector<String>();
		        
		        //transfer the amount tendered data from "data" vector to "newData" vector
		        for(int i=1;i<data.size();i+=2)
		        {
		        	newData.add(data.elementAt(i));
		        }
		        
		        //create a 2D array for all transactions and data
		        int[][] storeAmountTendered = new int[newData.size()][11];
		        
		        for(int i=0;i<newData.size();i++)
		        {
		        	//deleting " " from string to string array
		        	userTenderedTemp = (newData.elementAt(i)).split(" ");
		        	for(int j=0;j<storeAmountTendered[i].length;j++)
		        	{
		        		//transfering data from string to 2d string, i represents numbers of transactions and j represents numbers of notes in each transaction
		        		storeAmountTendered[i][j] = Integer.parseInt(userTenderedTemp[j]);
		        	}
		        }
		        
		        //money format, from http://stackoverflow.com/questions/965831/how-to-parse-a-currency-amount-us-or-eu-to-float-value-in-java
		        NumberFormat moneyFormat = NumberFormat.getCurrencyInstance(Locale.US);
		        
		        //money owed: if the user did not pay enough money, he/she still need to pay this amount of cash
		        float moneyOwed;
		        
		        //output
		        for(int i=0;i<newData.size();i++)
		        {
		        	//output the cost
		        	System.out.println("Transaction " + (i+1) + "\nCost: " + moneyFormat.format(cost.elementAt(i)));
		        	
		        	//create and call the class Payment, then insert the data from 2d array
		        	Payment amountTenderPay = new Payment(storeAmountTendered[i][0],storeAmountTendered[i][1],storeAmountTendered[i][2],storeAmountTendered[i][3],storeAmountTendered[i][4],storeAmountTendered[i][5],storeAmountTendered[i][6],storeAmountTendered[i][7],storeAmountTendered[i][8],storeAmountTendered[i][9],storeAmountTendered[i][10]);
		        	amountTenderPay.setValues(storeAmountTendered[i][0],storeAmountTendered[i][1],storeAmountTendered[i][2],storeAmountTendered[i][3],storeAmountTendered[i][4],storeAmountTendered[i][5],storeAmountTendered[i][6],storeAmountTendered[i][7],storeAmountTendered[i][8],storeAmountTendered[i][9],storeAmountTendered[i][10]);
		        	
		        	//output the amount tendered
		        	System.out.println("Amount tendered: " + moneyFormat.format(amountTenderPay.valueOfPayment())); 
		        	

		        	//initialize variables for calculating the change
		        	float changes = amountTenderPay.valueOfPayment() - cost.elementAt(i);
		      	    Payment changesOutput = newRegister.transact(cost.elementAt(i), amountTenderPay);
		      	    notesInSystem = newRegister.currentFloat();
		        	
		        	//check whether or not the money paid achieved the cost of goods
		        	if(amountTenderPay.valueOfPayment() >= cost.elementAt(i))
		        	{
		        		//output change
		        		System.out.println("Change: " + moneyFormat.format(changes) + "\n" + changesOutput.registerFiveC + " " + changesOutput.registerTenC + " " + changesOutput.registerTwentyC + " "  + changesOutput.registerFiftyC + " " + changesOutput.registerOneD + " " + changesOutput.registerTwoD + " " + changesOutput.registerFiveD + " " + changesOutput.registerTenD + " " + changesOutput.registerTwentyD + " " + changesOutput.registerFiftyD + " " + changesOutput.registerHundredD + "\n");
		        	}//if yes, output the change and the types of notes of cash return from the system
		        	else
		        	{
		        		moneyOwed = (cost.elementAt(i)) - (amountTenderPay.valueOfPayment());
		        		System.err.println("ERROR! Money paid did not reach to the cost, still " + moneyFormat.format(moneyOwed) + " left.\n");
		        	}//if no, output ERROR message and display how much left
		        }
		        in.close();
	        }
	        else
	        {
	        	hasEnoughCash = false;
	        	System.err.println("ERROR! The system has not enough cash for changes.");
	        }
	      } catch(IOException e) {
	    	  System.err.println("ERROR! The system cannot input " + e.getMessage() + ".");
	      }
	}
}
