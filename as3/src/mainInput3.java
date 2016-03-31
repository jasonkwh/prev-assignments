/** Assignment 3
 *
 * @author Jason Huang
 * @version 1.3 Jan 21, 2012.
 */

import java.io.*;
import java.util.ArrayList;

public class mainInput3 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			//input data from a text file
			FileInputStream data = new FileInputStream("data5.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str;
	        String str2 = "";
	        String[] strArray; //String array for storing the original string
	        
	        while ((str = reader.readLine())!= null)
	        {
	        	str2 += str + " ";
	        }//INPUT
	        
	        strArray = str2.toLowerCase().split(" "); //split string by space to array (also change all characters to lower case)
	        
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
	        
	        if(strArray.length>=5)
	        {
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

	        	//OUTPUT
	        	for(int i=0;i<5;i++)
		        {
	        		if(strArray[i]!="")
	        			System.out.println(strArray[i] + " (" + occurrences(strArray,strArray[i]) + ")");
		        }
	        	
	        	System.out.println("");
	        	
	        	for(int i=strArray.length-6;i<strArray.length-1;i++)
		        {
	        		if(strArray[i]!="")
	        			System.out.println(strArray[i] + " (" + occurrences(strArray,strArray[i]) + ")");
		        }
	        	
	    		System.out.println("\nWords count: " + strArray.length);
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 words for calculations in the text file (Only " + strArray.length + " words)");
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
				array[i]="";
			}
		}
		return count;
	}
}