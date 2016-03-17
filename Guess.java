import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;

class Guess {
	Animal anl= new Animal();
	QuestionNode[] qNS= new QuestionNode[3];

	static String DEFAULT_DATA = "animalData"; // Use this for setting up a game.
	
	void makeTree(String _fileName) {
		// This takes the data from a saved game in the file _fileName and builds a game tree ready for playing.
		boolean checkInputFile= false;
		String loadFileName= _fileName; // saveFileName= _fileName; 
		// At the game level.
		BufferedReader inputTree= null;
		try {
			inputTree=	new BufferedReader (
			new FileReader(loadFileName));
			checkInputFile= true;
		} catch(Exception ee) { System.out.println("File not found"); }
		
		QuestionNode temp= new QuestionNode("", null, null);
		if (checkInputFile) {
			System.out.println("Loading tree from textfile '"+loadFileName+ "'");
			for (int i= 0; i<3; i++) qNS[i]= temp.Load(inputTree);
			for (int i=0; i <3; i++) {
				try {
					Thread.sleep(1000);  // For dramatic effect ...
					System.out.print('.');
				} catch(InterruptedException e) { e.printStackTrace(); }
			}
			System.out.println(" done.");
		} else {
			System.out.println("No file '"+loadFileName+"' found: starting from scratch.");
		}
	}
	
	
	// Recursive function that plays the game. 

	void Play(QuestionNode qN, BufferedReader in) { //TODO		
		// Takes a QuestionNode qN and a BufferedReader in (normally defined to be standard input)
		// and plays the game. The BufferedReader takes responses from the player (yes/no) and
		// data for a new node if necessary.
		
		if(qN.yes==null) { //search the left hand side (the yes side), find no nodes, guess correctly
			if(anl.getAnswer(qN.text, "yes,no", in) == 0) {
				//if the ansIndex==0, i.e., this is the final answer that without ","
				System.out.println("GREAT! LET'S PLAY AGAIN"); //if guess correctly, output something
			}
			else if(qN.no==null) {
				//search the right hand side (the no side), find no nodes, which means guess wrong.
				System.out.println("So, what is it?"); //ask the question again
				String n = null;
				try { n = in.readLine().trim(); } //user input, stored in n
				catch(IOException e) {
					System.out.println("Hmm, type again please..");
				} //if input wrong..
				String s = "Is it " + n + "?"; //confirmation, if n is dog, so "Is it dog?"
				String tmp = qN.text; //store the question text in String variable tmp
				String q = "";
				QuestionNode qN2 = new QuestionNode(s,null,null); //this became a new question
				do {
					System.out.println("Give me a 'yes' question for " + n + ": ");
					try {
						q = in.readLine().trim();
					} //asking the user to type 'yes' question
					catch(IOException e) {
						System.out.println("Hmm, type again please..");
					} //if input wrong..
					if(!q.equals(""))
					{
						qN.text = q;
						qN.yes = qN2;
						qN.no = new QuestionNode(tmp,null,null);
						break;
					}
					System.out.println("Give me a 'no' question for " + n + ": ");
					try {
						q = in.readLine().trim();
					}
					catch(IOException e) {
						System.out.println("Hmm, type again please..");
					} //if input wrong..
					if(q.equals("")) {
						continue; //skip....
					}
					qN.text = q;
					qN.no = qN2;
					qN.yes = new QuestionNode(tmp,null,null);
						break;
					}
				while (true);
				System.out.println("Okay, another run.");
			}
		else {
			Play(qN.no,in); //recursive, if no, play again
		}
		}
		else if(anl.getAnswer(qN.text,"yes,no",in)==0)
		{
			Play(qN.yes,in);
		}
		else
		{
			Play(qN.no,in);
		}
	}

	void save(String sFN, QuestionNode qNS[]) { // TODO
	 // This takes the name of an output file sFN and the Animal-Vegetable-Mineral
	 // game trees stored in qNS[] and saves it serially into sFN so that
	 // the Load and makeTree methods together can restore it exactly to qNS[]
		try {
			File newFile = new File(sFN);//create file object
			newFile.createNewFile();//new file
			PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(newFile.getAbsoluteFile())));
			//output to file sFN
			
			System.out.println("Saving game...");
			for(int i=0;i<3;i++) //i<3 because the length of qNS[] is 3
			{
				out.write(qNS[i].toString());
			}
			System.out.println("DONE");
			out.close(); //close output
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}

	void mergeGames(Guess q1, Guess q2) {
 		// Assume that these two nodes are not null.
 		if (q1!=null && q2!=null) {
 			qNS[0]= merge(q1.qNS[0], q2.qNS[0]);
 			qNS[1]= merge(q1.qNS[1], q2.qNS[1]);
 			qNS[2]= merge(q1.qNS[2], q2.qNS[2]);
 		}
 	}
	   
	QuestionNode merge(QuestionNode qN1, QuestionNode qN2) { //TODO
		// Take two separate databases (outputs from the game "main") and merge them
		// into one. The idea is that several groups can play separately (initially
		// individual people) and then by merging again and again make bigger
		// and bigger databases that will be interesting/amusing to a larger
		// constituency.
		if(qN1==null) {
			return qN2;
		}
		if(qN2==null) {
			return qN1;
		}
		if(qN1.text.equals(qN2.text)) { //if same question, then same yes and no
			return new QuestionNode(qN1.text, merge(qN1.yes, qN2.yes),merge(qN1.no,qN2.no));
		}
		if(qN1.yes == null) //if qN1 guess correct
		{
			return new QuestionNode(qN2.text, merge(qN1, qN2.yes),merge(qN1,qN2.no));
		}
		if(qN2.yes == null) { //if qN2 guess correct
			return new QuestionNode(qN1.text, merge(qN1.yes, qN2),merge(qN1.no,qN2));
		}
		if(qN1.yes == null & qN2.yes == null) { //if both correct
			return new QuestionNode(qN1.text,null,qN2);
		}
		else
		{
			return new QuestionNode(qN1.text, merge(qN2,qN1.yes), merge(qN2,qN1.no));
		}
	}
		
	QuestionNode clean(QuestionNode qN, String answersSoFar) {//TODO
		//For use after a merge, to remove duplicate answers.
		if(qN==null)
			return null; // To suppress warning
		return null; // To suppress warning
	}
 }

