package Model;

import Exceptions.InterpreterException;

import java.util.HashMap;
import java.util.Set;

public interface MyILatchTable {

    void put(Integer key, Integer value) throws InterpreterException;
    int get(Integer key) throws InterpreterException;
    boolean containsKey(Integer key);
    int getFreeAddress();
    void setFreeAddress(Integer newFreeAddress);
    void update(Integer key, Integer value) throws InterpreterException;
    HashMap<Integer, Integer> getLatchTable();
    void setLatchTable(HashMap<Integer, Integer> newLathcTable);
}
