import java.io.IOException;
import java.util.*;

public class Main2 {
    public static void main(String[] args) throws IOException {
        Grammar grammar = new Grammar("g4.txt");
        grammar.initializeFromFile();

        Parser parser = new Parser(grammar);

        parser.buildParsingTable();

        Table parseTable = parser.getParsingTable();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\nChoose an option:");
            System.out.println("1. Print First Set");
            System.out.println("2. Print Follow Set");
            System.out.println("3. Print Parsing Table");
            System.out.println("4. Parse Input Sequence");
            System.out.println("0. Exit");

            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume the newline character

            switch (choice) {
                case 1 -> printAllFirstSets(grammar, parser);
                case 2 -> printAllFollowSets(grammar, parser);
                case 3 -> System.out.println(parseTable);
                case 4 -> parseInputSequence(parser, scanner);
                case 0 -> System.exit(0);
                default -> System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void printAllFirstSets(Grammar grammar,Parser parser) {
        for (String nonTerminal : grammar.getNonTerminals()) {
            Set<String> firstSet = parser.first(nonTerminal, new HashSet<>());
            System.out.println("First Set of " + nonTerminal + ": " + firstSet);
        }
    }

    private static void printAllFollowSets(Grammar grammar, Parser parser) {
        for (String nonTerminal : grammar.getNonTerminals()) {
            Set<String> followSet = parser.follow(nonTerminal);
            System.out.println("Follow Set of " + nonTerminal + ": " + followSet);
        }
    }

    private static void parseInputSequence(Parser parser, Scanner scanner) {
        System.out.println("Enter a sequence (space-separated):");
        String input = scanner.nextLine();
        List<String> transformedInput = Arrays.asList(input.replace("\n", "").split(" "));
        boolean parseResult = parser.parse(transformedInput);

        if (parseResult) {
            System.out.println("Sequence parsed successfully!");
            System.out.println("Output Stack: " + parser.outputStack);
        } else {
            System.out.println("Parsing failed.");
        }
    }
}
