/*
 * Assignment 1
 * HUHBD1101, Jason Huang
 * email: jasonkwh@gmail.com
 * Date: November 15, 2011
 */

import java.util.Scanner;

public class encraption {
	public static void main(String[] args) {
		//variable to store the name
		String name;
		
		//initialise a scanner object
		Scanner scan = new Scanner(System.in);
		
		//get the inputs
		System.out.print("Please enter your name: ");
		name=scan.nextLine();
		
		//nameArray is used to store the ASCII value
		int[] nameArray = new int[name.length()];
		
		//call function
		sumASCII(name,nameArray);
		binary(name,nameArray);
		System.out.println(afterCount(name,nameArray));
		System.out.println(uniqueCount(name,nameArray));
	}
	
	//calculate the sum of ASCII value
	public static void sumASCII(String n,int[] nA)
	{
		//Initializes the integer "sum of ASCII"
		int sum = 0;
		
		//calculate the sum of ASCII
		for(int i=0; i<n.length(); i++)
		{
			//convert String to int
			nA[i] = n.charAt(i);
			//calculate the sum of ASCII
			sum+=nA[i];
		}
		//output
		System.out.println(sum);
	}
	
	//calculate the binary and binary counts
	public static void binary(String n,int[] nA)
	{
		//stringArray is used to store the binary value
		String[] stringArray = new String[n.length()];
		//create the new array to store the 'binary count's
		int[] binaryArray = new int[n.length()];
		//create a new string variable to store the array calculations
		String storeArray = "";
		//create a new integer variable to store the array calculations
		int intStoreArray = 0;
		
		//using for loop to calculate the binary and binary counts
		for(int i=0; i<n.length(); i++)
		{
			//convert String to int
			nA[i] = n.charAt(i);
			//convert integer to binary, from http://download.oracle.com/javase/1.5.0/docs/api/java/lang/Integer.html
			stringArray[i] = Integer.toBinaryString(nA[i]);
			//storing 'binary count's into binaryArray
			binaryArray[i] = binaryCount(stringArray[i],'1');
			//convert array to string
			storeArray = storeArray + binaryArray[i];
			//convert string to int, from http://download.oracle.com/javase/1.5.0/docs/api/java/lang/Integer.html
			intStoreArray = Integer.parseInt(storeArray);
		}
		//output
		System.out.println(intStoreArray);
	}
	
	//counts how many 1s in each binary
	public static int binaryCount(String binary, char num)
	{
		//Initializes the binary count
		int bCount = 0;
		//using for loops...
		for(int i=0; i<binary.length(); i++)
		{
			//check each characters in binary string whether is '1' or not
			if(binary.charAt(i) == num)
			{
				//if the character is '1', then increases the binary count bCount
				bCount++;
			}
		}
		return bCount;
	}
	
	public static int afterCount(String n, int[] nA)
	{
		//bad name, it means how many characters is after the first character(in alphabet)
		int aCount = 0;
		//convert all characters in a string to lower case
		String nameLowerCase = n.toLowerCase();
		for(int i=0; i<nameLowerCase.length(); i++)
		{
			//convert String to int
			nA[i] = nameLowerCase.charAt(i);
			if(nA[0]<nA[i])
			{
				aCount++;
			}
		}
		return aCount;
	}
	
	public static int uniqueCount(String n, int[] nA)
	{
		//bad name, it means how many characters is same as the first character(in alphabet)
		int uCount = 0;
		int totalLength = 0;
		//convert all characters in a string to lower case
		String nameLowerCase = n.toLowerCase();
		for(int i=0; i<nameLowerCase.length(); i++)
		{
			//convert String to int
			nA[i] = nameLowerCase.charAt(i);
			for(int j=0; j<nameLowerCase.length(); j++)
			{
				nA[j] = nameLowerCase.charAt(j);
				if(i!=j && nA[i]==nA[j])
				{
					uCount++;
				}
			}
		}
		totalLength = nameLowerCase.length() - uCount/2;
		return totalLength;
	}
}