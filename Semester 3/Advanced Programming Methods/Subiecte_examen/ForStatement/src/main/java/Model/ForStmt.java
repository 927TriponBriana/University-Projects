package Model;

import Exceptions.InterpreterException;

public class ForStmt implements IStmt{
    private final String var;
    private final IExp exp1;
    private final IExp exp2;
    private final IExp exp3;
    private final IStmt stmt;

    public ForStmt(String var, IExp exp1, IExp exp2, IExp exp3, IStmt stmt){
        this.var = var;
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.exp3 = exp3;
        this.stmt = stmt;
    }

    @Override
    public String toString() {
        return String.format("for(%s=%s; %s<%s; %s=%s) {%s}", var, exp1, var, exp2, var, exp3, stmt);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIStack<IStmt> exeStack = state.getExeStack();
        IStmt converted = new CompStmt(new AssignStmt("v", exp1),
                new WhileStmt(new RelationalExp("<", new VarExp("v"), exp2),
                        new CompStmt(stmt, new AssignStmt("v", exp3))));
        exeStack.push(converted);
        state.setExeStack(exeStack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ForStmt(var, exp1.deepCopy(), exp2.deepCopy(), exp3.deepCopy(), stmt.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type1 = exp1.typeCheck(typeEnv);
        Type type2 = exp2.typeCheck(typeEnv);
        Type type3 = exp3.typeCheck(typeEnv);
        if (type1.equals(new IntType()) && type2.equals(new IntType()) && type3.equals(new IntType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException("The expressions of the for statement do not have the same type");
        }
    }
}
