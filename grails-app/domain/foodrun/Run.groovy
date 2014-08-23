package foodrun

class Run {

    Date date

    static hasMany = [items: Item]

    static mapping = {
        items lazy: false
    }

    static constraints = {
    }
}
