package Model;

import Exceptions.InterpreterException;

public class AssignStmt implements IStmt{
    private final String id;
    private IExp exp;

    public AssignStmt(String id, IExp exp){
        this.id = id;
        this.exp = exp;
    }

    @Override
    public String toString(){
        return this.id + "+" + exp.toString();
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        //MyIStack<IStmt> stack = state.getStack();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        if (symTable.isDefined(id)){
            Value value = exp.eval(symTable, state.getHeap());
            Type idType = (symTable.lookUp(id)).getType();
            if(value.getType().equals(idType)){
                symTable.update(id, value);
            }
            else {
                throw new InterpreterException("Variable" + id + "type of assigned expression do not match!");
            }
        }
        else {
            throw new InterpreterException("Variable" + id + "was not declared before!");
        }

        state.setSymTable(symTable);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type typeVar = typeEnv.lookUp(id);
        Type typeExp = exp.typeCheck(typeEnv);
        if (typeVar.equals(typeExp)){
            return typeEnv;
        }
        else{
            throw new InterpreterException("Assignment: right hand side and left hand side have different types!");
        }
    }

    @Override
    public IStmt deepCopy(){
        return new AssignStmt(id, exp.deepCopy());
    }
}
