package Model;

import Exceptions.InterpreterException;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFile implements IStmt{
    private IExp exp;

    public CloseRFile(IExp exp){
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        Value value = exp.eval(state.getSymTable(), state.getHeap());
        if (!value.getType().equals(new StringType())){
            throw new InterpreterException(String.format("%s does not evaluate to a string value", exp));
        }
        StringValue fileName = (StringValue) value;
        MyIDictionary<String, BufferedReader> fileTable = state.getFileTable();
        if (!fileTable.isDefined(fileName.getValue())){
            throw new InterpreterException(String.format("%s is not in the FileTable", value));
        }
        BufferedReader br = fileTable.lookUp(fileName.getValue());
        try{
            br.close();
        }
        catch (IOException exception){
            throw new InterpreterException(String.format("Error in closing %s", value));
        }
        fileTable.remove(fileName.getValue());
        state.setFileTable(fileTable);
        return null;
    }

    @Override
    public String toString() {
        return String.format("CloseRFile(%s)", exp.toString());
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (exp.typeCheck(typeEnv).equals(new StringType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException("CloseRFile requires a string expression!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new CloseRFile(exp.deepCopy());
    }
}
