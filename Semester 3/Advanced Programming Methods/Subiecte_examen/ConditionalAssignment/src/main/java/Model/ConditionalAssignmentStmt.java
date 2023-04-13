package Model;

import Exceptions.InterpreterException;

public class ConditionalAssignmentStmt implements IStmt{
    private final String var;
    private final IExp exp1;
    private final IExp exp2;
    private final IExp exp3;

    public ConditionalAssignmentStmt(String var, IExp exp1, IExp exp2, IExp exp3){
        this.var = var;
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.exp3 = exp3;
    }

    @Override
    public String toString() {
        return String.format("%s=(%s)?%s: %s", var, exp1, exp2, exp3);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIStack<IStmt> exeStack = state.getExeStack();
        IStmt converted = new IfStmt(exp1, new AssignStmt(var, exp2), new AssignStmt(var, exp3));
        exeStack.push(converted);
        state.setExeStack(exeStack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ConditionalAssignmentStmt(var, exp1.deepCopy(), exp2.deepCopy(), exp3.deepCopy());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type varType = new VarExp(var).typeCheck(typeEnv);
        Type type1 = exp1.typeCheck(typeEnv);
        Type type2 = exp2.typeCheck(typeEnv);
        Type type3 = exp3.typeCheck(typeEnv);
        if (type1.equals(new BoolType()) && type2.equals(varType) && type3.equals(varType)){
            return typeEnv;
        }
        else{
            throw new InterpreterException("The conditional assignment is not valid");
        }
    }
}
