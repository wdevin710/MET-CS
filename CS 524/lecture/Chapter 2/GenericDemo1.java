public class GenericDemo1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GenericQueue<Integer> integerQueue = new GenericQueue<>();
		GenericQueue<String> stringQueue = new GenericQueue<>();
		
		integerQueue.enqueue(10);
		integerQueue.enqueue(20);
		integerQueue.enqueue(30);
		System.out.println("Integer queue before dequeue: " + integerQueue.toString());
		integerQueue.dequeue();
		System.out.println("Integer queue after dequeue: " + integerQueue.toString());
		
		stringQueue.enqueue("Data");
		stringQueue.enqueue("Structure");
		stringQueue.enqueue("Algorithm");
		System.out.println("String queue before dequeue: " + stringQueue);
		stringQueue.dequeue();
		System.out.println("String queue before dequeue: " + stringQueue);

	}

}