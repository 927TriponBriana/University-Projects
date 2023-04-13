package Model;

public class RefType implements Type{
    private Type inner;

    public RefType(Type inner){
        this.inner = inner;
    }

    Type getInner(){
        return this.inner;
    }

    @Override
    public String toString() {
        return String.format("Ref(%s)", inner);
    }

    @Override
    public boolean equals(Type another) {
        if(another instanceof RefType){
            return inner.equals(((RefType)another).getInner());
        }
        else{
            return false;
        }
    }

    @Override
    public Value defaultValue() {
        return new RefValue(0, inner);
    }

    @Override
    public Type deepCopy() {
        return new RefType(inner.deepCopy());
    }
}
