package Stack;

public class LinkedStack<E> {

    private Node<E> top;
    private int size;

    public LinkedStack()
    {
        this.size = 0;
        this.top = null;
    }
    public String toString()
    {
        String out = "";
        Node <E> curr = this.top;
        while(curr!=null)
        {
            out += curr.getElement() + ", ";
            curr = curr.getNext();
        }
        return out;
    }
    public int size(){return size;}
    public boolean empty(){return this.size==0;}
    public E pop()
    {
        if(this.top==null)
        {
            return null;
        }else
        {
            Node<E> node = this.top;
            this.top = node.getNext();
            this.size--;
            return node.getElement();

        }
    }
    public void push(E data)
    {
        Node<E> newNode = new Node<E>(data,this.top);
        this.size++;
        this.top = newNode;
    }
    public E peek(){
        if(top==null)
        {
            return null;
        }else
        {
            return this.top.getElement();
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