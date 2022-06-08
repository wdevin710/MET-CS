package MyPrograms;

public class SampleProgram2 {

	// no argument, no return value
	public static void printWelcome() {
		System.out.println("Welcome to CS526");
		System.out.println();
	}
	
	// argument, no return value
	public static void positiveEvenLessThanN(int N) {
		int i;
		for (i=1; i<N; i++) {
			if ((i %2) == 0)
				System.out.print(i + " ");
		}
		System.out.println();
		System.out.println();
	}
	
	// argument, return value
	public static int largest(int[] a) {
		int max = 0;
		for (int i=0; i<a.length; i++) {
			if (a[i] > max)
				max = a[i];
		}
		
		return max;
	}
	
	public static void main(String[] args) {
		
		System.out.println("Main method invokes other methods");
		System.out.println();
		
		printWelcome();
		positiveEvenLessThanN(25);
		
		int[] intArray = {5, 25, 87, 46, 10, 36, 27};
		System.out.println("Largest number is " + largest(intArray));
		
	}

}