package Model;

import Exceptions.InterpreterException;

import java.util.Objects;

public class RelationalExp implements IExp{
    IExp exp1;
    IExp exp2;
    String operator;

    public RelationalExp(String operator, IExp exp1, IExp exp2){
        this.exp1=exp1;
        this.exp2=exp2;
        this.operator=operator;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException {
        Value value1;
        Value value2;
        value1 = this.exp1.eval(symTable, heap);
        if(value1.getType().equals(new IntType())){
            value2 = this.exp2.eval(symTable, heap);
            if (value2.getType().equals(new IntType())){
                IntValue val1 = (IntValue) value1;
                IntValue val2 = (IntValue) value2;
                int v1, v2;
                v1=val1.getValue();
                v2=val2.getValue();
                if(Objects.equals(this.operator, "<")){
                    return new BoolValue(v1<v2);
                }
                else if(Objects.equals(this.operator, "<=")){
                    return new BoolValue(v1<=v2);
                }
                else if(Objects.equals(this.operator, "==")){
                    return new BoolValue(v1==v2);
                }
                else if(Objects.equals(this.operator, "!=")){
                    return new BoolValue(v1!=v2);
                }
                else if(Objects.equals(this.operator, ">")){
                    return new BoolValue(v1>v2);
                }
                else if(Objects.equals(this.operator, ">=")){
                    return new BoolValue(v1>=v2);
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
        type1 = exp2.typeCheck(typeEnv);
        type2 = exp2.typeCheck(typeEnv);
        if (type1.equals(new IntType())){
            if (type2.equals(new IntType())){
                return new BoolType();
            }
            else{
                throw new InterpreterException("Second operand is not an integer!");
            }
        }
        else{
            throw new InterpreterException("First operand is not an integer!");
        }
    }

    @Override
    public IExp deepCopy(){
        return new RelationalExp(operator, exp1.deepCopy(), exp2.deepCopy());
    }

    @Override
    public String toString() {
        return this.exp1.toString() + " " + this.operator + " " + this.exp2.toString();
    }
}
