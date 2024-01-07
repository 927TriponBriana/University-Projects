//import javafx.util.Pair;

import java.util.*;

//import java.util.*;

public class Parser {
    private Grammar grammar;
    //private Map<Pair<String, String>, List<String>> parsingTable;
    private Table parsingTable = new Table();
    private Stack<List<String>> rhs = new Stack<>();
    private Map<Pair<String, List<String>>, Integer> countedProductions = new HashMap<>();

    private Stack<String> inputStack = new Stack<>();
    private Stack<String> workingStack = new Stack<>();
    private Stack<String> outputStack = new Stack<>();
    private boolean isParsingComplete =true;
    private ListIterator<String> workingStackIterator;
    private ListIterator<String> inputStackIterator;

    public Parser(Grammar grammar){
        this.grammar = grammar;

//        this.parsingTable = new HashMap<>();
//        buildParsingTable();
    }

    public Set<String> first(String symbol, Set<String> visited) {
        Set<String> firstSet = new HashSet<>();

        if (visited.contains(symbol)) {
            return firstSet;
        }

        visited.add(symbol);

        if (grammar.getTerminals().contains(symbol) || symbol.equals("ε")) {
            firstSet.add(symbol);
        } else {
            for (Production production : grammar.getProductions()) {
                if (production.getKey().equals(symbol)) {
                    List<String> productionValues = production.getValue();

                    boolean addedToFirst = false;

                    for (String productionValue : productionValues) {
                        if (productionValue.equals("|")) {
                            addedToFirst = false; // Reset the flag when encountering '|'
                            continue;
                        }

                        if (!addedToFirst) {
                            if (!productionValue.isEmpty()) {
                                Set<String> firstOfProductionValue = first(productionValue, visited);
                                firstSet.addAll(firstOfProductionValue);

                                if (!firstOfProductionValue.contains("ε")) {
                                    addedToFirst = true; // Set the flag if the FIRST set is added
                                }
                            }
                        }

                    }
                }
            }
        }

        visited.remove(symbol);

        return firstSet;
    }

    public Set<String> follow(String nonterminal) {
        Set<String> followSet = new HashSet<>();

        if (nonterminal.equals(grammar.getStartSymbol())) {
            followSet.add("$");
        }

        for (Production production : grammar.getProductions()) {
            List<String> productionValues = production.getValue();

            for (int i = 0; i < productionValues.size(); i++) {
                String currentSymbol = productionValues.get(i);

                if (currentSymbol.equals(nonterminal)) {
                    if (i < productionValues.size() - 1) {
                        String nextSymbol = productionValues.get(i + 1);
                        followSet.addAll(first(nextSymbol, new HashSet<>()));

                        if (followSet.contains("ε")) {
                            followSet.remove("ε");
                            followSet.addAll(follow(production.getKey()));
                        }
                    } else if (!nonterminal.equals(production.getKey())) {
                        followSet.addAll(follow(production.getKey()));
                    }
                }
            }
        }

        return followSet;
    }

    private void countProduction() {
        int index = 1;
        List<Production> productions = grammar.getProductions();
        for(Production production : productions) {
            String startSymbol = production.getKey();
            List<String> rule = production.getValue();

            countedProductions.put(new Pair<>(startSymbol, rule), index++);
        }
    }

    public void buildParsingTable() {
        countProduction();

        List<String> columns = new LinkedList<>(grammar.getTerminals());
        columns.add("$");

        parsingTable.put(new Pair<>("$", "$"), new Pair<>(Collections.singletonList("acc"), -1));

        for(String terminal : grammar.getTerminals()) {
            parsingTable.put(new Pair<>(terminal, terminal), new Pair<>(Collections.singletonList("pop"), -1));
        }

        countedProductions.forEach((key, value) -> {
            String rowSymbol = key.getKey();
            List<String> rule = key.getValue();
            Pair<List<String>, Integer> parsingTableValue = new Pair<>(rule, value);

            for(String column : columns) {
                Pair<String, String> parsingTableKey = new Pair<>(rowSymbol, column);

                if(rule.get(0).equals(column) && !column.equals("ε")) {
                    parsingTable.put(parsingTableKey, parsingTableValue);
                }
                else if(grammar.getNonTerminals().contains(rule.get(0)) && first(rule.get(0), new HashSet<>()).contains(column)) {
                    if(parsingTable.containsKey(parsingTableKey)) {
                        parsingTable.put(parsingTableKey, parsingTableValue);
                    }
                }
                else {
                    if(rule.get(0).equals("ε")) {
                        for(String followSymbol : follow(rowSymbol)) {
                            parsingTable.put(new Pair<>(rowSymbol, followSymbol), parsingTableValue);
                        }
                    }
                    else {
                        Set<String> firsts = new HashSet<>();
                        for(String symbol : rule) {
                            if(grammar.getNonTerminals().contains(symbol)) {
                                firsts.addAll(first(symbol, new HashSet<>()));
                            }
                        }
                        if(firsts.contains("ε")) {
                            for(String firstSymbol : first(rowSymbol, new HashSet<>())) {
                                if(firstSymbol.equals("ε")) {
                                    firstSymbol = "$";
                                }
                                parsingTableKey = new Pair<>(rowSymbol, firstSymbol);
                                if(parsingTable.containsKey(parsingTableKey)) {
                                    parsingTable.put(parsingTableKey, parsingTableValue);
                                }
                            }
                        }
                    }
                }
            }
        });
    }

    public Table getParsingTable() {
        return parsingTable;
    }

    public boolean parse(List<String> w) {
        initStacks(w);
//        System.out.println("Input stack: " + inputStack);
//        System.out.println("Working stack: " + workingStack);
//        System.out.println("Output stack: " + outputStack);
//        System.out.println("\n");

        boolean go = true;
        boolean result = true;

//        Iterator<String> workingStackIterator = workingStack.iterator();
//        Iterator<String> inputStackIterator = inputStack.iterator();

        while (go) {
            String currentParserHead = workingStack.peek();
            //String currentParserHead = workingStackIterator.next();
            //System.out.println("Working steak head: " + currentParserHead);
            String inputHead = inputStack.peek();
            //String inputHead = inputStackIterator.next();
            //System.out.println("Input steak head: " + inputHead);

            if (currentParserHead.equals("$") && inputHead.equals("$")) {
                return result;
            }

            Pair<String, String> heads = new Pair<>(currentParserHead, inputHead);
            //System.out.println(heads);
            Pair<List<String>, Integer> parseTableEntry = parsingTable.get(heads);
            //System.out.println("Parsing table entry: " + parseTableEntry);

            if (parseTableEntry == null) {
                heads = new Pair<>(currentParserHead, "ε");
                parseTableEntry = parsingTable.get(heads);
                if (parseTableEntry != null) {
                    workingStack.pop();
                    //workingStackIterator.remove();
                    continue;
                }
            }

            if (parseTableEntry == null) {
                go = false;
                result = false;
                System.out.println("Error: No entry in parsing table!");
            } else {
                handleParseTableEntry(parseTableEntry);
            }
//            System.out.println("Current Parser Stack: " + workingStack);
//            System.out.println("Input Stack: " + inputStack);
//            System.out.println("Production Stack: " + workingStack);
        }

        return result;
    }

    private void handleParseTableEntry(Pair<List<String>, Integer> parseTableEntry) {
        List<String> production = parseTableEntry.getKey();
        //System.out.println("Production: " + production);
        Integer productionPos = parseTableEntry.getValue();
        //System.out.println("Position: " + productionPos);

        if (productionPos == -1 && production.get(0).equals("acc")) {
            isParsingComplete = false;
        } else if (productionPos == -1 && production.get(0).equals("pop")) {
            workingStack.pop();
            inputStack.pop();
//            workingStackIterator.remove();
//            inputStackIterator.remove();
//            if (workingStackIterator.hasNext()) {
//                workingStackIterator.next();  // Move to the next element
//                workingStackIterator.remove();  // Remove the current element
//            }
//            if (inputStackIterator.hasNext()) {
//                inputStackIterator.next();  // Move to the next element
//                inputStackIterator.remove();  // Remove the current element
//            }
        } else {
//            System.out.println("Hi");
            workingStack.pop();
//            System.out.println("Hello");
            if (!production.get(0).equals("ε")) {
                pushAsChars(production, workingStack);
//                System.out.println(workingStack);
            }
            outputStack.push(productionPos.toString());
            System.out.println("Output: " + outputStack);
        }
    }


    private void initStacks(List<String> w) {
        inputStack.clear();
        inputStack.push("$");
        pushAsChars(w, inputStack);

        workingStack.clear();
        workingStack.push("$");
        workingStack.push(grammar.getStartSymbol());

        outputStack.clear();
        outputStack.push("ε");
    }

    private void pushAsChars(List<String> sequence, Stack<String> stack) {
        for (int i = sequence.size() - 1; i >= 0; i--) {
            stack.push(sequence.get(i));
        }
//        for(String symbol : sequence) {
//            stack.push(symbol);
//        }
    }
}
