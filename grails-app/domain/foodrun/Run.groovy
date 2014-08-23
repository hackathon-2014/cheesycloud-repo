package foodrun

class Run {

    Date date
    String name

    static hasMany = [items: Item]
    static mappedBy = [items: "run"]

    static mapping = {
        items lazy: false
    }

    static constraints = {
    }
}
