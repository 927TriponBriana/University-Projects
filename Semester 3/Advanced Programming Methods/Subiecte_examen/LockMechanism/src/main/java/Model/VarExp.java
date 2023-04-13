package Model;

import Exceptions.InterpreterException;

public class VarExp implements IExp{
    String id;

    public VarExp(String id){
        this.id = id;
    }

    @Override
    public Value eval(MyIDictionary<String, Value>symTable, MyIHeap heap) throws InterpreterException {
        return symTable.lookUp(id);
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return typeEnv.lookUp(id);
    }

    @Override
    public IExp deepCopy(){
        return new VarExp(id);
    }

    @Override
    public String toString(){
        return id;
    }
}
