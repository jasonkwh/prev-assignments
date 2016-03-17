package memory;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Queue;

import digraph.Digraph;
import digraph.Vertex;

/**
 * COMP225 Assignment 2, Semester 1 2014
 * Garbage Collector Class
 * Original author: Dr Luke Mathieson
 * @author Jason 42916186 <jasonkwh@gmail.com>
 * @version 1.0
 */

public class GarbageCollector {

	/**
	 * Basic data members that represent the heap (in the memory sense,
	 * not data structure sense), the call stack and a HashMap to be
	 * used to mark memory objects for the mark(), sweep() and isMarked()
	 * methods. 
	 */
	Digraph heapMemory;
	Deque<Vertex> stackMemory;
	HashMap<Vertex, String> markedObjects;

	/**
	 * Default constructor.
	 */
	public GarbageCollector() {
		// TODO Implement constructor.
		heapMemory = new Digraph();
		stackMemory = new ArrayDeque<Vertex>();
		markedObjects = new HashMap<Vertex, String>();
	}

	/**
	 * A method that adds a new object id to the heap memory,
	 * if this object is already in the memory, do nothing.
	 * PRE: A valid string to be the id for the object.
	 * POST: Either a new object in heap memory, if the id is new,
	 * 		or no change otherwise.
	 * 
	 * @param id
	 */
	public void addHeapObject(String id) {
		// TODO Implement method.
		if(!isInHeapMemory(id)) {
			Vertex heapVertex = new Vertex(id); //vertex with id
			heapMemory.addVertex(heapVertex);
			markedObjects.put(heapVertex, "");
		}
	}
	
	/**
	 * A method that reference the 2 objects fromId and toId.
	 * PRE: Two valid strings, representing the ids of the objects
	 * 		between which the reference is to be created.
	 * POST: The object corresponding to "fromId" should have a new reference
	 * 		(duplicates allowed) to the object corresponding to "toId".
	 * 		If one or neither exist, the method fails silently.
	 * 
	 * @param fromId
	 * @param toId
	 */
	public void addReference(String fromId, String toId) {
		// TODO Implement method.
		Vertex heapVertex = new Vertex(toId);
		heapMemory.getVertex(fromId).addNeighbour(heapVertex);
	}

	/**
	 * A method that adds the object to the stack.
	 * if this object is already in the memory, do nothing.
	 * PRE: A valid string "id".
	 * POST: Either a new object on the top of the stack with id "id",
	 * 		if no object with "id" already exists, otherwise no change.
	 * 
	 * @param id
	 */
	public void addStackObject(String id) {
		// TODO Implement method.
		if(!isInStackMemory(id)) {
			heapMemory.addVertex(id);
			stackMemory.add(heapMemory.getVertex(id));
		}
	}

	/**
	 * Performs the basic mark and sweep garbage collection routine.
	 * PRE: none.
	 * POST: The heap should not contain any object that cannot be reached
	 * 		from the stack by following references.
	 */
	public void collectGarbage() {
		// TODO Implement method.
		mark();
		sweep();
	}
	
	/**
	 * Helper method that returns the number of objects in the heap.
	 * @return size of used heap memory
	 */
	public int heapUse() {
		// TODO Implement method.
		return heapMemory.size();
	}

	/**
	 * A method that returns true if the heap contains an object id, false otherwise.
	 * @param id
	 * @return true if the heap contains an object id, false otherwise.
	 */
	public boolean isInHeapMemory(String id) {
		// TODO Implement method.
		if(heapMemory.getVertex(id)==null) {
			return false;
		} else return true;
	}

	/**
	 * A method that returns true if the memory contains an object id, false otherwise.
	 * @param id
	 * @return true if the memory contains an object id, false otherwise.
	 */
	public boolean isInMemory(String id) {
		// TODO Implement method.
		if(isInHeapMemory(id) || isInStackMemory(id))
			return true;
		else return false;
	}

	/**
	 * A method that returns true if the stack contains an object id, false otherwise.
	 * @param id
	 * @return true if the stack contains an object id, false otherwise.
	 */
	public boolean isInStackMemory(String id) {
		// TODO Implement method.
		for(Vertex v: stackMemory) {
			if(v.getID().equals(id)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * A method that returns true, if the vertex is marked (within markedObjects),
	 * false otherwise.
	 * @param id
	 * @return true, if the vertex is marked, false otherwise.
	 */
	public boolean isMarked(String id) {
		// TODO Implement method.
		Vertex getVertex = heapMemory.getVertex(id);
		if(markedObjects.get(getVertex).equalsIgnoreCase(""))
				return false;
		else return true;
	}

	/**
	 * A method to mark all the vertex in use.
	 * PRE: none.
	 * POST: Every object reachable by following references from the stack should
	 * 		be marked, all other objects should not be marked.
	 */
	public void mark() {
		// TODO Implement method.
		//associate all vertex to ""
		ListIterator<Vertex> it = heapMemory.vertices();
		while(it.hasNext()){
			Vertex current= it.next();
			markedObjects.put(current, "");
		}
		//traversal
		Iterator<Vertex> startingPoints= stackMemory.iterator();
		while(startingPoints.hasNext()){
			Vertex current= startingPoints.next();
			marking(current);
		}
	}
	
	/**
	 * Put vertex to markedObjects, which is going to mark.
	 * @param current
	 */
	private void marking(Vertex current) {
		markedObjects.put(current, "marked");
		ListIterator<Vertex> nebs = current.neighbours();
		while(nebs.hasNext()) {
			marking(nebs.next());
		}
	}

	/**
	 * Method that returns the memory used.
	 * @return the size of of the total memory used
	 */
	public int memUse() {
		// TODO Implement method.
		return heapMemory.size();
	}
	
	/**
	 * Removes the object with id from memory if it exists.
	 * PRE: A valid string "id".
	 * POST: Memory either has one less object, where that object has id "id",
	 * 		otherwise no change.
	 * @param id 
	 */
	public void removeObject(String id) {
		// TODO Implement method.
		if(isInHeapMemory(id))
			heapMemory.removeVertex(id);
	}

	/**
	 * Removes a reference between the objects corresponding to
	 * "fromId" and "toId" if the objects exists and such a reference
	 * exists.
	 * Both fromId and toId must exist, otherwise the method fails.
	 * PRE: Two valid strings, representing the ids of the objects
	 * 		between which the reference is to be created.
	 * POST: The object corresponding to "fromId" should have one less
	 * 		reference to the object corresponding to "toId".
	 * 		If one or neither exist, or the reference doesn't exist,
	 * 		the method fails silently.
	 * @param fromId
	 * @param toId
	 */
	public void removeReference(String fromId, String toId) {
		// TODO Implement method.
		if(isInHeapMemory(fromId) && isInHeapMemory(toId))
			heapMemory.getVertex(fromId).removeNeighbour(toId);
	}

	/**
	 * Helper method that returns the number of objects in the stack.
	 * @return the size of the stack memory.
	 */
	public int stackUse() {
		// TODO Implement method.
		return stackMemory.size();
	}

	/**
	 * Remove the object vertices that was marked.
	 * Implements the sweep phase of the mark and sweep algorithm.
	 * Scans memory and removes anything that is not marked.
	 * PRE: Memory has passed through the mark phase of the algorithm.
	 * POST: Memory contains no unmarked objects.
	 */
	public void sweep() {
		ListIterator<Vertex> it = heapMemory.vertices();
		ArrayList<Vertex> toRemove = new ArrayList<Vertex>();
		
		while(it.hasNext()){
			Vertex current = it.next();
			if(!markedObjects.get(current).equals("marked")){
				toRemove.add(current);
			}
		}
		
		for(int i=0;i<toRemove.size();i++) {
			heapMemory.removeVertex(toRemove.get(i));
		}
	}
}
