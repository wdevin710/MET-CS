public class GenericQueue<E> {
	private java.util.ArrayList<E> list = new java.util.ArrayList<>();
	
	public int size(){
		return list.size();
	}
	public boolean isEmpty(){
		return list.isEmpty();
	}
	public void enqueue(E e){
		list.add(e);
	}
	public E dequeue(){
		E e = list.remove(0);
		return e;
	}
	@Override
	public String toString(){
		return list.toString();
	}
}
