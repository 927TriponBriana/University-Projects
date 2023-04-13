package Model;

import Exceptions.InterpreterException;

public class VarDeclStmt implements IStmt{
    String name;
    Type type;

    public VarDeclStmt(String name, Type type){
        this.name = name;
        this.type = type;
    }

    @Override
    public String toString(){
        return this.name + " " + type.toString();
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        if(symTable.isDefined(name)){
            throw new InterpreterException("Variable" + name + "already exists!");
        }
        symTable.put(name, type.defaultValue());
        state.setSymTable(symTable);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        typeEnv.put(name, type);
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return new VarDeclStmt(name, type);
    }
}
