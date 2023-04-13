package Model;

import Exceptions.InterpreterException;

public class ArithExp implements IExp{
    IExp expression1;
    IExp expression2;
    int operation;

    public ArithExp(int operation, IExp expression1, IExp expression2){
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.operation = operation;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException{
        Value value1, value2;
        value1 = this.expression1.eval(symTable, heap);
        if(value1.getType().equals(new IntType())){
            value2 = this.expression2.eval(symTable, heap);
            if(value2.getType().equals(new IntType())){
                IntValue int1 = (IntValue)value1;
                IntValue int2 = (IntValue)value2;
                int n1, n2;
                n1 = int1.getValue();
                n2 = int2.getValue();
                if(this.operation == 1){
                    return new IntValue(n1+n2);
                }
                if(this.operation == 2){
                    return new IntValue(n1-n2);
                }
                if(this.operation == 3){
                    return new IntValue(n1*n2);
                }
                if(this.operation == 4){
                    if(n2 == 0)
                    {
                        throw new InterpreterException("Division by zero!");
                    }
                    else{
                        return new IntValue(n1/n2);
                    }
                }

            }
            else{
                throw new InterpreterException("Second operand is not an integer!");
            }
        }
        else{
            throw new InterpreterException("First operand is not an integer!");
        }
        return null;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type1, type2;
        type1 = expression1.typeCheck(typeEnv);
        type2 = expression2.typeCheck(typeEnv);
        if(type1.equals(new IntType())){
            if (type2.equals(new IntType())){
                return new IntType();
            }
            else{
                throw new InterpreterException("Second operand is not an integer!");
            }
        }
        else{
            throw new InterpreterException("First operand in not an integer!");
        }
    }

    @Override
    public IExp deepCopy() {
        return new ArithExp(operation, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operation + " " + expression2.toString();
    }
}
