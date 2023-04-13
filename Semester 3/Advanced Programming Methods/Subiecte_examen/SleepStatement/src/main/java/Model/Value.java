package Model;

public interface Value {
    Type getType();
    Value deepCopy();
}
