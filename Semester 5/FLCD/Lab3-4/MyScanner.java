import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class MyScanner {
    private String program;
    private final List<String> operators;
    private final List<String> separators;
    private final List<String> reservedWords;
    private final SymbolTable symbolTable;
    private final List<ScannedItem> PIF;
    private int index = 0;
    private int currentLine = 1;

    private static class ScannedItem {
        private final String token;
        private final int position;

        public ScannedItem(String token, int position) {
            this.token = token;
            this.position = position;
        }

        public String getToken() {
            return token;
        }

        public int getPosition() {
            return position;
        }
    }

    public MyScanner() {
        this.symbolTable = new SymbolTable(51);
        this.PIF = new ArrayList<>();
        this.reservedWords = new ArrayList<>();
        this.operators = new ArrayList<>();
        this.separators = new ArrayList<>();
        try {
            readTokens();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void readTokens() throws IOException {
        File file = new File("src/programs/token.in");
        BufferedReader bufferedReader = Files.newBufferedReader(file.toPath());
        String line;

        List<String> reservedWordTokens = List.of("int", "bool", "string", "cin", "print", "BEGIN", "END", "if", "else", "array", "for");
        List<String> operatorTokens = List.of("<=", "==", ">=", "!=", ">>", "&&", "-", "/", "%", "*", "++");

        while ((line = bufferedReader.readLine()) != null) {
//            System.out.println(line);
            if (reservedWordTokens.contains(line)) {
                reservedWords.add(line);
            } else if (operatorTokens.contains(line)) {
                operators.add(line);
            } else {
                separators.add(line);
            }
        }
    }

    public void print() {
        System.out.print(separators);
        System.out.print(operators);
        System.out.print(reservedWords);
    }

    private void setProgram(String program) {
        this.program = program;
    }

    private void skipSpaces() {
        while (index < program.length()) {
            char currentChar = program.charAt(index);
            if (Character.isWhitespace(currentChar)) {
                if (currentChar == '\n') {
                    currentLine++;
                }
                index++;
            } else {
                break; // Exit the loop when a non-whitespace character is encountered
            }
        }
    }

    private boolean verifyIfStringConst() {
        var regexStringConst = Pattern.compile("^\"[a-zA-Z0-9_ .!]*\"");
        var matcher = regexStringConst.matcher(program.substring(index));
        if (matcher.find()) {
            var stringConst = matcher.group(0);
            index += stringConst.length();

            try {
                int position = symbolTable.addStringConstant(stringConst);
                PIF.add(new ScannedItem("String const", position));
                return true;
            } catch (Exception e) {
                int position = symbolTable.getStringConstantPosition(stringConst);
                PIF.add(new ScannedItem("String const", position));
                return true;
            }
        }

        return false;
    }

    private boolean verifyIfIdentifier() {
        var regexIdentifier = Pattern.compile("^([a-z][a-zA-Z0-9_]*)");
        var matcher = regexIdentifier.matcher(program.substring(index));
        if(matcher.find()) {
            var identifier = matcher.group(1);
            if(!checkIfValid(identifier, program.substring(index))) {
                return false;
            }

            if (Character.isDigit(identifier.charAt(0))) {
                return false;
            }

            index += identifier.length();
            int position;
            try {
                position = symbolTable.addIdentifier(identifier);
            } catch (Exception e) {
                position = symbolTable.getIdentifierPosition(identifier);
            }
            PIF.add(new ScannedItem("id", position));
            return true;
        }
        //System.out.println(program.substring(index) + '\n');

        return false;
    }


    private boolean checkIfValid(String identifier, String substring) {
        if(reservedWords.contains(identifier)) {
            return false;
        }

        if(Pattern.compile("^(?![0-9])[a-zA-Z_][a-zA-Z0-9_]*").matcher(substring).find()) {
            return true;
        }

        return symbolTable.hasIdentifier(identifier);
    }


    private boolean verifyIfIntConst() {
//        var regexForIntConstant = Pattern.compile("^(0|[+-]?[1-9][0-9]*)");
        var regexForIntConstant = Pattern.compile("^(0|[+-]?[1-9][0-9]*)(?![a-zA-Z_])");
        var matcher = regexForIntConstant.matcher(program.substring(index));
        if (matcher.find()) {
            var intConstant = matcher.group(1);
            index += intConstant.length();
            try {
                int position = symbolTable.addIntConstant(Integer.parseInt(intConstant));
                PIF.add(new ScannedItem("Int const", position));
                return true;
            } catch (Exception e) {
                int position = symbolTable.getIntConstantPosition(Integer.parseInt(intConstant));
                PIF.add(new ScannedItem("Int const", position));
                return true;
            }

        }
        return false;
    }

    private boolean verifyTokenList() {
        String str = program.substring(index).split(" ")[0];

        for (var token : operators) {
            if (str.startsWith(token)) {
                if (str.length() > token.length() && operators.contains(token + str.substring(token.length(), token.length() + 1))) {
                    return false;
                }

                index += token.length();
                PIF.add(new ScannedItem(token, -1));
                return true;
            }
        }

        for (var reservedToken : reservedWords) {
            if (str.startsWith(reservedToken)) {
                var regex = "^" + "[a-zA-Z0-9_]*" + reservedToken + "[a-zA-Z0-9_]+";
                if (Pattern.compile(regex).matcher(str).find()) {
                    return false;
                }
                index += reservedToken.length();
                PIF.add(new ScannedItem(reservedToken, -1));
                return true;
            }
        }

        for (var token : separators) {
            if (str.startsWith(token)) {
                index += token.length();
                PIF.add(new ScannedItem(token, -1));
                return true;
            }
        }

        return false;
    }

    private void nextToken() throws ScannerException {
        skipSpaces();
        if(index == program.length()) {
            return;
        }

        if(verifyIfIdentifier()) {
            return;
        }

        if(verifyIfIntConst()) {
            return;
        }

        if(verifyIfStringConst()) {
            return;
        }

        if(verifyTokenList()) {
            return;
        }
        throw new ScannerException("Lexical error at line: " + currentLine + ", index: " + index);
    }

    public void scan(String fileName) {
        try {
            Path file = Path.of("src/programs/" + fileName);
            setProgram(Files.readString(file));
            index = 0;
            //PIF = new ArrayList<>();
            currentLine = 1;
            while (index < program.length()) {
                nextToken();
            }
            FileWriter fileWriter = new FileWriter("PIF" + fileName);
            for(var item : PIF) {
                fileWriter.write(item.getToken() + " -> (" + item.getPosition() + ")\n");
            }
            fileWriter.close();
            fileWriter = new FileWriter("ST" + fileName);
            fileWriter.write(symbolTable.toString());
            fileWriter.close();
            System.out.println("Lexically correct");
        } catch (IOException | ScannerException e) {
            System.out.println(e.getMessage());
        }
    }
}
