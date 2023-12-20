import scala.collection.mutable.ListBuffer
import scala.util.matching.Regex
object generated_2 {
    private var total = 0

    def next_flow(flow: String, x: Int, m: Int, a: Int, s: Int): String = {
        // @@ Playbooks @@
        System.exit(1)
        return "__unknown__"
    }

    def challenge(x: Int, m: Int, a: Int, s: Int): Boolean = {
        var flow = "in"
        while (true) {
            flow = next_flow(flow, x, m, a, s);
            if (flow == "A")
                return true
            if (flow == "R")
                return false
        }
        return false
    }

    def main(args: Array[String]) = {
        // @@ Challenges @@

        var i = 0;
        var total = BigInt(0)
        for ((x, xs) <- (x_challenges zip x_spans)) {
            println(f"Status: $i%d / 251")
            i += 1
            for ((m, ms) <- (m_challenges zip m_spans)) {
                for ((a, as) <- (a_challenges zip a_spans)) {
                    for ((s, ss) <- (s_challenges zip s_spans)) {
                        if (challenge(x, m, a, s)) {
                            total += xs * ms * as * ss
                        }
                    }
                }
            }
        }
        println(total)

    }
}