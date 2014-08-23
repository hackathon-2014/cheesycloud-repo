package foodrun

class Run {

    Date date

    static hasMany = [items: Item]

    static constraints = {
    }
}
