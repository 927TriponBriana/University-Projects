package Model;

import Exceptions.InterpreterException;

public interface IExp {
    Value eval(MyIDictionary<String, Value> symTable, MyIHeap heap) throws InterpreterException;

    IExp deepCopy();
    Type typeCheck(MyIDictionary<String, Type>typeEnv) throws InterpreterException;
}
