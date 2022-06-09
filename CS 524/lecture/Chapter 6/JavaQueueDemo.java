package Queue;
import java.util.Queue;
import java.util.LinkedList;

public class JavaQueueDemo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//Queue<String> stringQueue = new LinkedList<>();
		LinkedQueue<String> stringQueue = new LinkedQueue<String>();

		stringQueue.offer("one");
		System.out.println("Queue after offer one " + stringQueue);
		stringQueue.offer("two");
		System.out.println("Queue after offer two " + stringQueue);
		stringQueue.offer("three");
		System.out.println("Queue after offer three " + stringQueue);
		System.out.println("Front element is: " + stringQueue.peek() + " (not removed)");
		System.out.println("Queue after peek " + stringQueue);
		System.out.println("Front element is: " + stringQueue.poll() + " (removed)");
		System.out.println("Queue after poll " + stringQueue);
		System.out.println("Is queue empty? " + stringQueue.isEmpty());
		System.out.println("Number of elements is " + stringQueue.size());
		
	}

}