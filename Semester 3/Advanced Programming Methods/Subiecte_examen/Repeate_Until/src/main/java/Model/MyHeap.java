package Model;

import Exceptions.InterpreterException;

import java.util.HashMap;
import java.util.Set;

public class MyHeap implements MyIHeap{
    HashMap<Integer, Value> heap;
    Integer freeLocationValue;

    public int newValue(){
        freeLocationValue += 1;
        while (freeLocationValue == 0 || heap.containsKey(freeLocationValue)){
            freeLocationValue += 1;
        }
        return freeLocationValue;
    }

    public MyHeap(){
        this.heap = new HashMap<>();
        freeLocationValue = 1;
    }

    @Override
    public int getFreeValue() {
        return freeLocationValue;
    }

    @Override
    public HashMap<Integer, Value> getContent() {
        return heap;
    }

    @Override
    public void setContent(HashMap<Integer, Value> newMap) {
        this.heap = newMap;
    }

    @Override
    public int add(Value value) {
        heap.put(freeLocationValue, value);
        Integer toReturn = freeLocationValue;
        freeLocationValue = newValue();
        return toReturn;
    }

    @Override
    public void update(Integer position, Value value) throws InterpreterException {
        if (!heap.containsKey(position)){
            throw new InterpreterException(String.format("%d is not in the heap!", position));
        }
        heap.put(position, value);
    }

    @Override
    public Value get(Integer position) throws InterpreterException {
        if (!heap.containsKey(position)){
            throw new InterpreterException(String.format("%d is not in the heap!", position));
        }
        return heap.get(position);
    }

    @Override
    public boolean containsKey(Integer position) {
        return this.heap.containsKey(position);
    }

    @Override
    public void remove(Integer position) throws InterpreterException {
        if (!containsKey(position)){
            throw new InterpreterException(position + " is not defined!");
        }
        freeLocationValue = position;
        this.heap.remove(position);
    }

    @Override
    public Set<Integer> keySet() {
        return heap.keySet();
    }

    @Override
    public String toString(){
        return this.heap.toString();
    }
}
