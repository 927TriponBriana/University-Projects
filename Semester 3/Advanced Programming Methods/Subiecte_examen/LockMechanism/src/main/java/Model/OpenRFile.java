package Model;

import Exceptions.InterpreterException;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class OpenRFile implements IStmt{
    private IExp exp;

    public OpenRFile(IExp exp){
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        Value value = exp.eval(state.getSymTable(), state.getHeap());
        if (value.getType().equals(new StringType())){
            StringValue fileName = (StringValue) value;
            MyIDictionary<String, BufferedReader> fileTable = state.getFileTable();
            if (!fileTable.isDefined(fileName.getValue())){
                BufferedReader br;
                try{
                    br = new BufferedReader(new FileReader(fileName.getValue()));
                }
                catch (FileNotFoundException exception){
                    throw new InterpreterException(String.format("%s could not be opened", fileName.getValue()));
                }
                fileTable.put(fileName.getValue(), br);
                state.setFileTable(fileTable);
            }
            else{
                throw new InterpreterException(String.format("%s is already opened", fileName.getValue()));
            }
        }
        else{
            throw new InterpreterException(String.format("%s it is not a string type", exp.toString()));
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (exp.typeCheck(typeEnv).equals(new StringType())){
            return typeEnv;
        }
        else{
            throw new InterpreterException("OpenRfile requires a string expression!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new OpenRFile(exp.deepCopy());
    }

    @Override
    public String toString() {
        return String.format("OpenRFile(%s)", exp.toString());
    }
}
