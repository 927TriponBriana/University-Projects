package Model;

public class IntType implements Type{
    @Override
    public boolean equals(Type anotherType){
//        if(anotherType instanceof IntType){
//            return true;
//        }
//        else{
//            return false;
//        }
        return anotherType instanceof IntType;
    }

    @Override
    public String toString(){
        return "int";
    }

    @Override
    public Type deepCopy() {
        return new IntType();
    }

    @Override
    public Value defaultValue(){
        return new IntValue(0);
    }
}
