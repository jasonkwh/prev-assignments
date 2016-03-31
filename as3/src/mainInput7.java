/** Assignment 3 (please wait for output of pg2852.txt for 3mins+)
 *
 * @author Jason Huang
 * @version 1.0 Jan 23, 2012.
 * @description can display pg2852.txt but, takes lots of time... (more than 3mins)
 */

import java.io.*;
import java.util.Collections;
import java.util.Vector;

public class mainInput7 {

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
			FileInputStream data = new FileInputStream("data11.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str;
	        String str2 = "";
	        String[] strArray; //String array for storing the original string
	        Vector<String> tempVect = new Vector<String>(); //temporary vector for clearing "" (1st time filter "")
	        Vector<String> tempVect2 = new Vector<String>();

	        while ((str = reader.readLine())!= null)
	        {
	        	str2 += str + " ";
	        }
	        
	        str2 = str2.replaceAll("--", " ");
	        strArray = str2.toLowerCase().split(" "); //split string by space to array (also change all characters to lower case)
	        
	        /*
	         * FILTER
	         */
	        
	        for(int i=0;i<strArray.length;i++)
	        {
	        	strArray[i] = strArray[i].replaceAll("[\\]\\[.,\"\\?!%$@#^:'()+*/0-9]", "");
	        	
	        	if(!strArray[i].equals(""))
	        		tempVect.add(strArray[i]);
	        }//filter non-alphabet characters, "", and then add to temporary vector
	        
	        /*
	         * SORTING ¡]sort words with unique length by alphabet order)
	         */
	        
	        Collections.sort(tempVect);
	        strArray = tempVect.toArray(new String[tempVect.size()]);
	        
	        /*
	         * SORTING ¡]Word Length)
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
	       	 * FILTER (The words starting at "-")
	       	 */
	       	
	        for(int i=0;i<strArray.length;i++)
		    {
	        	if(!strArray[i].equals(""))
	        		tempVect2.add(strArray[i] + " (" + occurrences(strArray,strArray[i]) + ")");
		    }//add the non "" array element to vector, "" is changed by occurrences
	        
	        strArray = tempVect2.toArray(new String[tempVect2.size()]);
	        
	        for(int i=0;i<strArray.length;i++)
	       	{
	        	strArray[i] = secondFilter(strArray[i]);
	       	}
	       	
	        for(int i=0;i<strArray.length;i++)
	        {
	        	System.out.println(strArray[i]);
	        }
	        
	        /*
	       	 * OUTPUT
	       	 */
	        
	        if(strArray.length>5)
	        {
	        	for(int i=0;i<5;i++)
	        	{
	        		System.out.println(strArray[i]);
	        	}
	        	
	        	System.out.println("");
	        	
	        	for(int i=strArray.length-5;i<strArray.length;i++)
	        	{
	        		System.out.println(strArray[i]);
	        	}
	        }
	        else if(strArray.length==5)
	        {
	        	for(int i=0;i<strArray.length;i++)
	        	{
	        		System.out.println(strArray[i]);
	        	}
	        }
	        else if(strArray.length==1)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only 1 word)");
	        }
	        else if(strArray.length==0)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (No words)");
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only " + strArray.length + " different words)");
	        }
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
}