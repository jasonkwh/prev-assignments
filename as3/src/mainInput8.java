/** Assignment 3 (please wait for processing and displaying the pg2852.txt for 3mins+)
 *
 * @author Jason Huang
 * @version 1.0 Jan 24, 2012.
 * @description please wait for processing and displaying the pg2852.txt for 3mins+, secondFilter() takes most of the time.
 */

import java.io.*;
import java.util.Collections;
import java.util.Vector;

public class mainInput8 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
	        /*
	         * INPUT
	         */
			
			//input data from a text file
			FileInputStream data = new FileInputStream("data.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str;
	        String str2 = "";
	        String[] strArray; //String array for storing the original string
	        Vector<String> myVect = new Vector<String>();

	        while ((str = reader.readLine())!= null)
	        {
	        	str2 += str + " ";
	        }
	        
	        str2 = str2.replaceAll("--", " ");
	        strArray = str2.toLowerCase().split(" "); //split string by space to array (also change all characters to lower case)
	        
	        /*
	         * FILTER (e.g. "?", "." and numbers)
	         */
	        
	        for(int i=0;i<strArray.length;i++)
	        {
	        	strArray[i] = strArray[i].replaceAll("[\\]\\[.,\"\\?!%$@#^:'()+*/0-9]", "");
	        	
	        	if(!strArray[i].equals(""))
	        		myVect.add(strArray[i]);
	        }//filter non-alphabet characters, "", and then add to temporary vector
	        
	        /*
	         * SORTING ¡]Sort words with unique length by alphabet order)
	         */
	        
	        Collections.sort(myVect);
	        strArray = myVect.toArray(new String[myVect.size()]);
	        myVect.removeAllElements(); //clear for next use
	        
	        /*
	         * SORTING ¡]By word length)
	         */
	        
	        String temp;
	       	
	       	for(int i=0;i<strArray.length;i++)
	    	{
	   			for(int j=0;j<strArray.length-1-i;j++)
	   			{
	   				if(strArray[j].length()<strArray[j+1].length())
    				{
	   					temp = strArray[j];
	   					strArray[j] = strArray[j+1];
	   					strArray[j+1] = temp;
	   				}
    			}
	   		}//sorting words by the length of each words in descending orders

	       	/*
	       	 * FILTER (For the words starting at "-")
	       	 */
	       	
	        for(int i=0;i<strArray.length;i++)
		    {
	        	if(!strArray[i].equals(""))
	        		myVect.add(strArray[i] + " (" + occurrences(strArray,strArray[i]) + ")");
		    }//add the non "" array element to vector, "" is changed by occurrences
	        
	        strArray = myVect.toArray(new String[myVect.size()]);
	        myVect.removeAllElements(); //clear for next use
	        
	        for(int i=0;i<strArray.length;i++)
	       	{
	        	strArray[i] = thirdFilter(secondFilter(strArray[i]));
	        	
	        	if(!strArray[i].equals(""))
	        		myVect.add(strArray[i]);
	       	}
	        
	        /*
	       	 * OUTPUT
	       	 */
	        
	        if(myVect.size()>5)
	        {
	        	for(int i=0;i<5;i++)
	        	{
	        		System.out.println(myVect.elementAt(i));
	        	}
	        	
	        	System.out.println("");
	        	
	        	for(int i=myVect.size()-5;i<myVect.size();i++)
	        	{
	        		System.out.println(myVect.elementAt(i));
	        	}
	        }
	        else if(myVect.size()==5)
	        {
	        	for(int i=0;i<myVect.size();i++)
	        	{
	        		System.out.println(myVect.elementAt(i));
	        	}
	        }
	        else if(myVect.size()==1)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only 1 word)");
	        }
	        else if(myVect.size()==0)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (No words)");
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only " + myVect.size() + " different words)");
	        }
	        
	        input.close();
		}
		catch(IOException e)
		{
			System.err.println("WARNING: " + e.getMessage());
			}
	}
	
	public static int occurrences(String[] array, String target)
	{
		int count = 0;
		
		for(int i=0;i<array.length;i++)
		{
			if(array[i].equals(target))
			{
				count++;
				array[i]=""; //change repeated string to "" so they cannot be inserted to the finalStr (Vector)
			}
		}
		return count;
	} //calculate the frequencies
	
	public static String secondFilter(String arrayElement)
	{
		if(arrayElement.charAt(0)=='-')
		{
			Vector<String> delFirstCross = new Vector<String>();
       		String s2 = "";
       	
       		for(int i=0;i<arrayElement.length();i++)
       		{
       			delFirstCross.add(Character.toString(arrayElement.charAt(i))); //using vector to remove elements
       		}
       		
       		delFirstCross.removeElementAt(0);
       			
       		for(int i=0;i<delFirstCross.size();i++)
       		{
       			s2+=delFirstCross.elementAt(i);
       		}
       		delFirstCross.removeAllElements(); //clear the temporary vector
       		
       		return secondFilter(s2);
		}
		else
		{
			return arrayElement;
		}
	}//recursive function to delete "-" or "--" or "---....." at the beginning of each word
	
	public static String thirdFilter(String testString)
	{
		Vector<String> delSpace = new Vector<String>();
       	String s2 = "";
       	
       	for(int i=0;i<testString.length();i++)
       	{
       		delSpace.add(Character.toString(testString.charAt(i)));
       	}
       	
       	if(delSpace.elementAt(0).equals(" "))
       	{
       		return s2;
		}
       	else if(delSpace.elementAt(0).equals("h") && delSpace.elementAt(1).equals("t") && delSpace.elementAt(2).equals("t") && delSpace.elementAt(3).equals("p"))
       	{
       		return s2;
       	}//delete the web addresses (starting at http..)
		else
		{
			return testString;
		}//delete the words of "" (which was created by secondFilter())
	}
}