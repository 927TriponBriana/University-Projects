package View;

import Controller.Controller;
import Exceptions.InterpreterException;

import java.util.Objects;
import java.util.Scanner;

public class RunExampleCommand extends Command{
    private Controller controller;

    public RunExampleCommand(String key, String description, Controller controller){
        super(key, description);
        this.controller = controller;
    }

    @Override
    public void execute(){
        try{
            System.out.println("Do you want to display the steps?");
            Scanner readOption = new Scanner(System.in);
            String option = readOption.next();
            controller.setDisplay(Objects.equals(option, "Y"));
            controller.allSteps();
        }
        catch (InterpreterException | InterruptedException exception){
            System.out.println(exception.getMessage());
        }
    }
}
