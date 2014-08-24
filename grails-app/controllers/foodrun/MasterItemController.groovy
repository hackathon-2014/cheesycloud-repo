package foodrun
import grails.converters.JSON
import grails.plugin.gson.converters.GSON
import grails.rest.RestfulController
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MasterItemController extends RestfulController {
    static responseFormats = ['json']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list(){
        render MasterItem.list() as JSON
    }

    @Transactional
    def save() {
        def masterItem = new MasterItem(request.GSON)
        masterItem.save(flush: true)
        render masterItem as GSON
    }

    @Transactional
    def delete() {
        def masterItem = new MasterItem(request.GSON)
        masterItem.save(flush: true)

        masterItem.delete(flush: true)
        def result = [success: true]
        render result as GSON
    }
}
