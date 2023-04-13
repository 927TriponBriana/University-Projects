package Model;

import Exceptions.InterpreterException;

public class NewStmt implements IStmt{
    private String varName;
    private IExp expression;

    public NewStmt(String varName, IExp expression){
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public String toString() {
        return String.format("New(%s, %s)", varName, expression);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap heap = state.getHeap();
        if (!symTable.isDefined(varName)){
            throw new InterpreterException(String.format("%s not in symTable", varName));
        }
        Value varValue = symTable.lookUp(varName);
        if (!(varValue.getType() instanceof RefType)){
            throw new InterpreterException(String.format("%s is not of RefType", varName));
        }
        Value evaluated = expression.eval(symTable, heap);
        Type locationType = ((RefValue)varValue).getLocationType();
        if (!locationType.equals(evaluated.getType())){
            throw new InterpreterException(String.format("%s not of %s", varName, evaluated.getType()));
        }
        int newPosition = heap.add(evaluated);
        symTable.put(varName, new RefValue(newPosition, locationType));
        state.setSymTable(symTable);
        state.setHeap(heap);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type typeVar = typeEnv.lookUp(varName);
        Type typeExp = expression.typeCheck(typeEnv);
        if (typeVar.equals(new RefType(typeExp))){
            return typeEnv;
        }
        else{
            throw new InterpreterException("NEW stmt: right hand side and left hand side have different types!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new NewStmt(varName, expression.deepCopy());
    }
}
