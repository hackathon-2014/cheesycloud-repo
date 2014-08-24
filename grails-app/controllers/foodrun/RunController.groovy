package foodrun

import grails.converters.JSON
import grails.plugin.gson.converters.GSON
import grails.rest.RestfulController
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RunController extends RestfulController {
    static responseFormats = ['json']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def list(){

        JSON.use('deep');
        render Run.list() as JSON
    }

    @Transactional
    def save() {
        def run = new Run(request.GSON)
        run.save(flush: true)
        render run as GSON
    }

    @Transactional
    def itemSave() {
        def json = request.JSON
        def item = Item.get(json?.id as Long ?: 0)
        if(item){
            item.checked = json.checked
            item.name = json.name
            item.amount = json.amount
        }else{
            item = new Item(json)
        }
        item.save(flush: true)
        render item as GSON
    }

    @Transactional
    def itemDelete() {
        def item = new Item(request.GSON)
        def run = item.getRun()
        run.removeFromItems(item)
        run.save(flush: true)
        item.delete(flush: true)
        def result = [success: true]
        render result as GSON
    }


    @Transactional
    def delete() {
        def run = new Run(request.GSON)
        run.date = new Date()

        run.delete(flush: true)
        def result = [success: true]
        render result as GSON
    }
}
