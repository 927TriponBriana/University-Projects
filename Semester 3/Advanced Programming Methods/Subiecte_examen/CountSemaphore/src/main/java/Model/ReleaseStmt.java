package Model;

import Exceptions.InterpreterException;
import javafx.util.Pair;

import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReleaseStmt implements IStmt{
    private final String var;
    private static final Lock lock = new ReentrantLock();

    public ReleaseStmt(String var){
        this.var = var;
    }

    @Override
    public String toString() {
        return String.format("Release(%s)", var);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        lock.lock();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyISemaphoreTable semaphoreTable = state.getSemaphoreTable();
        if (symTable.isDefined(var)){
            if (symTable.lookUp(var).getType().equals(new IntType())){
                IntValue fi = (IntValue) symTable.lookUp(var);
                int foundIndex = fi.getValue();
                if (semaphoreTable.getSemaphoreTable().containsKey(foundIndex)){
                    Pair<Integer, List<Integer>> foundSemaphoreTable = semaphoreTable.get(foundIndex);
                    if (foundSemaphoreTable.getValue().contains(state.getId())){
                        foundSemaphoreTable.getValue().remove((Integer) state.getId());
                    }
                    semaphoreTable.update(foundIndex, new Pair<>(foundSemaphoreTable.getKey(), foundSemaphoreTable.getValue()));
                }
                else {
                    throw new InterpreterException("The index is not in the semaphoreTable");
                }
            }
            else{
                throw new InterpreterException("The index is not of int type");
            }
        }
        else{
            throw new InterpreterException("The index is not in the symTable");
        }
        lock.unlock();
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ReleaseStmt(var);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (typeEnv.lookUp(var).equals(new IntType())){
            return typeEnv;
        }
        else {
            throw new InterpreterException(String.format("%s is not of int type", var));
        }
    }
}
