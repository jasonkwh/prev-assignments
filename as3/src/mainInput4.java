/** Assignment 3
 *
 * @author Jason Huang
 * @version 1.0 Jan 21, 2012.
 */

import java.io.*;
import java.util.ArrayList;
import java.util.Vector;

public class mainInput4 {

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
			FileInputStream data = new FileInputStream("data5.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str;
	        String str2 = "";
	        String[] strArray; //String array for storing the original string
	        Vector<String> finalStr = new Vector<String>(); //Vector for storing the final calculation
	        
	        while ((str = reader.readLine())!= null)
	        {
	        	str2 += str + " ";
	        }
	        
	        strArray = str2.toLowerCase().split(" "); //split string by space to array (also change all characters to lower case)
	        
	        /*
	         * FILTER
	         */
	        
	        for(int i=0;i<strArray.length;i++)
	        {
	        	strArray[i] = strArray[i].replaceAll("[^A-Za-z]", "");
	        }//filter all non-alphabet characters
	        
	        ArrayList<String> clearArrayList = new ArrayList<String>();
	        
	        for(String s: strArray)
	        {
	        	if(!s.equals(""))
	        		clearArrayList.add(s);
	        }//using ArrayList for clearing the "" empty array
	        
	        strArray = clearArrayList.toArray(new String[clearArrayList.size()]);
	        
	        /*
	         * SORTING
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
	       	 * OUTPUT
	       	 */
	       	
	        for(int i=0;i<strArray.length;i++)
		    {
	        	if(strArray[i]!="")
	        		finalStr.add(strArray[i] + " (" + occurrences(strArray,strArray[i]) + ")");
		    }//add the non "" array element to vector, "" is changed by occurrences
	        
	        if(finalStr.size()>5)
	        {
	        	for(int i=0;i<5;i++)
	        	{
	        		System.out.println(finalStr.elementAt(i));
	        	}
	        	
	        	System.out.println("");
	        	
	        	for(int i=finalStr.size()-5;i<finalStr.size();i++)
	        	{
	        		System.out.println(finalStr.elementAt(i));
	        	}
	        }
	        else if(finalStr.size()==5)
	        {
	        	for(int i=0;i<finalStr.size();i++)
	        	{
	        		System.out.println(finalStr.elementAt(i));
	        	}
	        }
	        else if(finalStr.size()==1)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only 1 word)");
	        }
	        else if(finalStr.size()==0)
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (No words)");
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 different words in the text file (Only " + finalStr.size() + " different words)");
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
}