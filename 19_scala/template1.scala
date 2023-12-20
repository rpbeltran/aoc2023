import scala.collection.mutable.ListBuffer
import scala.util.matching.Regex
object generated_1 {

    private var total = 0

    def next_flow(flow: String, x: Int, m: Int, a: Int, s: Int): String = {
        // @@ Playbooks @@
        System.exit(1)
        return "__unknown__"
    }

    def challenge(x: Int, m: Int, a: Int, s: Int) = {
        var flow = "in"
        while (flow != "__exit__") {
            flow = next_flow(flow, x, m, a, s);
            if (flow == "A") {
                total += x + m + a + s
                flow = "__exit__"
            }
            if (flow == "R") {
                flow = "__exit__"
            }
        }
    }

    def main(args: Array[String]) = {
        // @@ Challenges @@

        println(total)
    }
}