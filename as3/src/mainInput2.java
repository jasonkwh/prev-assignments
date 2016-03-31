/** Assignment 3
 *
 * @author Jason Huang
 * @version 1.0 Jan 20, 2012.
 */

import java.io.*;
import java.util.StringTokenizer;
import java.util.Vector;

public class mainInput2 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			//input data from a text file
			FileInputStream data = new FileInputStream("data4.txt");
			DataInputStream input = new DataInputStream(data);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			
	        String str; //original string
	        String tokenizedString = ""; //filtered string for filter step 1
	        String tokenizedString2 = ""; //filtered string for filter step 2
	        String tokenizedString3 = ""; //filtered string for filter step 3
	        String tokenizedString4 = ""; //filtered string for filter step 4
	        Vector<String> dataVector = new Vector<String>(); //using vector<String> to store each filtered words
	        
	        while ((str = reader.readLine())!= null)
	        {
	        	//step 1, filter any "'"
	        	StringTokenizer token = new StringTokenizer(str,"'");
	        	
	        	while(token.hasMoreTokens())
	        	{
	        		tokenizedString = token.nextToken();
	        	}
	        	
	        	//step 2, filter any ","
	        	StringTokenizer token2 = new StringTokenizer(tokenizedString,",");
	        	
	        	while(token2.hasMoreTokens())
	        	{
	        		tokenizedString2 = token2.nextToken();
	        	}
	        	
	        	//step 3, filter any "."
	        	StringTokenizer token3 = new StringTokenizer(tokenizedString2,".");
	        	
	        	while(token3.hasMoreTokens())
	        	{
	        		tokenizedString3 = token3.nextToken();
	        	}
	        	
	        	//step 4, filter any " "
	        	StringTokenizer token4 = new StringTokenizer(tokenizedString3," ");
	        	
	        	while(token4.hasMoreTokens())
	        	{
	        		tokenizedString4 = token4.nextToken();
	        		dataVector.add(tokenizedString4.toLowerCase()); //insert each filtered string to vector and also change to lower case.
	        	}//FILTER
	        }
	        
	        if(dataVector.size()>=5)
	        {
	        	//sorting words by the length of each words in descending orders
	        	String[] dataArray = new String[dataVector.size()]; //using String array to store each filtered words
	        	String temp;
	        	
	        	//insert from vector to array
	        	for(int i=0;i<dataArray.length;i++)
	        	{
	        		dataArray[i] = dataVector.elementAt(i);
	        	}
	    		
	    		for(int i=0;i<dataArray.length;i++)
	    		{
	    			for(int j=0;j<dataArray.length-1-i;j++)
	    			{
	    				
	    				if(dataArray[j].length()<dataArray[j+1].length())
	    				{
	    					temp = dataArray[j];
	    					dataArray[j] = dataArray[j+1];
	    					dataArray[j+1] = temp;
	    				}
	    			}
	    		}
	    		
	    		//output
	    		for(int i=0;i<dataArray.length;i++)
	    		{
	    			System.out.println(dataArray[i]);
	    		}
	    		
		        System.out.println(dataVector);
		        //System.out.println("The length of 15th word ('" + dataVector.elementAt(14) + "') is: " + dataVector.elementAt(14).length() + ".");
		        System.out.println("Words count: " + dataVector.size());
	        }
	        else
	        {
	        	System.err.println("WARNING: There should be at least 5 words in the text file (" + dataVector.size() + "words)");
	        }
		}
		catch(IOException e)
		{
			System.err.println("WARNING: " + e.getMessage());
			}
	}

}
