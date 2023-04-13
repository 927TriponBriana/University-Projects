package Model;

import Exceptions.InterpreterException;

public class NotExp implements IExp{
    private final IExp exp;

    public NotExp(IExp exp){
        this.exp = exp;
    }

    @Override
    public String toString() {
        return String.format("!(%s)", exp);
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException {
        BoolValue value = (BoolValue) exp.eval(symTable, heap);
        if (!value.getValue()){
            return new BoolValue(true);
        }
        else {
            return new BoolValue(false);
        }
    }

    @Override
    public IExp deepCopy() {
        return new NotExp(exp.deepCopy());
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        return exp.typeCheck(typeEnv);
    }
}
