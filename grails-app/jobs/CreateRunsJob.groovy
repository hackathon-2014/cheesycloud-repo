import foodrun.Item
import foodrun.MasterItem
import foodrun.Run

/**
 * Created by ajdanelz on 8/23/14.
 */
class CreateRunsJob {
    static triggers = {
        simple name:'simpleTrigger', startDelay:10000, repeatInterval: 30000, repeatCount: 10
    }
    def group = "MyGroup"
    def description = "Example job with Cron Trigger"

    def getFutureDate(Integer intverval){
        long theFuture = System.currentTimeMillis() + (86400 * intverval * 1000)
        return new Date(theFuture)
    }

    def getFutureDate(Date date, Integer intverval){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DATE, intverval);
        return c.getTime()
    }

    def getPastDate(Integer intverval){
        long theFuture = System.currentTimeMillis() - (86400 * intverval * 1000)
        return new Date(theFuture)
    }

    def compareDateDays(Date one, Date two){
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(one);
        cal2.setTime(two);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }

    def execute(){
        MasterItem.list().each {mItem ->
            def runs = Run.findAllByDateBetween(getPastDate(mItem.dayInterval), getFutureDate(mItem.dayInterval))
            runs.each { run ->
                Item foundItem = run.items.find{it.name == mItem.name}
                if(foundItem){

                    def foundRun = Run.findAllByDateGreaterThan(new Date()).find{compareDateDays(it.date, getFutureDate(run.date, mItem.dayInterval))}
                    if(!foundRun){
                        foundRun = new Run()
                        foundRun.date = getFutureDate(run.date, mItem.dayInterval)
                        foundRun.name = "Future Run"
                    }
                    if(!foundRun.items.find{it.name == mItem.name}){
                        Item item = new Item()
                        item.name = mItem.name
                        item.amount = mItem.amount
                        item.run = foundRun
                        item.save()
                        if(!foundRun.items){
                            foundRun.items = new HashSet<Item>()
                        }
                        foundRun.items.add(item)
                        foundRun.save(flush: true)
                    }
                }
            }

        }

        print "Job run!"
    }
}
