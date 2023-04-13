package Exceptions;

public class ExpressionEvalException extends Exception{
    public ExpressionEvalException(){
        super();
    }

    public ExpressionEvalException(String mssg){
        super(mssg);
    }
}
