package MyPrograms;

import java.util.Arrays;
import java.util.Random;

public class ArrayExample {

	public static int sumOfSquaresOfEven(int[] a) {
		int sos = 0;
		for (int i=0; i<a.length; i++) {
			if ((a[i] % 2) == 0) {
				sos += a[i] * a[i];
			}
		}
		return sos;
	}
	
	public static void main(String[] args) {
		
		
		int [ ] intArray = new int[5];
		for (int i=0; i<intArray.length; i++) {
			intArray[i] = i;
		}
		System.out.println("intArray = " + Arrays.toString(intArray));
		
		int sos = sumOfSquaresOfEven(intArray);
		System.out.println("Sum of squares of even numbers = " + sos);
		
		
		int data[] = new int[10];
		Random rand = new Random();
		rand.setSeed(System.currentTimeMillis());
		// populate data array with random integers < 100
		for (int i = 0; i < data.length; i++)
			data[i] = rand.nextInt(100);
		
		// print data array
		System.out.println("data = " + Arrays.toString(data));
		
		// create a subarray of data with data[2] thru data[7]
		int [] dataSubarray = Arrays.copyOfRange(data, 2, 8);  // note 8 is excluded
		
		// print the subarray
		System.out.println("dataSubarray = " + Arrays.toString(dataSubarray));
		
		// make a copy of data array
		int[] dataCopy = Arrays.copyOf(data, data.length);
		
		// print copy of data array
		System.out.println("dataCopy = " + Arrays.toString(dataCopy));
		
		// sort dataCopy
		Arrays.sort(dataCopy);
		
		// print sorted dataCopy
		System.out.println("sorted dataCopy = " + Arrays.toString(dataCopy));
		
	}

}