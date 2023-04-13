package Model;

import Exceptions.InterpreterException;
import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;

public class MySemaphoreTable implements MyISemaphoreTable{
    private HashMap<Integer, Pair<Integer, List<Integer>>> semaphoreTable;
    private int freeLocation = 0;

    public MySemaphoreTable(){
        this.semaphoreTable = new HashMap<>();
    }

    @Override
    public void put(int key, Pair<Integer, List<Integer>> value) throws InterpreterException {
        synchronized (this){
            if (!semaphoreTable.containsKey(key)){
                semaphoreTable.put(key, value);
            }
            else {
                throw new InterpreterException(String.format("The key %d is already in the semaphoreTwsble", key));
            }
        }
    }

    @Override
    public Pair<Integer, List<Integer>> get(int key) throws InterpreterException {
        synchronized (this){
            if (semaphoreTable.containsKey(key)){
                return semaphoreTable.get(key);
            }
            else {
                throw new InterpreterException(String.format("The key %d is not in the semaphoreTable"));
            }
        }
    }

    @Override
    public boolean containsKey(int key) {
        synchronized (this){
            return semaphoreTable.containsKey(key);
        }
    }

    @Override
    public int getFreeAddress() {
        synchronized (this){
            freeLocation++;
            return freeLocation;
        }
    }

    @Override
    public void setFreeAddress(int freeAddress) {
        synchronized (this){
            this.freeLocation = freeAddress;
        }
    }

    @Override
    public void update(int key, Pair<Integer, List<Integer>> value) throws InterpreterException {
        synchronized (this){
            if (semaphoreTable.containsKey(key)){
                semaphoreTable.put(key, value);
            }
            else{
                throw new InterpreterException(String.format("Key %d is not in the semaphoreTable", key));
            }
        }
    }

    @Override
    public HashMap<Integer, Pair<Integer, List<Integer>>> getSemaphoreTable() {
        synchronized (this){
            return this.semaphoreTable;
        }
    }

    @Override
    public void setSemaphoreTable(HashMap<Integer, Pair<Integer, List<Integer>>> newSemaphoreTable) {
        synchronized (this){
            this.semaphoreTable = newSemaphoreTable;
        }
    }
}
