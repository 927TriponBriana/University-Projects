package Model;

import Exceptions.InterpreterException;

import java.io.BufferedReader;
import java.io.IOException;

public class ReadFile implements IStmt{
    private IExp exp;
    private String varName;

    public ReadFile(IExp exp, String varName){
        this.exp = exp;
        this.varName = varName;
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIDictionary<String, BufferedReader> fileTable = state.getFileTable();

        if (symTable.isDefined(varName)){
            Value value = symTable.lookUp(varName);
            if (value.getType().equals(new IntType())){
                value = exp.eval(symTable, state.getHeap());
                if (value.getType().equals(new StringType())){
                    StringValue castValue = (StringValue) value;
                    if (fileTable.isDefined(castValue.getValue())){
                        BufferedReader br = fileTable.lookUp(castValue.getValue());
                        try{
                            String line = br.readLine();
                            if (line == null){
                                line = "0";
                            }
                            symTable.put(varName, new IntValue(Integer.parseInt(line)));
                        }
                        catch (IOException exception){
                            throw new InterpreterException(String.format("Could not read from file %s", castValue));
                        }
                    }
                    else {
                        throw new InterpreterException(String.format("File table does not contain %s", castValue));
                    }
                }
                else {
                    throw new InterpreterException(String.format("%s is not a string type", value));
                }
            }
            else{
                throw new InterpreterException(String.format("%s is not an int type", value));
            }
        }
        else{
            throw new InterpreterException(String.format("%s is not in symTable", varName));
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        if (exp.typeCheck(typeEnv).equals(new StringType())){
            if (typeEnv.lookUp(varName).equals(new IntType())){
                return typeEnv;
            }
            else{
                throw new InterpreterException("ReadFile requires an integer as its variable parameter!");
            }
        }
        else{
            throw new InterpreterException("ReadFile requires a string as its expression parametere!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new ReadFile(exp.deepCopy(), varName);
    }

    @Override
    public String toString() {
        return String.format("ReadFile(%s, %s)", exp.toString(), varName);
    }
}
