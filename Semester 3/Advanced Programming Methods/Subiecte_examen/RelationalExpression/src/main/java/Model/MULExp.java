package Model;

import Exceptions.InterpreterException;

public class MULExp implements IExp{
    private final IExp exp1;
    private final IExp exp2;

    public MULExp(IExp exp1, IExp exp2){
        this.exp1 = exp1;
        this.exp2 = exp2;
    }

    @Override
    public String toString() {
        return String.format("MUL(%s, %s)", exp1, exp2);
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException {
        IExp converted = new ArithExp(2,
                new ArithExp(3, exp1, exp2),
                new ArithExp(1, exp1, exp2));
        return converted.eval(symTable, heap);
    }

    @Override
    public IExp deepCopy() {
        return new MULExp(exp1.deepCopy(), exp2.deepCopy());
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type1 = exp1.typeCheck(typeEnv);
        Type type2 = exp2.typeCheck(typeEnv);
        if (type1.equals(new IntType()) && type2.equals(new IntType())){
            return new IntType();
        }
        else {
            throw new InterpreterException("The expressions must have the same type");
        }
    }
}
