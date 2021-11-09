package perfomance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

 val protocol = karateProtocol(
   "/api/articles/{articleId}" -> Nil
 )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("create article").exec(karateFeature("classpath:ConduitApp/perfomance/CreateArticle.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(3)
      ).protocols(protocol)
  )
  
}