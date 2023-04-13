package Model;

import Exceptions.InterpreterException;

public class SleepStmt implements IStmt{
    private final int value;

    public SleepStmt(int value){
        this.value = value;
    }

    @Override
    public String toString() {
        return String.format("sleep(%s)", value);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        if (value != 0){
            MyIStack<IStmt> exeStack = state.getExeStack();
            exeStack.push(new SleepStmt(value - 1));
            state.setExeStack(exeStack);
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new SleepStmt(value);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return typeEnv;
    }
}
