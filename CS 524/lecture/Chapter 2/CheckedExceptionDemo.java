
import java.io.*;
import java.util.Scanner;

public class CheckedExceptionDemo {
	public static void main(String[] args)   /* throws IOException */  {
		String[] words;
		
		Scanner fileInput = null;
		
//		fileInput = new Scanner (new File("sample_words_in.txt"));

		
		  try { fileInput = new Scanner (new File("sample_words_in.txt")); }
		  catch(FileNotFoundException e) { System.out.println("Input file not found");
		  }
		  
		 		 		
		
		while (fileInput.hasNext()){
			words = fileInput.nextLine().split("\\s+");
			for (int i=0; i<words.length; i++){
				System.out.print(words[i] + " ");
			}
			System.out.println();
		}
		fileInput.close();
	}
}