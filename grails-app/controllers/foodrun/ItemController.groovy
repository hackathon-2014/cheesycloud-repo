package foodrun
import grails.converters.JSON
import grails.plugin.gson.converters.GSON
import grails.rest.RestfulController
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ItemController extends RestfulController {
    static responseFormats = ['json']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def listByRun(){
        def run = new Run(request.GSON)
        render Item.findAllByRun(run).sort{it.id} as JSON
    }

    @Transactional
    def save() {
        def item = new Item(request.GSON)
        item.save(flush: true)
        render item as GSON
    }


    @Transactional
    def delete() {
        def item = new Item(request.GSON)
        item.date = new Date()

        item.delete(flush: true)
        def result = [success: true]
        render result as GSON
    }
}
