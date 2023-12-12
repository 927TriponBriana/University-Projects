import java.util.*;

public class Parser {
    private Grammar grammar;
    private Map<String, Set<String>> firstSet;

    public Parser(Grammar grammar){
        this.grammar = grammar;
        this.firstSet = new HashMap<>();
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
}
