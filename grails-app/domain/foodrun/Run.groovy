package foodrun

class Run {

    Date date
    String name
    Boolean reminded

    static hasMany = [items: Item]

    static mapping = {
        items lazy: false
    }

    static constraints = {
        reminded default: false, nullable: true
    }
}
