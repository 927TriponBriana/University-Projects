import java.io.IOException;
import java.util.Scanner;
import java.util.Set;

public class Main {
    public static void main(String[] args) throws IOException {
//        Grammar grammar = new Grammar("g1.txt");
        Grammar grammar = new Grammar("g1.txt");
        grammar.initializeFromFile();


        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\n");
            System.out.println("1. Print Nonterminals");
            System.out.println("2. Print Terminals");
            System.out.println("3. Print Productions");
            System.out.println("4. Print Productions for a given Nonterminal");
            System.out.println("5. Check is the grammar is CFG");
            System.out.println("0. Exit");

            System.out.println("Enter option: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    grammar.printNonTerminals();
                    break;
                case 2:
                    grammar.printTerminals();
                    break;
                case 3:
                    grammar.printProductions();
                    break;
                case 4:
                    System.out.print("Enter a nonterminal to print its productions: ");
                    String userNonterminal = scanner.nextLine();
                    grammar.printProductionsForNonterminal(userNonterminal);
                    break;
                case 5:
                    if (grammar.checkIfCFG()) {
                        System.out.println("The grammar is a CFG");
                    } else {
                        System.out.println("The grammar is not a CFG");
                    }
                    break;
                case 0:
                    System.exit(0);
                    break;
                default:
                    System.out.println("Invalid option!");

            }
        }

    }
}