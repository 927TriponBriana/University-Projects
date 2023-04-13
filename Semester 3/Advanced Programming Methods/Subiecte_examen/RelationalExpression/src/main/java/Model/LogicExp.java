package Model;

import Exceptions.InterpreterException;

public class LogicExp implements IExp{
    IExp expression1;
    IExp expression2;
    int operation;

    public LogicExp(int operation, IExp expression1, IExp expression2){
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.operation = operation;
    }

    @Override
    public Value eval(MyIDictionary<String, Value>symTable, MyIHeap heap) throws InterpreterException {
        Value value1, value2;
        value1 = this.expression1.eval(symTable, heap);
        if(value1.getType().equals(new BoolType())){
            value2 = this.expression2.eval(symTable, heap);
            if(value2.getType().equals(new BoolType())){
                BoolValue bool1 = (BoolValue)value1;
                BoolValue bool2 = (BoolValue)value2;
                boolean b1, b2;
                b1 = bool1.getValue();
                b2 = bool2.getValue();
                if(this.operation == 1){
                    return new BoolValue(b1 && b2);
                }
                else if(this.operation == 2){
                    return new BoolValue(b1 || b2);
                }
            }
            else{
                throw new InterpreterException("Second operand is not a boolean!");
            }
        }
        else{
            throw new InterpreterException("First operand is not a boolean!");
        }
        return null;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type1, type2;
        type1 = expression1.typeCheck(typeEnv);
        type2 = expression2.typeCheck(typeEnv);
        if (type1.equals(new BoolType())){
            if (type2.equals(new BoolType())){
                return new BoolType();
            }
            else{
                throw new InterpreterException("Second operator is not a boolean!");
            }
        }
        else{
            throw new InterpreterException("First operand is not a boolean!");
        }
    }

    @Override
    public IExp deepCopy(){
        return new LogicExp(operation, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operation + " " + expression2.toString();
    }
}
