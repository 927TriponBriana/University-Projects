import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class Main2 {
    public static void main(String[] args) throws IOException {
        Grammar grammar = new Grammar("g4.txt");
        grammar.initializeFromFile();

        Parser parser = new Parser(grammar);

        parser.buildParsingTable();

        Table parseTable = parser.getParsingTable();
        System.out.println(parseTable);
        String input = "a * ( a + a )";
        List<String>transfInput=Arrays.asList(input.replace("\n", "").split(" "));
        System.out.println(parser.parse(transfInput));


        //parseInput(parser);


//        Set<String> firstOfS = parser.first("S",new HashSet<>());
//        System.out.println("First(S): " + firstOfS);
//
//        Set<String> firstOfA = parser.first("A", new HashSet<>());
//        System.out.println("First(A): " + firstOfA);
//
//        Set<String> firstOfB = parser.first("B",new HashSet<>());
//        System.out.println("First(B): " + firstOfB);
//
//        Set<String> firstOfC = parser.first("C",new HashSet<>());
//        System.out.println("First(C): " + firstOfC);
//
//        Set<String> firstOfD = parser.first("D",new HashSet<>());
//        System.out.println("First(D): " + firstOfD);
//
//
//        Set<String> followOfS = parser.follow("S");
//        System.out.println("Follow(S): " + followOfS);
//
//        Set<String> followOfA = parser.follow("A");
//        System.out.println("Follow(A): " + followOfA);
//
//        Set<String> followOfB = parser.follow("B");
//        System.out.println("Follow(B): " + followOfB);
//
//        Set<String> followOfC = parser.follow("C");
//        System.out.println("Follow(C): " + followOfC);
//
//        Set<String> followOfD = parser.follow("D");
//        System.out.println("Follow(D): " + followOfD);


    }

//    private static void parseInput(Parser parser) {
//        Scanner scanner = new Scanner(System.in);
//
//        while (true) {
//            System.out.println("Enter an input string (or 'exit' to quit): ");
//            String input = scanner.nextLine();
//
//            if(input.equals("exit")) {
//                break;
//            }
//
//            List<String> inputSymbols = Arrays.asList(input.split("\\s+"));
//
//            try {
//                List<String> output = parser.parse(inputSymbols);
//                System.out.println("Input string is valid. Output: " + output);
//            } catch (RuntimeException e) {
//                System.out.println("Error: " + e.getMessage());
//            }
//        }
//        scanner.close();
//    }
}
