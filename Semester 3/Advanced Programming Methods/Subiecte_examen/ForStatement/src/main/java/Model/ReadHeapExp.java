package Model;

import Exceptions.InterpreterException;

public class ReadHeapExp implements IExp{
    private final IExp expression;

    public ReadHeapExp(IExp expression){
        this.expression = expression;
    }

    @Override
    public String toString() {
        return String.format("ReadHeap(%s)", expression);
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException {
        Value value = expression.eval(symTable, heap);
        if (value instanceof RefValue) {
            RefValue refValue = (RefValue) value;
            if (heap.containsKey(refValue.getAddress())){
                return heap.get(refValue.getAddress());
            }
            else{
                throw new InterpreterException("The addres is not defined in the heap!");
            }
        }
        else {
            throw new InterpreterException(String.format("%s not of RelType", value));

        }
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type type = expression.typeCheck(typeEnv);
        if (type instanceof RefType){
            RefType refType = (RefType) type;
            return refType.getInner();
        }
        else {
            throw new InterpreterException("The rH argument is not a RefType!");
        }
    }

    public IExp deepCopy() {
        return new ReadHeapExp(expression.deepCopy());
    }
}
