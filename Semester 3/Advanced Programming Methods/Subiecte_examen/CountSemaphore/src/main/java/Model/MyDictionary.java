package Model;

import Exceptions.InterpreterException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Set;

public class MyDictionary<Key, Val> implements MyIDictionary<Key, Val>{
    HashMap<Key, Val> dictionary;

    public MyDictionary(){
        this.dictionary = new HashMap<>();
    }

    @Override
    public boolean isDefined(Key key){
        return this.dictionary.containsKey(key);
    }

    @Override
    public void put(Key key, Val val){
        this.dictionary.put(key, val);
    }

    @Override
    public Val lookUp(Key key) throws InterpreterException {
        if(!isDefined(key)){
            throw new InterpreterException(key + "is not defined.");
        }
        return this.dictionary.get(key);
    }

    @Override
    public void update(Key key, Val val) throws InterpreterException{
        if(!isDefined(key)){
            throw new InterpreterException(key + "is not defined.");
        }
        this.dictionary.put(key, val);
    }

    @Override
    public Collection<Val> values(){
        return this.dictionary.values();
    }

    @Override
    public void remove(Key key) throws InterpreterException{
        if(!isDefined(key)){
            throw new InterpreterException(key + "is not defined.");
        }
        this.dictionary.remove(key);
    }

    @Override
    public HashMap<Key, Val> getContent() {
        return dictionary;
    }

    @Override
    public Set<Key> keySet(){
        return dictionary.keySet();
    }

    @Override
    public MyIDictionary<Key, Val> deepCopy() throws InterpreterException{
        MyIDictionary<Key, Val> toReturn = new MyDictionary<>();
        for (Key key: keySet()){
            toReturn.put(key, lookUp(key));
        }
        return toReturn;
    }

    @Override
    public String toString(){
        return this.dictionary.toString();
    }
}
