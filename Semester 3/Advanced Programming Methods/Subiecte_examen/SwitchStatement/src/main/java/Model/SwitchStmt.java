package Model;

import Exceptions.InterpreterException;

public class SwitchStmt implements IStmt{
    private final IExp exp;
    private final IExp exp1;
    private final IStmt stmt1;
    private final IExp exp2;
    private final IStmt stmt2;
    private final IStmt defaultStmt;

    public SwitchStmt(IExp exp, IExp exp1, IStmt stmt1, IExp exp2, IStmt stmt2, IStmt defaultStmt){
        this.exp = exp;
        this.exp1 = exp1;
        this.stmt1 = stmt1;
        this.exp2 = exp2;
        this.stmt2 = stmt2;
        this.defaultStmt = defaultStmt;
    }

    @Override
    public String toString() {
        return String.format("switch(%s){(case(%s): %s)(case(%s): %s)(default: %s)}", exp, exp1, stmt1, exp2, stmt2, defaultStmt);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIStack<IStmt> exeStack = state.getExeStack();
        IStmt converted = new IfStmt(new RelationalExp("==", exp, exp1),
                stmt1, new IfStmt(new RelationalExp("==", exp, exp2), stmt2, defaultStmt));
        exeStack.push(converted);
        state.setExeStack(exeStack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new SwitchStmt(exp.deepCopy(), exp1.deepCopy(),  stmt1.deepCopy(), exp2.deepCopy(), stmt2.deepCopy(), defaultStmt.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type = exp.typeCheck(typeEnv);
        Type type1 = exp1.typeCheck(typeEnv);
        Type type2 = exp2.typeCheck(typeEnv);
        if (type.equals(type1) && type.equals(type2)){
            stmt1.typeCheck(typeEnv.deepCopy());
            stmt2.typeCheck(typeEnv.deepCopy());
            defaultStmt.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else {
            throw new InterpreterException("The expression types do not match in the switch statement");
        }
    }
}
