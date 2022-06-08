// import NodeLinkedList.Node if needed

public class InsertionSortLinkedList {

	public static void insertionSort(NodeLinkedList<Integer> list) {
	     Node<Integer> marker = list.first(); // last position known to be sorted
	     while (marker != list.last()) {
	         Node<Integer> pivot = list.after(marker);
	         int value = pivot.getElement();    // number to be placed
	         if (value > marker.getElement())   // pivot is already sorted
	             marker = pivot;
	         else {                             // must relocate pivot
	             Node<Integer> walk = marker;   // find leftmost item greater than value
	             while (walk != list.first() && list.before(walk).getElement() > value)
	            	 walk = list.before(walk);
	             list.remove(pivot);             // remove pivot entry and
	             list.addBefore(walk, value);    // reinsert value in front of walk
	        }
	    }
	}

	
	public static void main(String[] args) {

		NodeLinkedList<Integer> intLinkedList = new NodeLinkedList<>();
		
		intLinkedList.addLast(20);
		intLinkedList.addLast(50);
		intLinkedList.addLast(10);
		intLinkedList.addLast(80);
		intLinkedList.addLast(40);
		intLinkedList.addLast(30);
		intLinkedList.addLast(70);
		intLinkedList.addLast(60);
		
		System.out.println("Before sorting: " + intLinkedList);
		insertionSort(intLinkedList);
		System.out.println("After sorting: " + intLinkedList);

	}

}