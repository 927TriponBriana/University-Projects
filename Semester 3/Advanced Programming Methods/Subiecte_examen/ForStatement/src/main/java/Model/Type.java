package Model;

public interface Type {
    boolean equals(Type another);
    Value defaultValue();
    Type deepCopy();
}
