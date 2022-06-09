package Queue;

public class LinkedQueue<E> {

    private Node<E> head;
    private Node<E> tail;
    private int size;

    public LinkedQueue()
    {
        this.size = 0;
        this.head = null;
        this.tail = null;
    }
    public String toString()
    {
        String out = "";
        Node <E> curr = this.head;
        while(curr!=null)
        {
            out += curr.getElement() + ", ";
            curr = curr.getNext();
        }
        return out;
    }
    public int size(){return size;}
    public boolean isEmpty(){return this.size==0;}
    public E poll()
    {
        if(this.head==null) {
            return null;
        }
        else
        {
            Node<E> node = this.head;
            this.head = node.getNext();
            this.size--;
            if(this.size==0)
                this.tail = null;
            return node.getElement();

        }
    }
    public void offer(E data)
    {
        Node<E> newNode = new Node<E>(data);
        this.size++;
        if(this.size==1)
        {
            this.head=newNode;
            this.tail = newNode;
        }else {
            this.tail.setNext(newNode);
            this.tail = newNode;
        }
    }
    public E peek(){
        if(this.head==null)
        {
            return null;
        }else
        {
            return this.head.getElement();
        }
    }



    private class Node<E>{
        private E element;
        private Node next;
        protected Node(E elem)
        {
            this.element = elem;
            this.next = null;
        }
        protected Node(E elem,Node next)
        {
            this.element = elem;
            this.next = next;
        }

        public E getElement(){return element;}
        public Node getNext(){return next;}
        public void setElement(E elem){this.element=elem;}
        public void setNext(Node n){this.next = n;}
    }

}