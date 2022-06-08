
public class Hw2_p4 {

	// implement reverse method
	// you may want to write a separate method with additional parameters, which is recursive
	
	public static void reverse(DoublyLinkedList<Integer> intList) {
		if (intList.isEmpty()) {
			return;
		}
		Integer p = intList.removeFirst();
		reverse(intList);
		intList.addLast(p);
		// complete this method
	}
	
	// use the main method for testing
	// test with arrays of different lenghts
	public static void main(String[] args) {

		
		DoublyLinkedList<Integer> intList = new DoublyLinkedList<>();
		
		int[] a = {10, 20, 30, 40, 50};
		for (int i=0; i<a.length; i++) {
			intList.addLast(a[i]);
		}
		System.out.println("Initial list: size = " + intList.size() + ", " + intList.toString());
		
		// Here, invoke the reverse method you implemented above
		reverse(intList);
		
		System.out.println("After reverse: " + intList.toString());
		
		intList = new DoublyLinkedList<>();
		int[] b = {10, 20, 30, 40, 50, 60};
		for (int i=0; i<b.length; i++) {
			intList.addLast(b[i]);
		}
		System.out.println();
		System.out.println("Initial list: size = " + intList.size() + ", " + intList.toString());
		
		// Here, invoke the reverse method you implemented above
		reverse(intList);
		
		System.out.println("After reverse: " + intList.toString());

	}

}
