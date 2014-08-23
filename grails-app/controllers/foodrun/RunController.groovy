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

        JSON.use('deep')
        render Run.list() as JSON
    }

    @Transactional
    def save() {
        def run = new Run(request.GSON)
        run.date = new Date()

        run.save(flush: true)
        render run as GSON
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
