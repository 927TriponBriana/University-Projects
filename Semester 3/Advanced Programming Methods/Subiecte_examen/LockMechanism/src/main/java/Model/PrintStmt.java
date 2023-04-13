package Model;

import Exceptions.InterpreterException;

public class PrintStmt implements IStmt{
    IExp exp;

    public PrintStmt(IExp exp){
        this.exp = exp;
    }

    @Override
    public String toString(){
        return "print(" + exp.toString() + ")";
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIList <Value> output = state.getOut();
        output.add(exp.eval(state.getSymTable(), state.getHeap()));
        state.setOut(output);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        exp.typeCheck(typeEnv);
        return typeEnv;
    }

    @Override
    public IStmt deepCopy(){
        return new PrintStmt(exp.deepCopy());
    }


}
