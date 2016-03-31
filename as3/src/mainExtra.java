/** Assignment 3 Extra (for accurate calculations, but cannot display pg2852.txt)
 *
 * @author Jason Huang
 * @version 1.0 Jan 23, 2012.
 * @description this one cannot display pg2852.txt but it can delete "-" before the word (e.g. "-hour" to "hour")
 */

import java.io.*;
import java.util.Vector;

public class mainExtra {

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
			FileInputStream data = new FileInputStream("pg2852.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str;
	        String str2 = "";
	        String[] strArrayOriginal; //String array for storing the original string
	        Vector<String> tempVect = new Vector<String>(); //temporary vector for clearing "" (1st time filter "")
	        Vector<String> finalStr = new Vector<String>(); //Vector for storing the final calculation (2nd time filter "")
	        
	        while ((str = reader.readLine())!= null)
	        {
	        	str2 += str + " ";
	        }
	        
	        strArrayOriginal = str2.toLowerCase().split(" "); //split string by space to array (also change all characters to lower case)
	        
	        /*
	         * FILTER
	         */
	        
	        for(int i=0;i<strArrayOriginal.length;i++)
	        {
	        	strArrayOriginal[i] = strArrayOriginal[i].replaceAll("[%$.,\"\\?!:'()+*/0-9]", "");
	        	
	        	if(!strArrayOriginal[i].equals(""))
	        		tempVect.add(strArrayOriginal[i]);
	        }//filter non-alphabet characters, "", and then add to temporary vector

	        String[] strArray = new String[tempVect.size()];
	        
	        for(int i=0;i<tempVect.size();i++)
	        {
	        	strArray[i]=tempVect.elementAt(i);
	        }//add the filtered words to an new array for calculations
	        
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
	       	
	       	String[] newStrArray = new String[strArray.length];
	       	
	       	for(int i=0;i<strArray.length;i++)
	       	{
	       		newStrArray[i] = secondFilter(strArray[i]);
	       	}
	       	
	        for(int i=0;i<newStrArray.length;i++)
		    {
	        	if(!newStrArray[i].equals(""))
	        		finalStr.add(newStrArray[i] + " (" + occurrences(newStrArray,newStrArray[i]) + ")");
		    }//add the non "" array element to vector, "" is changed by occurrences
	        
	        /*
	         * SORTING ¡]sort 1st, 2nd, 3rd, 4th, and 5th character from a to z, only 5 times because only need to output 5 character whether largest or smallest)
	         */
	        
	        String[] lastArray = new String[finalStr.size()];
	        
	        for(int i=0;i<finalStr.size();i++)
	        {
	        	lastArray[i] = finalStr.elementAt(i);
	        }
	        
	       	for(int i=0;i<lastArray.length;i++)
	    	{
	   			for(int j=0;j<lastArray.length-1-i;j++)
	   			{
	   				if(lastArray[j].length()==lastArray[j+1].length())
    				{
	   					if(lastArray[j].charAt(0) > lastArray[j+1].charAt(0))
	   					{
			   				temp = lastArray[j];
			   				lastArray[j] = lastArray[j+1];
			   				lastArray[j+1] = temp;
	   					}
	   					else if(lastArray[j].charAt(0)==lastArray[j+1].charAt(0))
	   					{
		   					if(lastArray[j].charAt(1) > lastArray[j+1].charAt(1))
		   					{
				   				temp = lastArray[j];
				   				lastArray[j] = lastArray[j+1];
				   				lastArray[j+1] = temp;
		   					}
		   					
		   					else if(lastArray[j].charAt(1)==lastArray[j+1].charAt(1))
		   					{
			   					if(lastArray[j].charAt(2) > lastArray[j+1].charAt(2))
			   					{
					   				temp = lastArray[j];
					   				lastArray[j] = lastArray[j+1];
					   				lastArray[j+1] = temp;
			   					}
			   					
			   					else if(lastArray[j].charAt(2)==lastArray[j+1].charAt(2))
			   					{
				   					if(lastArray[j].charAt(3) > lastArray[j+1].charAt(3))
				   					{
						   				temp = lastArray[j];
						   				lastArray[j] = lastArray[j+1];
						   				lastArray[j+1] = temp;
				   					}
				   					
				   					else if(lastArray[j].charAt(3)==lastArray[j+1].charAt(3))
				   					{
					   					if(lastArray[j].charAt(4) > lastArray[j+1].charAt(4))
					   					{
							   				temp = lastArray[j];
							   				lastArray[j] = lastArray[j+1];
							   				lastArray[j+1] = temp;
					   					}
				   					}
			   					}
		   					}
	   					}
	   				}
    			}
	   		}//sorting words by first character a to z
	       	
	        /*
	       	 * OUTPUT
	       	 */
	        
	        if(lastArray.length>5)
	        {
	        	for(int i=0;i<5;i++)
	        	{
	        		System.out.println(lastArray[i]);
	        	}
	        	
	        	System.out.println("");
	        	
	        	for(int i=lastArray.length-5;i<lastArray.length;i++)
	        	{
	        		System.out.println(lastArray[i]);
	        	}
	        }
	        else if(lastArray.length==5)
	        {
	        	for(int i=0;i<lastArray.length;i++)
	        	{
	        		System.out.println(lastArray[i]);
	        	}
	        }
	        else if(lastArray.length==1)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only 1 word)");
	        }
	        else if(lastArray.length==0)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (No words)");
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only " + lastArray.length + " different words)");
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