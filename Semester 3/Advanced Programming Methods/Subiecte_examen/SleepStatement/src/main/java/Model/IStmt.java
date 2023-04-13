package Model;
import Exceptions.InterpreterException;

public interface IStmt {
//    @Override
//    String toString();
    PrgState execute(PrgState state) throws InterpreterException;
    IStmt deepCopy();
    MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException;
}
