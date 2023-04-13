package Model;

import Exceptions.InterpreterException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Set;

public interface MyIDictionary <Key,Val>{
    boolean isDefined(Key key);
    void put(Key key, Val val);
    Val lookUp(Key key) throws InterpreterException;
    void update(Key key, Val val) throws InterpreterException;
    Collection<Val> values();
    void remove(Key key) throws InterpreterException;
    Set<Key> keySet();

    HashMap<Key, Val> getContent();
    MyIDictionary<Key, Val> deepCopy() throws InterpreterException;
}
