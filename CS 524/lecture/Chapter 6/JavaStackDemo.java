package Stack;
import java.util.Stack;

public class JavaStackDemo {

	public static void main(String[] args) {
		// stack of integers
		//Stack<Integer> intStack = new Stack<>();
		LinkedStack<Integer> intStack = new LinkedStack<Integer>();
		intStack.push(10);
		System.out.println("Stack after push 10: " + intStack);
		intStack.push(20);
		System.out.println("Stack after push 20: " + intStack);
		intStack.push(30);
		System.out.println("Stack after push 30: " + intStack);
		System.out.println("The top element is: " + intStack.peek() + " (not removed)");
		System.out.println("Stack after peek: " + intStack);
		System.out.println("Top element is: " + intStack.pop() + " (removed)");
		System.out.println("Stack after pop: " + intStack);
		System.out.println("Is stack empty? " + intStack.empty());
		System.out.println("Number of elements is " + intStack.size());
		
		
	}

}