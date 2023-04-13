package Model;


import Exceptions.InterpreterException;

public class IfStmt implements IStmt{
    IExp exp;
    IStmt thenStmt;
    IStmt elseStmt;

    public IfStmt(IExp exp, IStmt thenStmt, IStmt elseStmt){
        this.exp = exp;
        this.thenStmt = thenStmt;
        this.elseStmt = elseStmt;
    }

    @Override
    public String toString(){
        return "(IF(" + exp.toString() + ")THEN(" + thenStmt.toString() + ")ELSE(" + elseStmt.toString()+"))";
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        Value result = this.exp.eval(state.getSymTable(), state.getHeap());

        if(result instanceof BoolValue boolResult){
            IStmt stmt;
            if(boolResult.getValue()){
                stmt = thenStmt;
            }
            else{
                stmt = elseStmt;
            }
            MyIStack<IStmt> stack = state.getExeStack();
            stack.push(stmt);
            state.setExeStack(stack);
            return null;
        }
        else{
            throw new InterpreterException("Boolean expression needed in an if statement!");
        }
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type typeExp = exp.typeCheck(typeEnv);
        if (typeExp.equals(new BoolType())){
            thenStmt.typeCheck(typeEnv.deepCopy());
            elseStmt.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else{
            throw new InterpreterException("The condition of IF has not the type bool!");
        }
    }

    @Override
    public IStmt deepCopy(){
        return new IfStmt(exp.deepCopy(), thenStmt.deepCopy(), elseStmt.deepCopy());
    }
}
