import java.util.Arrays;

public class InsertionSortChar {

	public static void insertionSort(char[ ] data) {
		int n = data.length;
		for (int k = 1; k < n; k++) {    // begin with second element
		    char cur = data[k];          // save data[k] in cur
		    int j = k;                   
		    while (j > 0 && data[j-1] > cur) {  // find correct index j for cur
		        data[j] = data[j-1];            
		        j--;                            
		    } // while
		    data[j] = cur;     // this is the proper place for cur
		 } // for
	}

	public static void main(String[] args) {
		
		char[] charArray = {'B', 'C', 'D', 'A', 'E', 'H', 'G', 'F'};
		System.out.println("Before sorting: " + Arrays.toString(charArray));
		System.out.println();
		
		insertionSort(charArray);
		System.out.println("After sorting: " + Arrays.toString(charArray));
	}

}