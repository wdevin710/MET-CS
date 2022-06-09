import java.util.Arrays;

public class GenericDemo3 {

	public static <T> T[] firstN(T[] data, int n){
		T[] subarray = (T[]) new Object[n];
		for (int i=0; i<n; i++){
			subarray[i] = data[i];
		}
		return subarray;
	}
	
	public static void main(String[] args) {
		String[] names = new String[]{"john", "susan", "molly"};
		System.out.print("names: ");
		for (int i=0; i<names.length; i++){
			System.out.print(names[i] + " ");
		}
		
		GenericDemo2.reverse(names);
		System.out.print("\nnames reversed: ");
		for (int i=0; i<names.length; i++){
			System.out.print(names[i] + " ");
		}
		
		Integer[] integers = new Integer[]{10, 20, 30, 40, 50};
		System.out.print("\nintegers: ");
		for (int i=0; i<integers.length; i++){
			System.out.print(integers[i] + " ");
		}
				
		GenericDemo2.reverse(integers);
		System.out.print("\nintegers reversed: ");
		for (int i=0; i<integers.length; i++){
			System.out.print(integers[i] + " ");
		}
		
		Character[] chars = new Character[]{'a', 'b', 'c', 'd', 'e', 'f'};
		System.out.print("\nchars: ");
		for (int i=0; i<chars.length; i++){
			System.out.print(chars[i] + " ");
		}
		GenericDemo2.reverse(chars);
		System.out.print("\nchars reversed: ");
		for (int i=0; i<chars.length; i++){
			System.out.print(chars[i] + " ");
		}
				
		System.out.println();
		System.out.println("First 3 elements of intArray is " + Arrays.toString(firstN(integers,3)));
		System.out.println("First 2 elements of charArray is " + Arrays.toString(firstN(chars,2)));
		
	}

}