package Model;

import Exceptions.InterpreterException;

public class NopStmt implements IStmt{
    @Override
    public PrgState execute(PrgState state){
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return typeEnv;
    }

    @Override
    public String toString(){
        return "NopStatement";
    }

    @Override
    public IStmt deepCopy(){
        return new NopStmt();
    }
}
