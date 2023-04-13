package Model;

public class BoolType implements Type{
    @Override
    public boolean equals(Type anotherType){
//        if(anotherType instanceof BoolType){
//            return true;
//        }
//        else{
//            return false;
//        }
        return anotherType instanceof BoolType;
    }

    @Override
    public String toString(){
        return "bool";
    }

    @Override
    public Type deepCopy() {
        return new BoolType();
    }

    @Override
    public Value defaultValue(){
        return new BoolValue(false);
    }
}
