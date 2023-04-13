package Repository;

import Exceptions.InterpreterException;
import Model.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Repository implements IRepository{
    private List<PrgState> programStates;
    //private int currentPos;
    private final String logFilePath;

    public Repository(PrgState programState, String logFilePath) throws IOException {
        this.logFilePath = logFilePath;
        this.programStates = new ArrayList<>();
        //this.currentPos = 0;
        this.addProgram(programState);
        this.emptyLogFile();
    }

    @Override
    public void addProgram(PrgState program){
        this.programStates.add(program);
    }

//    public int getCurrentPos(){
//        return currentPos;
//    }

//    public void setCurrentPos(int currentPos){
//        this.currentPos = currentPos;
//    }

    @Override
    public List<PrgState>getProgramList(){
        return this.programStates;
    }

    @Override
    public void setProgramStates(List<PrgState>programStates){
        this.programStates = programStates;
    }

//    @Override
//    public PrgState getCurrentState(){
//        return this.programStates.get(this.currentPos);
//    }

    @Override
    public void logPrgStateExec(PrgState programState) throws IOException, InterpreterException {
        PrintWriter logFile;
        logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)));
        //logFile.println(this.programStates.get(0).programStateToString());
        logFile.println(programState.programStateToString());
        logFile.close();
    }

    @Override
    public void emptyLogFile() throws IOException{
        PrintWriter logFile;
        logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, false)));
        logFile.close();
    }
}
