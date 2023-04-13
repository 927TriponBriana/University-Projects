package Model;

public class StringValue implements Value{
    private String value;

    public StringValue(String value){
        this.value = value;
    }

    @Override
    public Type getType() {
        return new StringType();
    }

    @Override
    public boolean equals(Object anotherVal) {
        if (!(anotherVal instanceof StringValue)){
            return false;
        }
        StringValue castVal = (StringValue) anotherVal;
        return this.value.equals(castVal.value);
    }

    @Override
    public Value deepCopy() {
        return new StringValue(value);
    }

    public String getValue(){
        return this.value;
    }

    @Override
    public String toString() {
        return "\"" + this.value + "\"";
    }
}
