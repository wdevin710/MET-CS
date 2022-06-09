/**
 * Implementation of a positional list stored as a doubly linked list.
 *
 * @author Michael T. Goodrich
 * @author Roberto Tamassia
 * @author Michael H. Goldwasser
 */

/*
 * LinkedPositionalList was modifed to use Node instead of Position
 */
 
import java.util.Iterator;
import java.util.NoSuchElementException;

public class NodeLinkedList<E> {
  //---------------- nested Node class ----------------
  /**
   * Node of a doubly linked list, which stores a reference to its
   * element and to both the previous and next node in the list.
   */
  protected static class Node<E> {

    /** The element stored at this node */
    private E element;               // reference to the element stored at this node

    /** A reference to the preceding node in the list */
    private Node<E> prev;            // reference to the previous node in the list

    /** A reference to the subsequent node in the list */
    private Node<E> next;            // reference to the subsequent node in the list

    /**
     * Creates a node with the given element and next node.
     *
     * @param e  the element to be stored
     * @param p  reference to a node that should precede the new node
     * @param n  reference to a node that should follow the new node
     */
    public Node(E e, Node<E> p, Node<E> n) {
      element = e;
      prev = p;
      next = n;
    }

    // public accessor methods
    /**
     * Returns the element stored at the node.
     * @return the stored element
     * @throws IllegalStateException if node not currently linked to others
     */
    public E getElement() throws IllegalStateException {
      if (next == null)                         // convention for defunct node
        throw new IllegalStateException("Node no longer valid");
      return element;
    }

    /**
     * Returns the node that precedes this one (or null if no such node).
     * @return the preceding node
     */
    public Node<E> getPrev() {
      return prev;
    }

    /**
     * Returns the node that follows this one (or null if no such node).
     * @return the following node
     */
    public Node<E> getNext() {
      return next;
    }

    // Update methods
    /**
     * Sets the node's element to the given element e.
     * @param e    the node's new element
     */
    public void setElement(E e) {
      element = e;
    }

    /**
     * Sets the node's previous reference to point to Node n.
     * @param p    the node that should precede this one
     */
    public void setPrev(Node<E> p) {
      prev = p;
    }

    /**
     * Sets the node's next reference to point to Node n.
     * @param n    the node that should follow this one
     */
    public void setNext(Node<E> n) {
      next = n;
    }
  } //----------- end of nested Node class -----------

  // instance variables of the LinkedNodealList
  /** Sentinel node at the beginning of the list */
  private Node<E> header;                       // header sentinel

  /** Sentinel node at the end of the list */
  private Node<E> trailer;                      // trailer sentinel

  /** Number of elements in the list (not including sentinels) */
  private int size = 0;                         // number of elements in the list

  /** Constructs a new empty list. */
  public NodeLinkedList() {
    header = new Node<>(null, null, null);      // create header
    trailer = new Node<>(null, header, null);   // trailer is preceded by header
    header.setNext(trailer);                    // header is followed by trailer
  }

  /**
   * Returns the given node as a Node, unless it is a sentinel, in which case
   * null is returned (so as not to expose the sentinels to the user).
   */
	/*
	 * private Node<E> position(Node<E> node) { if (node == header || node ==
	 * trailer) return null; // do not expose user to the sentinels return node; }
	 */
  // public accessor methods
  /**
   * Returns the number of elements in the list.
   * @return number of elements in the list
   */
 
  public int size() { return size; }

  /**
   * Tests whether the list is empty.
   * @return true if the list is empty, false otherwise
   */
 
  public boolean isEmpty() { return size == 0; }

  /**
   * Returns the first Node in the list.
   *
   * @return the first Node in the list (or null, if empty)
   */
  
  public Node<E> first() {
    return header.getNext();
  }

  /**
   * Returns the last Node in the list.
   *
   * @return the last Node in the list (or null, if empty)
   */

  public Node<E> last() {
    return trailer.getPrev();
  }

  /**
   * Returns the Node immediately before Node p.
   * @param n   a Node of the list
   * @return the Node of the preceding element (or null, if n is first)
   * @throws IllegalArgumentException if n is not a valid node
   */
 
  public Node<E> before(Node<E> n) throws IllegalArgumentException {
    return n.getPrev();
  }

  /**
   * Returns the Node immediately after Node n.
   * @param n   a Node of the list
   * @return the Node of the following element (or null, if n is last)
   * @throws IllegalArgumentException if n is not a valid node for this list
   */
 
  public Node<E> after(Node<E> n) throws IllegalArgumentException {
    return n.getNext();
  }

  // private utilities
  /**
   * Adds an element to the linked list between the given nodes.
   * The given predecessor and successor should be neighboring each
   * other prior to the call.
   *
   * @param pred     node just before the location where the new element is inserted
   * @param succ     node just after the location where the new element is inserted
   * @return the new element's node
   */
  private Node<E> addBetween(E e, Node<E> pred, Node<E> succ) {
    Node<E> newest = new Node<>(e, pred, succ);  // create and link a new node
    pred.setNext(newest);
    succ.setPrev(newest);
    size++;
    return newest;
  }

  // public update methods
  /**
   * Inserts an element at the front of the list.
   *
   * @param e the new element
   * @return the Node representing the location of the new element
   */
 
  public Node<E> addFirst(E e) {
    return addBetween(e, header, header.getNext());       // just after the header
  }

  /**
   * Inserts an element at the back of the list.
   *
   * @param e the new element
   * @return the Node representing the location of the new element
   */

  public Node<E> addLast(E e) {
    return addBetween(e, trailer.getPrev(), trailer);     // just before the trailer
  }

  /**
   * Inserts an element immediately before the given Node.
   *
   * @param p the Node before which the insertion takes place
   * @param e the new element
   * @return the Node representing the location of the new element
   * @throws IllegalArgumentException if p is not a valid position for this list
   */
  
  public Node<E> addBefore(Node<E> node, E e)
                                throws IllegalArgumentException {
    return addBetween(e, node.getPrev(), node);
  }

  /**
   * Inserts an element immediately after the given Node.
   *
   * @param p the Node after which the insertion takes place
   * @param e the new element
   * @return the Node representing the location of the new element
   * @throws IllegalArgumentException if p is not a valid position for this list
   */

  public Node<E> addAfter(Node<E> node, E e)
                                throws IllegalArgumentException {
    return addBetween(e, node, node.getNext());
  }

  /**
   * Replaces the element stored at the given Node and returns the replaced element.
   *
   * @param p the Node of the element to be replaced
   * @param e the new element
   * @return the replaced element
   * @throws IllegalArgumentException if p is not a valid position for this list
   */
    public E set(Node<E> node, E e) throws IllegalArgumentException {
    E answer = node.getElement();
    node.setElement(e);
    return answer;
  }

  /**
   * Removes the element stored at the given Node and returns it.
   * The given position is invalidated as a result.
   *
   * @param p the Node of the element to be removed
   * @return the removed element
   * @throws IllegalArgumentException if p is not a valid position for this list
   */
   public E remove(Node<E> node) throws IllegalArgumentException {
    Node<E> predecessor = node.getPrev();
    Node<E> successor = node.getNext();
    predecessor.setNext(successor);
    successor.setPrev(predecessor);
    size--;
    E answer = node.getElement();
    node.setElement(null);           // help with garbage collection
    node.setNext(null);              // and convention for defunct node
    node.setPrev(null);
    return answer;
  }

  // support for iterating either positions and elements
  //---------------- nested NodeIterator class ----------------
  /**
   * A (nonstatic) inner class. Note well that each instance
   * contains an implicit reference to the containing list,
   * allowing us to call the list's methods directly.
   */
  private class NodeIterator implements Iterator<Node<E>> {

    /** A Node of the containing list, initialized to the first position. */
    private Node<E> cursor = first();   // node of the next element to report
    /** A Node of the most recent element reported (if any). */
    private Node<E> recent = null;       // node of last reported element

    /**
     * Tests whether the iterator has a next object.
     * @return true if there are further objects, false otherwise
     */
    public boolean hasNext() { return (cursor != null);  }

    /**
     * Returns the next position in the iterator.
     *
     * @return next position
     * @throws NoSuchElementException if there are no further elements
     */
    public Node<E> next() throws NoSuchElementException {
      if (cursor == null) throw new NoSuchElementException("nothing left");
      recent = cursor;           // element at this position might later be removed
      cursor = after(cursor);
      return recent;
    }

    /**
     * Removes the element returned by most recent call to next.
     * @throws IllegalStateException if next has not yet been called
     * @throws IllegalStateException if remove was already called since recent next
     */
    public void remove() throws IllegalStateException {
      if (recent == null) throw new IllegalStateException("nothing to remove");
      NodeLinkedList.this.remove(recent);         // remove from outer list
      recent = null;               // do not allow remove again until next is called
    }
  } //------------ end of nested NodeIterator class ------------

  //---------------- nested NodeIterable class ----------------
  private class NodeIterable implements Iterable<Node<E>> {
    public Iterator<Node<E>> iterator() { return new NodeIterator(); }
  } //------------ end of nested NodeIterable class ------------

  /**
   * Returns an iterable representation of the list's positions.
   * @return iterable representation of the list's positions
   */
 
  public Iterable<Node<E>> nodes() {
    return new NodeIterable();       // create a new instance of the inner class
  }

  //---------------- nested ElementIterator class ----------------
  /* This class adapts the iteration produced by positions() to return elements. */
  private class ElementIterator implements Iterator<E> {
    Iterator<Node<E>> nodeIterator = new NodeIterator();
    public boolean hasNext() { return nodeIterator.hasNext(); }
    public E next() { return nodeIterator.next().getElement(); } // return element!
    public void remove() { nodeIterator.remove(); }
  }

  /**
   * Returns an iterator of the elements stored in the list.
   * @return iterator of the list's elements
   */
  public Iterator<E> iterator() { return new ElementIterator(); }

  // Debugging code
  /**
   * Produces a string representation of the contents of the list.
   * This exists for debugging purposes only.
   */
  public String toString() {
    StringBuilder sb = new StringBuilder("(");
    Node<E> walk = header.getNext();
    while (walk != trailer) {
      sb.append(walk.getElement());
      walk = walk.getNext();
      if (walk != trailer)
        sb.append(", ");
    }
    sb.append(")");
    return sb.toString();
  }
}