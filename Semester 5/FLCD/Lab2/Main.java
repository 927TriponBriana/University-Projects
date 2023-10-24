public class Main {

    public static void main(String[] args) {
        SymbolTable<String> identifierSymbolTable = new SymbolTable<>();
        SymbolTable<Integer> constantSymbolTable = new SymbolTable<>();

        identifierSymbolTable.add("x");
        identifierSymbolTable.add("y");
        constantSymbolTable.add(1);
        constantSymbolTable.add(6);
        constantSymbolTable.add(6);

//        System.out.println("Contains 'x': " + identifierSymbolTable.contains("x"));
//        System.out.println("Contains 'z': " + identifierSymbolTable.contains("z"));
//
//        System.out.println("Contains 1: " + constantSymbolTable.contains(1));
//        System.out.println("Contains 6: " + constantSymbolTable.contains(6));

        int position = constantSymbolTable.getPosition(1);
        if(position != -1) {
            System.out.println("Position of 1 is: " + position + "; in bucket: " + constantSymbolTable.getBucketPosition(1));
        }
        else{
            System.out.println("Value not found!");
        }
        int position1 = constantSymbolTable.getPosition(6);
        if(position1 != -1) {
            System.out.println("Position of 6 is: " + position1 + "; in bucket: " + constantSymbolTable.getBucketPosition(6));
        }
        else{
            System.out.println("Value not found!");
        }

        System.out.println(identifierSymbolTable.getHashTable());
        System.out.println(constantSymbolTable.getHashTable());
    }
}
