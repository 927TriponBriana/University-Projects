package Model;

import Exceptions.InterpreterException;

public class WhileStmt implements IStmt{
    private IExp expression;
    private IStmt statement;

    public WhileStmt(IExp expression, IStmt statement){
        this.expression = expression;
        this.statement = statement;
    }

    @Override
    public String toString() {
        return String.format("Wile(%s){%s}", expression, statement);
    }

    @Override
    public PrgState execute(PrgState state) throws InterpreterException {
        Value value = expression.eval(state.getSymTable(), state.getHeap());
        MyIStack<IStmt> stack = state.getExeStack();
        if (!value.getType().equals(new BoolType())){
            throw new InterpreterException(String.format("%s is no of BoolType", value));
        }
        BoolValue boolValue = (BoolValue) value;
        if (boolValue.getValue()){
            stack.push(this);
            stack.push(statement);
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws InterpreterException {
        Type typeExp = expression.typeCheck(typeEnv);
        if (typeExp.equals(new BoolType())){
            statement.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else{
            throw new InterpreterException("The condition of WHILE does not have the type bool!");
        }
    }

    @Override
    public IStmt deepCopy() {
        return new WhileStmt(expression.deepCopy(), statement.deepCopy());
    }
}
