package Model;

import Exceptions.InterpreterException;

public class RepeateUntilStmt implements IStmt{
    private final IStmt stmt;
    private final IExp exp;

    public RepeateUntilStmt(IStmt stmt, IExp exp){
        this.stmt = stmt;
        this.exp = exp;
    }

    @Override
    public String toString() {
        return String.format("repeate(%s) until (%s)", stmt, exp);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIStack<IStmt> exeStack = state.getExeStack();
        IStmt convert = new CompStmt(stmt, new WhileStmt(new NotExp(exp), stmt));
        exeStack.push(convert);
        state.setExeStack(exeStack);
        return null;

    }

    @Override
    public IStmt deepCopy() {
        return new RepeateUntilStmt(stmt.deepCopy(), exp.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type = exp.typeCheck(typeEnv);
        if (type.equals(new BoolType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException("The expression in the repeat staatement must be of bool type");
        }
    }
}
