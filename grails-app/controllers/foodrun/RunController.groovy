package foodrun



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RunController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Run.list(params), model:[runInstanceCount: Run.count()]
    }

    def show(Run runInstance) {
        respond runInstance
    }

    def create() {
        respond new Run(params)
    }

    @Transactional
    def save(Run runInstance) {
        if (runInstance == null) {
            notFound()
            return
        }

        if (runInstance.hasErrors()) {
            respond runInstance.errors, view:'create'
            return
        }

        runInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'run.label', default: 'Run'), runInstance.id])
                redirect runInstance
            }
            '*' { respond runInstance, [status: CREATED] }
        }
    }

    def edit(Run runInstance) {
        respond runInstance
    }

    @Transactional
    def update(Run runInstance) {
        if (runInstance == null) {
            notFound()
            return
        }

        if (runInstance.hasErrors()) {
            respond runInstance.errors, view:'edit'
            return
        }

        runInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Run.label', default: 'Run'), runInstance.id])
                redirect runInstance
            }
            '*'{ respond runInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Run runInstance) {

        if (runInstance == null) {
            notFound()
            return
        }

        runInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Run.label', default: 'Run'), runInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'run.label', default: 'Run'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
