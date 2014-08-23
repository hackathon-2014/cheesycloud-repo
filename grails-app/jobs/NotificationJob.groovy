import foodrun.Run
/**
 * Created by ajdanelz on 8/23/14.
 */
class NotificationJob {
    static triggers = {
        simple name:'simpleTrigger', startDelay:10000, repeatInterval: 30000, repeatCount: 10
    }
    def group = "MyGroup"
    def description = "Example job with Cron Trigger"
    def execute(){
        long theFuture = System.currentTimeMillis() + (86400 * 7 * 1000)
        Date nextWeek = new Date(theFuture)
        Run.findAllByDateBetween(new Date(), nextWeek).each {
            if(!it.reminded){

//                def http = new HTTPBuilder( 'https://www.textmagic.com' )
//
//                // perform a GET request, expecting JSON response data
//                http.request(Method.GET, JSON ) {
//                    uri.path = '/app/api'
//                    uri.query = [username: 'scoobah36',
//                                 password: 'hz0qOb49SF',
//                                 cmd     : 'send',
//                                 text    : 'Test Message',
//                                 phone   : '17075694010',
//                                 unicode : '0'
//                    ]
//                }
                it.reminded = true
                it.save(flush: true)
            }
        }

        print "Job run!"
    }
}
