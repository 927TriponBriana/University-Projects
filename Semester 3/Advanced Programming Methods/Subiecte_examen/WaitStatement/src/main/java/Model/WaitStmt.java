package Model;

import Exceptions.InterpreterException;

public class WaitStmt implements IStmt{
    private final int value;

    public WaitStmt(int value){
        this.value = value;
    }

    @Override
    public String toString() {
        return String.format("wait(%s)", value);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        if (value != 0){
            MyIStack<IStmt> exeStack = state.getExeStack();
            exeStack.push(new CompStmt(new PrintStmt(new ValueExp(new IntValue(value))),
                    new WaitStmt(value - 1)));
            state.setExeStack(exeStack);
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new WaitStmt(value);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return typeEnv;
    }
}
