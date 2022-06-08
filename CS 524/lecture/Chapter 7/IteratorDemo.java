import java.util.ArrayList;
import java.util.Iterator;
import java.util.ListIterator;

public class IteratorDemo {

	public static void main(String[] args) {
		
		ArrayList<String> stringList = new ArrayList<>( );
		ArrayList<Integer> integerList = new ArrayList<>( );
		
		stringList.add("Data");
		stringList.add("Structure");
		stringList.add("and");
		stringList.add("Algorithms");
		
		integerList.add(10);
		integerList.add(20);
		integerList.add(30);
		integerList.add(40);

		System.out.println("Print initial sting list: ");
		Iterator<String> stringIterator = stringList.iterator( );
		while (stringIterator.hasNext( ))
		  System.out.print(stringIterator.next( ) + " "); 
		
		// remove using iterator 
		stringIterator = stringList.iterator( );
		while (stringIterator.hasNext( ))
		  if(stringIterator.next( ).equals("and"))
			  stringIterator.remove();
		  
		System.out.println("\n\nAfgter removing \"and\": ");
		stringIterator = stringList.iterator( );
		while (stringIterator.hasNext( ))
		  System.out.print(stringIterator.next( ) + " "); 

		System.out.println("\n\nPrint initial integer list: ");
		Iterator<Integer> integerIterator = integerList.iterator( );
		while (integerIterator.hasNext( ))
		  System.out.print(integerIterator.next( ) + " "); 
		
		// remove using the remove method of ArrayList
		integerList.remove(2);
		  
		System.out.println("\n\nAfgter removing \"30\": ");
		integerIterator = integerList.iterator( );
		while (integerIterator.hasNext( ))
		  System.out.print(integerIterator.next( ) + " ");
		
		
		// List iterator demo
		
		System.out.println("\n\nList iterator demo");
		integerList.clear();
		integerList.add(10);
		integerList.add(20);
		integerList.add(30);
		integerList.add(40);
		integerList.add(50);
		integerList.add(60);
		System.out.println("\nInitial list: " + integerList);
		
		ListIterator<Integer> li;
		li = integerList.listIterator();
		System.out.println("\nFirst element is: " + li.next());
		System.out.println("\nSecond element is: " + li.next());
		
		li = integerList.listIterator(2);
		System.out.println("\nlistIterator(2)");
		System.out.println("\nNext element is: " + li.next());
		li = integerList.listIterator(2);
		System.out.println("\nlistIterator(2)");
		System.out.println("\nPrevious element is: " + li.previous());
		
		li = integerList.listIterator(2);
		System.out.println("\nlistIterator(2)");
		li.add(300);
		System.out.println("\nCurrent list after adding 300: " + integerList);
		System.out.println("\nNext element after adding 300: " + li.next());
		
		li = integerList.listIterator(4);
		System.out.println("\nlistIterator(4)");
		li.add(500);
		System.out.println("\nCurrent list after adding 500: " + integerList);
		
		li = integerList.listIterator(2);
		System.out.println("\nlistIterator(2)");
		System.out.println("\nNext element is: " + li.next());
		li.remove();
		System.out.println("\nCurrent list after remove(): " + integerList);
		
		li = integerList.listIterator(2);
		System.out.println("\nlistIterator(2)");
		System.out.println("\nPrevious element is: " + li.previous());
		li.remove(); 
		System.out.println("\nCurrent list after remove(): " + integerList);

	}

}