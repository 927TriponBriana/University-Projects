package Model;

public class RefValue implements Value{
    private int address;
    private Type locationType;

    public RefValue(int address, Type locationType){
        this.address = address;
        this.locationType = locationType;
    }

    @Override
    public String toString() {
        return String.format("(%d, %s)", address, locationType);
    }

    @Override
    public Type getType() {
        return new RefType(locationType);
    }

    public int getAddress(){
        return address;
    }

    public Type getLocationType(){
        return locationType;
    }

    @Override
    public Value deepCopy() {
        return new RefValue(address, locationType.deepCopy());
    }
}
