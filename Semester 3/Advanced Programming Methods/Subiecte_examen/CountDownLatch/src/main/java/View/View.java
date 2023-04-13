package View;//package View;
//
//import Controller.Controller;
//import Exceptions.ADTException;
//import Exceptions.ExpressionEvalException;
//import Exceptions.StmtExecutionException;
//import Model.*;
//import Repository.IRepository;
//import Repository.Repository;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.util.Objects;
//import java.util.Scanner;
//
//public class View {
//    public void start(){
//        boolean done = false;
//        while (!done){
//            try{
//                menu();
//                Scanner readOption = new Scanner(System.in);
//                int option = readOption.nextInt();
//                if (option == 0){
//                    done = true;
//                }
//                else if (option == 1){
//                    runProgram1();
//                }
//                else if (option == 2){
//                    runProgram2();
//                }
//                else if (option == 3){
//                    runProgram3();
//                }
//                else {
//                    System.out.println("Invalid input!");
//                }
//            } catch (Exception exception){
//                System.out.println(exception.getMessage());
//            }
//        }
//    }
//
//    private void menu(){
//        System.out.println("Menu: ");
//        System.out.println("1. Run first program: \nint v;\nv=2;\nPrint(v)");
//        System.out.println("2. Run second program: \nint a;\nint b;\na=2+3*5;\nb=a+1;\nPrint(b)");
//        System.out.println("3. Run third program: \nbool a;\nint v;\na=true;\n(If a Then v=2 Else v=3);\nPrint(v)");
//        System.out.println("0. Exit");
//        System.out.println("Choose an option: ");
//    }
//
//    private void runProgram1() throws ExpressionEvalException, StmtExecutionException, ADTException, IOException {
//        IStmt prg1 = new CompStmt(new VarDeclStmt("v", new IntType()),
//                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))),
//                        new PrintStmt(new VarExp("v"))));
//        runStmt(prg1);
//    }
//
//    private void runProgram2() throws ExpressionEvalException, StmtExecutionException, ADTException, IOException {
//        IStmt prg2 = new CompStmt(new VarDeclStmt("a", new IntType()),
//                new CompStmt(new VarDeclStmt("b", new IntType()),
//                        new CompStmt(new AssignStmt("a", new ArithExp(1,new ValueExp(new IntValue(2)),
//                                new ArithExp(3,new ValueExp(new IntValue(3)),new ValueExp(new IntValue(5))))),
//                                new CompStmt(new AssignStmt("b",new ArithExp(1,new VarExp("a"),new ValueExp(new IntValue(1)))),
//                                        new PrintStmt(new VarExp("b"))))));
//        runStmt(prg2);
//    }
//
//    private void runProgram3() throws ExpressionEvalException, StmtExecutionException, ADTException, IOException {
//        IStmt prg3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
//                new CompStmt(new VarDeclStmt("v", new IntType()),
//                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
//                                new CompStmt(new IfStmt(new VarExp("a"),
//                                        new AssignStmt("v", new ValueExp(new IntValue(2))),
//                                        new AssignStmt("v", new ValueExp(new IntValue(3)))),
//                                        new PrintStmt(new VarExp("v"))))));
//        runStmt(prg3);
//    }
//
//    private void runStmt(IStmt stmt) throws ExpressionEvalException, StmtExecutionException, ADTException, IOException {
//        MyIStack<IStmt> exeStack = new MyStack<>();
//        MyIDictionary<String, Value> symTable = new MyDictionary<>();
//        MyIList<Value> output = new MyList<>();
//        MyIDictionary<String, BufferedReader> fileTable = new MyDictionary<>();
//        MyIHeap heap = new MyHeap();
//
//        PrgState state = new PrgState(exeStack, symTable, output, fileTable, heap, stmt);
//
//        IRepository repo = new Repository(state, "log.txt");
//        Controller controller = new Controller(repo);
//
//        System.out.println("Do you want to display the steps?");
//        Scanner readOption = new Scanner(System.in);
//        String option = readOption.next();
//        controller.setDisplay(Objects.equals(option, "Y"));
//
//        controller.allSteps();
//        System.out.println("Result is: " + state.getOut().toString().replace('[', ' ').replace(']', ' '));
//    }
//}
