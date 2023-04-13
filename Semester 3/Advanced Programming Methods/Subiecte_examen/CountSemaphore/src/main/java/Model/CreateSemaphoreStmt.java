package Model;

import Exceptions.InterpreterException;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CreateSemaphoreStmt implements IStmt{
    private final String var;
    private final IExp exp;
    private static final Lock lock = new ReentrantLock();

    public CreateSemaphoreStmt(String var, IExp exp){
        this.var = var;
        this.exp = exp;
    }

    @Override
    public String toString() {
        return String.format("CreateSemaphore(%s, %s)", var, exp);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        lock.lock();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap heap = state.getHeap();
        MyISemaphoreTable semaphoreTable = state.getSemaphoreTable();
        IntValue nr = (IntValue) (exp.eval(symTable, heap));
        int num = nr.getValue();
        int freeAddress = semaphoreTable.getFreeAddress();
        semaphoreTable.put(freeAddress, new Pair<>(num, new ArrayList<>()));
        if (symTable.isDefined(var) && symTable.lookUp(var).getType().equals(new IntType())){
            symTable.update(var, new IntValue(freeAddress));
        }
        else{
            throw new InterpreterException(String.format("Variable %s is not defined/it is not of int type", var));
        }
        lock.unlock();
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new CreateSemaphoreStmt(var, exp.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (typeEnv.lookUp(var).equals(new IntType())) {
            if (exp.typeCheck(typeEnv).equals(new IntType())) {
                return typeEnv;
            } else {
                throw new InterpreterException("The expression is not of int type");
            }
        }
        else{
            throw new InterpreterException(String.format("%s is not of int type", var));
        }
    }
}
