package Model;

import Exceptions.InterpreterException;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewLatchStmt implements IStmt{
    private final String var;
    private final IExp exp;
    private static final Lock lock = new ReentrantLock();

    public NewLatchStmt(String var, IExp exp){
        this.var = var;
        this.exp = exp;
    }

    @Override
    public String toString() {
        return String.format("newLatch(%s, %s)", var, exp);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        lock.lock();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyILatchTable latchTable = state.getLatchTable();
        MyIHeap heap = state.getHeap();
        IntValue nr = (IntValue) (exp.eval(symTable, heap));
        int number = nr.getValue();
        int freeAddress = latchTable.getFreeAddress();
        latchTable.put(freeAddress, number);
        if (symTable.isDefined(var)){
            symTable.update(var, new IntValue(freeAddress));
        }
        else{

            throw new InterpreterException(String.format("%s is not defined in the symTable", var));
        }
        lock.unlock();
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new NewLatchStmt(var, exp.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if(typeEnv.lookUp(var).equals(new IntType())){
            if(exp.typeCheck(typeEnv).equals(new IntType())){
                return typeEnv;
            }
            else {
                throw new InterpreterException("Expression does not have the int type");
            }
        }
        else {
            throw new InterpreterException(String.format("%s is not of the int type", var));
        }
    }
}
