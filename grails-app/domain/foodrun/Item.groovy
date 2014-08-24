package foodrun

class Item {

    String name
    Integer amount
    boolean checked


    static belongsTo = [run: Run]

    static constraints = {
        run nullable: true
    }

    static mapping = {
    }
}
