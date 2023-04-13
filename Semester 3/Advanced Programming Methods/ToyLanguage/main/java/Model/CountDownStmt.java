package Model;

import Exceptions.InterpreterException;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CountDownStmt implements IStmt{
    private final String var;
    private static final Lock lock = new ReentrantLock();

    public CountDownStmt(String var){
        this.var = var;
    }

    @Override
    public String toString() {
        return String.format("contDown(%s)", var);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        lock.lock();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyILatchTable latchTable = state.getLatchTable();
        if (symTable.isDefined(var)){
            IntValue fi = (IntValue) symTable.lookUp(var);
            int foundIndex = fi.getValue();
            if (latchTable.containsKey(foundIndex)){
                if (latchTable.get(foundIndex) > 0){
                    latchTable.update(foundIndex, latchTable.get(foundIndex) - 1);
                }
                state.getExeStack().push(new PrintStmt(new ValueExp(new IntValue(state.getId()))));
            }
            else {
                throw new InterpreterException("Index not found in the latchTable");
            }
        }
        else{
            throw new InterpreterException("Variable was not defined");
        }
        lock.unlock();
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new CountDownStmt(var);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (typeEnv.lookUp(var).equals(new IntType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException(String.format("%s is not of the type int", var));
        }
    }
}
