package Controller;

import Exceptions.InterpreterException;
import Model.PrgState;
import Model.RefValue;
import Model.Value;
import Repository.IRepository;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class Pair{
    final PrgState first;
    final InterpreterException second;

    public Pair(PrgState first, InterpreterException second){
        this.first = first;
        this.second = second;
    }
}

public class Controller {
    IRepository repo;
    boolean displayed = false;
    ExecutorService executorService;

    public void setDisplay(boolean value){
        this.displayed = value;
    }

    public Controller(IRepository repo){
        this.repo = repo;
    }

    public Map<Integer, Value>unsafeGarbageCollector(List<Integer>symTableAddr, Map<Integer, Value>heap){
        return heap.entrySet().stream()
                .filter(e -> symTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    public Map<Integer, Value>safeGarbageCollector(List<Integer>symTableAddr, List<Integer>heapAddr, Map<Integer, Value>heap){
        return heap.entrySet().stream()
                .filter(e -> (symTableAddr.contains(e.getKey()) || heapAddr.contains(e.getKey())))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
    public List<Integer>getAddrFromSymTable(Collection<Value> symTableValues){
        return symTableValues.stream()
                .filter(v -> v instanceof RefValue)
                .map(v -> {RefValue v1=(RefValue) v; return v1.getAddress();})
                .collect(Collectors.toList());
    }

    public List<Integer>getAddrFromHeap(Collection<Value> heapValues){
        return heapValues.stream()
                .filter(v-> v instanceof RefValue)
                .map(v-> {RefValue v1 = (RefValue) v; return v1.getAddress();})
                .collect(Collectors.toList());
    }
//    public PrgState oneStep(PrgState state) throws StmtExecutionException, ExpressionEvalException, ADTException{
//        MyIStack<IStmt>stack = state.getExeStack();
//        if (stack.isEmpty()){
//            throw new StmtExecutionException("Program state stack is empty!");
//        }
//        IStmt currentStmt = stack.pop();
//        state.setExeStack(stack);
//        return currentStmt.execute(state);
//    }

    public void oneStepForAllPrograms(List<PrgState>programStates) throws InterpreterException, InterruptedException{
        programStates.forEach(programState -> {
            try {
                repo.logPrgStateExec(programState);
                display(programState);
            } catch (IOException | InterpreterException e){
                System.out.println(e.getMessage());
            }
        });
        List<Callable<PrgState>> callList = programStates.stream()
                .map((PrgState p) -> (Callable<PrgState>) (p::oneStep))
                .collect(Collectors.toList());

        List<Pair> newProgramList;
        newProgramList = executorService.invokeAll(callList).stream()
                .map(future -> {
                    try {
                        return new Pair(future.get(), null);
                    } catch (ExecutionException | InterruptedException e) {
                        if (e.getCause() instanceof InterpreterException)
                            return new Pair(null, (InterpreterException) e.getCause());
                        System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
                        return null;
                    }
                }).filter(Objects::nonNull)
                .filter(pair -> pair.first != null || pair.second != null)
                .collect(Collectors.toList());

        for (Pair error: newProgramList)
            if (error.second != null)
                throw error.second;
        programStates.addAll(newProgramList.stream().map(pair -> pair.first).collect(Collectors.toList()));


//        List<PrgState> newProgramList = executorService.invokeAll(callList).stream()
//                .map(future -> {
//                    try {
//                        return future.get();
//                    } catch (ExecutionException | InterruptedException e){
//                        System.out.println(e.getMessage());
//                    }
//                    return null;
//                })
//                .filter(Objects::nonNull)
//                .filter()
//                .collect(Collectors.toList());

        programStates.forEach(programState -> {
            try{
                repo.logPrgStateExec(programState);
            } catch (IOException | InterpreterException e){
                System.out.println(e.getMessage());
            }
        });
        repo.setProgramStates(programStates);
    }

    public void oneStep() throws InterpreterException, InterruptedException{
        executorService = Executors.newFixedThreadPool(2);
        List<PrgState> programStates = removeCompletedPrg(repo.getProgramList());
        oneStepForAllPrograms(programStates);
        conservativeGarbageCollector(programStates);
        executorService.shutdown();
    }

    public void allSteps() throws  InterpreterException, InterruptedException {
        executorService = Executors.newFixedThreadPool(2);
        List<PrgState> programStates = removeCompletedPrg(repo.getProgramList());
        while (programStates.size() > 0){
            conservativeGarbageCollector(programStates);
            oneStepForAllPrograms(programStates);
            programStates = removeCompletedPrg(repo.getProgramList());
        }
        executorService.shutdown();
        //repo.setProgramStates(programStates);
//        PrgState program = this.repo.getCurrentState();
//        this.repo.logPrgStateExec();
//        display();
//        while(!program.getExeStack().isEmpty()){
//            oneStep(program);
//            this.repo.logPrgStateExec();
//            //program.getHeap().setContent((HashMap<Integer, Value>) unsafeGarbageCollector(getAddrFromSymTable(program.getSymTable().getContent().values()), program.getHeap().getContent()));
//            program.getHeap().setContent((HashMap<Integer, Value>) safeGarbageCollector(getAddrFromSymTable(program.getSymTable().getContent().values()), getAddrFromHeap(program.getHeap().getContent().values()),program.getHeap().getContent()));
//            this.repo.logPrgStateExec();
//            display();
//        }
    }

    public void conservativeGarbageCollector(List<PrgState> programStates){
        List<Integer> symTableAddresses = Objects.requireNonNull(programStates.stream()
                .map(p -> getAddrFromSymTable(p.getSymTable().values()))
                .map(Collection::stream)
                .reduce(Stream::concat).orElse(null))
                .collect(Collectors.toList());
        programStates.forEach(p -> {
            p.getHeap().setContent((HashMap<Integer, Value>) safeGarbageCollector(symTableAddresses, getAddrFromHeap(p.getHeap().getContent().values()), p.getHeap().getContent()));
        });
    }

    private void display(PrgState programState){
        if (displayed){
            System.out.println(programState.toString());
        }
    }

    public List<PrgState> removeCompletedPrg(List<PrgState> inPrgList){
        return inPrgList.stream()
                .filter(p-> !p.isNotCompleted())
                .collect(Collectors.toList());
    }
    public void setProgramStates(List<PrgState> programStates) {
        this.repo.setProgramStates(programStates);
    }
    public List<PrgState> getProgramStates() {
        return this.repo.getProgramList();
    }
}
