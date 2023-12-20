import java.io._
import scala.collection.mutable.ListBuffer
import scala.util.matching.Regex


object Part2 {

    var playbooks: String = "";
    var challenges: String = "";

    var x_challenges = ListBuffer[(Int, Boolean)]();
    var m_challenges = ListBuffer[(Int, Boolean)]();
    var a_challenges = ListBuffer[(Int, Boolean)]();
    var s_challenges = ListBuffer[(Int, Boolean)]();

    def rewrite_playbook(line: String): String = {
        val pre = "        "
        val parts = line.split("[\\{,|\\}]");
        var rewrite = f"\n$pre%sif (flow == \""
        for ((part,i) <- parts.zipWithIndex) {
            if (i == 0) {
                rewrite += f"$part%s\") {\n"
            } else if (i == parts.length-1) {
                rewrite += f"$pre%s    return \"$part%s\"\n"
            } else {
                ("""(\w+)([><])(\d+):(\w+)""".r).findAllIn(part).matchData foreach {
                    m => {
                        val a = m.group(1)
                        val c = m.group(2)
                        val i = m.group(3)
                        val f = m.group(4)
                        a match {
                            case "x" => {
                                x_challenges += ((i.toInt, (c == "<")))
                            }
                            case "m" => {
                                m_challenges += ((i.toInt, (c == "<")))
                            }
                            case "a" => {
                                a_challenges += ((i.toInt, (c == "<")))
                            }
                            case "s" => {
                                s_challenges += ((i.toInt, (c == "<")))
                            }
                        }
                        rewrite += f"$pre%s    if ($a%s $c%s $i%s) {\n"
                        rewrite += f"$pre%s        return \"$f%s\"\n"
                        rewrite += f"$pre%s    }\n"
                    }
                }
            }
        }
        return rewrite + pre + "}";
    }

    def generate_challenge(name: String, values: ListBuffer[Int]) = {
        challenges += f"        val $name%s: List[Int] = List("
        values.zipWithIndex foreach {
            (v, i) => {
                challenges += (
                    if (i != values.length - 1) then 
                        f"$v%d, " 
                    else 
                        f"$v%d"
                )
            }
        }
        challenges += ")\n";
    }

    def generate_big_challenge(name: String, values: ListBuffer[Int]) = {
        challenges += f"        val $name%s: List[BigInt] = List("
        values.zipWithIndex foreach {
            (v, i) => {
                challenges += (
                    if (i != values.length - 1) then 
                        f"BigInt($v%d), " 
                    else 
                        f"BigInt($v%d)"
                )
            }
        }
        challenges += ")\n";
    }


    def generate_challenges(name: String, values: ListBuffer[(Int, Boolean)] ) = {
        var tests = ListBuffer[Int]();
        var spans = ListBuffer[Int]();
        var start = 1
        for (i <- 0 to values.length-1) {

            var span = values(i)._1 - start
            start = values(i)._1
            if (! values(i)._2) {
                span = span + 1
                start = values(i)._1 + 1
            }
            tests += start - 1
            spans += span
        }
        tests += 4000
        spans += 4000 - start + 1

        generate_challenge(f"$name%s_challenges", tests)
        generate_big_challenge(f"$name%s_spans", spans)
    }

    def generate_code_fills() = {
        var after_blank_line = false;
        for (line <- io.Source.fromFile("input.txt").getLines()) {
            if (line == "") {
                after_blank_line = true;
            } else if (!after_blank_line) {
                playbooks += rewrite_playbook(line)
            }
        }

        x_challenges = x_challenges.sorted
        m_challenges = m_challenges.sorted
        a_challenges = a_challenges.sorted
        s_challenges = s_challenges.sorted

        generate_challenges("x", x_challenges)
        generate_challenges("m", m_challenges)
        generate_challenges("a", a_challenges)
        generate_challenges("s", s_challenges)
    }

    def fill_template(): String = {
        val template = io.Source.fromFile("template2.scala").mkString
        return template.replace(
            "// @@ Playbooks @@", 
            playbooks
        ).replace(
            "        // @@ Challenges @@",
            challenges
        )
    }

    def main(args: Array[String]) = {
        generate_code_fills()
        var generated_scala_program = fill_template();       

        val fileWriter = new FileWriter(new File("generated_2.scala"))
        fileWriter.write(generated_scala_program)
        fileWriter.close()
    }
}