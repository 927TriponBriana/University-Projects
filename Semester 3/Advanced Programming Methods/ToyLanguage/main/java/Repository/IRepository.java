package Repository;

import Exceptions.InterpreterException;
import Model.PrgState;

import java.io.IOException;
import java.util.List;

public interface IRepository {
    void addProgram(PrgState program);
    List<PrgState> getProgramList();
    void setProgramStates(List<PrgState>programStates);
    //PrgState getCurrentState();
    void logPrgStateExec(PrgState programState) throws IOException, InterpreterException;
    void emptyLogFile() throws IOException;
}
