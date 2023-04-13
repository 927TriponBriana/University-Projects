package Model;

import Exceptions.InterpreterException;

import java.io.BufferedReader;
import java.util.List;

public class PrgState {
    private MyIStack <IStmt> exeStack;
    private MyIDictionary <String, Value> symTable;
    private MyIList <Value> output;
    private MyIDictionary<String, BufferedReader> fileTable;
    private IStmt originalProgram;
    private MyIHeap heap;
    private int id;
    private static int lastId = 0;
    private MyILatchTable latchTable;

    public PrgState(MyIStack<IStmt>stack, MyIDictionary<String, Value> symTable, MyIList<Value>output, MyIDictionary<String,BufferedReader> fileTable, MyIHeap heap, MyILatchTable latchTable, IStmt program){
        this.exeStack = stack;
        this.symTable = symTable;
        this.output = output;
        this.fileTable = fileTable;
        this.originalProgram = program.deepCopy();
        this.exeStack.push(this.originalProgram);
        this.heap = heap;
        this.id = setId();
        this.latchTable = latchTable;
    }

    public PrgState(MyIStack<IStmt>stack, MyIDictionary<String, Value>symTable, MyIList<Value>output, MyIDictionary<String, BufferedReader>fileTable, MyIHeap heap, MyILatchTable latchTable){
        this.exeStack = stack;
        this.symTable = symTable;
        this.output = output;
        this.fileTable  = fileTable;
        this.heap = heap;
        this.id = setId();
        this.latchTable = latchTable;
    }

    public synchronized int setId(){
        lastId++;
        return lastId;
    }

    public int getId() {
        return this.id;
    }
    public void setExeStack(MyIStack<IStmt>newStack){
        this.exeStack = newStack;
    }

    public void setSymTable(MyIDictionary<String, Value>newSymTable){
        this.symTable = newSymTable;
    }

    public void setOut(MyIList<Value>newOutput){
        this.output = newOutput;
    }

    public void setFileTable(MyIDictionary<String, BufferedReader> newFileTable){
        this.fileTable = newFileTable;
    }

    public void setHeap(MyIHeap newHeap){
        this.heap = newHeap;
    }
    public void setLatchTable(MyILatchTable newLatchTable){
        this.latchTable = newLatchTable;
    }
    public MyIStack<IStmt> getExeStack(){
        return exeStack;
    }

    public MyIDictionary<String, Value> getSymTable(){
        return symTable;
    }

    public MyIList<Value> getOut(){
        return output;
    }

    public MyIDictionary<String, BufferedReader> getFileTable(){
        return fileTable;
    }

    public MyIHeap getHeap(){
        return heap;
    }
    public MyILatchTable getLatchTable(){
        return latchTable;
    }

    public boolean isNotCompleted(){
        return exeStack.isEmpty();
    }

    public PrgState oneStep() throws InterpreterException {
        if (exeStack.isEmpty()){
            throw new InterpreterException("Program state stack is empty!");
        }
        IStmt currentStmt = exeStack.pop();
        return currentStmt.execute(this);
    }
    public String exeStackToString(){
        StringBuilder exeStackStringBuilder = new StringBuilder();
        List<IStmt>stack = exeStack.getReversed();
        for(IStmt stmt: stack){
            exeStackStringBuilder.append(stmt.toString()).append("\n");
        }
        return exeStackStringBuilder.toString();
    }

    public String symTableToString() throws InterpreterException{
        StringBuilder symTableStringBuilder = new StringBuilder();
        for (String key: symTable.keySet()){
            symTableStringBuilder.append(String.format("%s -> %s\n", key, symTable.lookUp(key).toString()));
        }
        return symTableStringBuilder.toString();
    }

    public String outToString(){
        StringBuilder outStringBuilder = new StringBuilder();
        for (Value elem: output.getList()){
            outStringBuilder.append(String.format("%s\n", elem.toString()));
        }
        return outStringBuilder.toString();
    }

    public String fileTableToString(){
        StringBuilder fileTableStringBuider = new StringBuilder();
        for (String key: fileTable.keySet()){
            fileTableStringBuider.append(String.format("%s\n", key));
        }
        return fileTableStringBuider.toString();
    }

    public String heapToString() throws InterpreterException{
        StringBuilder heapStringBuilder = new StringBuilder();
        for(int key: heap.keySet()){
            heapStringBuilder.append(String.format("%d -> %s\n", key, heap.get(key)));
        }
        return heapStringBuilder.toString();
    }

    public String latchTableToString() throws InterpreterException{
        StringBuilder latchTableStringBuilder = new StringBuilder();
        for (int key: latchTable.getLatchTable().keySet()){
            latchTableStringBuilder.append(String.format("%d -> %s\n", key, latchTable.get(key)));
        }
        return latchTableStringBuilder.toString();
    }

    @Override
    public String toString(){
        return "Id: " + id + "\nExecution stack: \n" + exeStack.getReversed() + "\nSymTable: \n" + symTable.toString() + "\nOutput list: "+ output.toString() + "\nFile Table: "+fileTable.toString() + "\nHeap Memory: " + heap.toString() + "\nLatch Table: " + latchTable.toString() +"\n";
    }

    public String programStateToString() throws InterpreterException{
        return "Id: " + id + "\nExecution stack: \n" + exeStackToString() + "SymTable: \n" + symTableToString() + "Output list: \n" + outToString() + "File Table: \n" + fileTableToString() + "Heap Memory:\n" + heapToString() + "Latch Table:\n" + latchTableToString();
    }
}
