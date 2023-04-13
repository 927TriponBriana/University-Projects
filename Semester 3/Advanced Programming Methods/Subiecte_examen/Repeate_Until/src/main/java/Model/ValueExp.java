package Model;

import Exceptions.InterpreterException;

public class ValueExp implements IExp{
    Value value;

    public ValueExp(Value value){
        this.value = value;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return value.getType();
    }

    @Override
    public Value eval(MyIDictionary<String, Value>symTable, MyIHeap heap){
        return this.value;
    }

    @Override
    public IExp deepCopy(){
        return new ValueExp(value);
    }

    @Override
    public String toString(){
        return this.value.toString();
    }
}
