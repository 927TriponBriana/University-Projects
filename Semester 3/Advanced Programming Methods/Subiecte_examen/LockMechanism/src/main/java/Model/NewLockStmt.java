package Model;

import Exceptions.InterpreterException;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewLockStmt implements IStmt{
    private final String var;
    private static final Lock lock = new ReentrantLock();

    public NewLockStmt(String var){
        this.var = var;
    }

    @Override
    public String toString() {
        return String.format("newLock(%s)", var);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        lock.lock();
        MyILockTable lockTable = state.getLockTable();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        int freeAddress = lockTable.getFreeValue();
        lockTable.put(freeAddress, -1);
        if (symTable.isDefined(var) && symTable.lookUp(var).getType().equals(new IntType())){
            symTable.update(var, new IntValue(freeAddress));
        }
        else {
            throw new InterpreterException("Variable is not decared");
        }
        lock.unlock();
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new NewLockStmt(var);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (typeEnv.lookUp(var).equals(new IntType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException("Var is not if the int type");
        }
    }
}
