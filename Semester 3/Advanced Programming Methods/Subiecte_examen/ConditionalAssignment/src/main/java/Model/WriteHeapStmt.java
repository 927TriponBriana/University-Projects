package Model;

import Exceptions.InterpreterException;

public class WriteHeapStmt implements IStmt{
    private String varName;
    private IExp expression;

    public WriteHeapStmt(String varName, IExp expression){
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public String toString() {
        return String.format("WriteHeap(%s, %s)", varName, expression);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap heap = state.getHeap();
        if (symTable.isDefined(varName)){
            Value value = symTable.lookUp(varName);
            if (value.getType() instanceof RefType){
                RefValue refValue = (RefValue) value;
                if (heap.containsKey(refValue.getAddress())){
                    Value evaluated = expression.eval(symTable, heap);
                    if (evaluated.getType().equals(refValue.getLocationType())){
                        heap.update(refValue.getAddress(), evaluated);
                        state.setHeap(heap);
                    }
                    else {
                        throw new InterpreterException(String.format("%s not of %s", evaluated, refValue.getLocationType()));
                    }
                }
                else{
                    throw new InterpreterException(String.format("RefValue %s is not defined in the heap!", value));
                }
            }
            else{
                throw new InterpreterException(String.format("%s is not of RefType", value));
            }
        }
        else{
            throw new InterpreterException(String.format("%s is not present in the symTable", varName));
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (typeEnv.lookUp(varName).equals(new RefType(expression.typeCheck(typeEnv)))){
            return typeEnv;
        }
        else{
            throw new InterpreterException("WriteHeapStmt: right hand side and left hand side have different types!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new WriteHeapStmt(varName, expression.deepCopy());
    }
}
