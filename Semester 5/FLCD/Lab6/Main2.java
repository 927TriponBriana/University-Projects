import java.io.IOException;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Main2 {
    public static void main(String[] args) throws IOException {
        Grammar grammar = new Grammar("g4.txt");
        grammar.initializeFromFile();

        Parser parser = new Parser(grammar);


        Set<String> firstOfS = parser.first("S",new HashSet<>());
        System.out.println("First(S): " + firstOfS);

        Set<String> firstOfA = parser.first("A", new HashSet<>());
        System.out.println("First(A): " + firstOfA);

        Set<String> firstOfB = parser.first("B",new HashSet<>());
        System.out.println("First(B): " + firstOfB);

        Set<String> firstOfC = parser.first("C",new HashSet<>());
        System.out.println("First(C): " + firstOfC);

        Set<String> firstOfD = parser.first("D",new HashSet<>());
        System.out.println("First(D): " + firstOfD);


        Set<String> followOfS = parser.follow("S");
        System.out.println("Follow(S): " + followOfS);

        Set<String> followOfA = parser.follow("A");
        System.out.println("Follow(A): " + followOfA);

        Set<String> followOfB = parser.follow("B");
        System.out.println("Follow(B): " + followOfB);

        Set<String> followOfC = parser.follow("C");
        System.out.println("Follow(C): " + followOfC);

        Set<String> followOfD = parser.follow("D");
        System.out.println("Follow(D): " + followOfD);


    }
}
