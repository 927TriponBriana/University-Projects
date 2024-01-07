//import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Table {
    private Map<Pair<String, String>, Pair<List<String>, Integer>> table = new HashMap<>();

    public void put(Pair<String, String> key, Pair<List<String>, Integer> value) {
        table.put(key, value);
    }

    public Pair<List<String>, Integer> get(Pair<String, String> key) {
        for(Map.Entry<Pair<String, String>, Pair<List<String>, Integer>> entry : table.entrySet()) {
            if(entry.getValue() != null) {
                Pair<String, String> currentKey = entry.getKey();
                Pair<List<String>, Integer> currentValue = entry.getValue();

                if (currentKey.equals(key)) {
                    return currentValue;
                }
            }
        }
        return null;
    }

    public boolean containsKey(Pair<String, String> key) {
        boolean result = false;
        for(Pair<String, String> currentKey : table.keySet()) {
            if (currentKey.getKey().equals(key.getKey()) && currentKey.getValue().equals(key.getValue())) {
                result = true;
                break;
            }
        }
        return !result;
    }

    @Override
    public String toString() {
        String result = "";

        for (Map.Entry<Pair<String, String>, Pair<List<String>, Integer>> entry : table.entrySet()) {
            Pair<String, String> key = entry.getKey();
            Pair<List<String>, Integer> value = entry.getValue();

            if (value != null) {
                result += String.format("M[%s,%s] = [%s,%d]%n",
                        key.getKey(), key.getValue(), value.getKey(), value.getValue());
            }
        }

        return result;
    }
}
