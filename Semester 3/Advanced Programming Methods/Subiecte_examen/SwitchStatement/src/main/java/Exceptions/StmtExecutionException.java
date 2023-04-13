package Exceptions;

public class StmtExecutionException extends Exception{
    public StmtExecutionException(){
        super();
    }

    public StmtExecutionException(String mssg){
        super(mssg);
    }
}
