package Model;

import Exceptions.InterpreterException;

import java.util.HashMap;
import java.util.Set;

public class MyLatchTable implements MyILatchTable{
    private HashMap<Integer, Integer> latchTable;
    private int freeLocation = 0;

    public MyLatchTable(){
        this.latchTable = new HashMap<>();
    }

    @Override
    public void put(Integer key, Integer value) throws InterpreterException {
        synchronized (this){
            if (!latchTable.containsKey(key)){
                latchTable.put(key, value);
            }
            else {
                throw new InterpreterException(String.format("The latchTable already contains key %d", key));
            }
        }
    }

    @Override
    public int get(Integer key) throws InterpreterException {
        synchronized (this){
            if (latchTable.containsKey(key)){
                return latchTable.get(key);
            }
            else {
                throw new InterpreterException(String.format("The latchTable does not contain key %d", key));
            }
        }
    }

    @Override
    public boolean containsKey(Integer key) {
        synchronized (this){
            return latchTable.containsKey(key);
        }
    }

    @Override
    public String toString() {
        return latchTable.toString();
    }

    @Override
    public int getFreeAddress() {
        synchronized (this){
            freeLocation++;
            return freeLocation;
        }
    }

    @Override
    public void setFreeAddress(Integer newFreeAddress) {
        synchronized (this){
            this.freeLocation = newFreeAddress;
        }
    }

    @Override
    public void update(Integer key, Integer value) throws InterpreterException {
        synchronized (this){
            if (latchTable.containsKey(key)){
                latchTable.replace(key, value);
            }
            else{
                throw new InterpreterException(String.format("The latchTable does not contain key %d", key));
            }
        }
    }

    @Override
    public HashMap<Integer, Integer> getLatchTable() {
        synchronized (this){
            return latchTable;
        }
    }

    @Override
    public void setLatchTable(HashMap<Integer, Integer> newLathcTable) {
        synchronized (this){
            this.latchTable = newLathcTable;
        }
    }
}
