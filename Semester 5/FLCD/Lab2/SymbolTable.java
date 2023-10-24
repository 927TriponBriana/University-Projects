import java.util.Hashtable;
import java.util.List;

public class SymbolTable<Value> {
    private CustomHashTable<Value> hashTable;

    public SymbolTable() {
        this.hashTable = new CustomHashTable<>();
    }

    public void add(Value value) {
        if(!hashTable.contains(value)) {
            hashTable.addToHashTable(value);
        }
    }

    public boolean contains(Value value) {
        return hashTable.contains(value);
    }

//    public void delete(Value value) {
//        hashTable.deleteFromHashTable(value);
//    }

    public boolean isEmpty() {
        return hashTable.isEmpty();
    }

    public int getSize() {
        return hashTable.size();
    }

    public int getPosition(Value value) {
        List<Value> allValues = hashTable.getAllValues();
        if(allValues.contains(value)) {
            return allValues.indexOf(value);
        }
        return -1; //if value does not exist
    }

    public int getBucketPosition(Value value) {
        int index = hashTable.getBucketPosition(value);
        return index;
    }

    public CustomHashTable getHashTable(){
        return hashTable;
    }
}
