import java.io._
import scala.collection.mutable.ListBuffer
import scala.util.matching.Regex


object Part1 {

    var playbooks: String = "";
    var challenges: String = "";

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
                        rewrite += f"$pre%s    if ($a%s $c%s $i%s) {\n"
                        rewrite += f"$pre%s        return \"$f%s\"\n"
                        rewrite += f"$pre%s    }\n"
                    }
                }
            }
        }
        return rewrite + pre + "}";
    }

    def rewrite_challenge(line: String): String = {
        var rewrite = "";
        val pre = "\n        "
        ("""\{x=(\d+),m=(\d+),a=(\d+),s=(\d+)\}""".r).findAllIn(line).matchData foreach {
            m => {
                val x_val = m.group(1)
                val m_val = m.group(2)
                val a_val = m.group(3)
                val s_val = m.group(4)
                rewrite = f"challenge($x_val%s, $m_val%s, $a_val%s, $s_val%s)"
            }
        }
        return pre + rewrite;
    }

    def generate_code_fills() = {
        var after_blank_line = false;
        for (line <- io.Source.fromFile("input.txt").getLines()) {
            if (line == "") {
                after_blank_line = true;
            } else if (after_blank_line) {
                challenges += rewrite_challenge(line)
            } else {
                playbooks += rewrite_playbook(line)
            }
        }
    }

    def fill_template(): String = {
        val template = io.Source.fromFile("template1.scala").mkString
        return template.replace("// @@ Playbooks @@", playbooks).replace("// @@ Challenges @@", challenges)
    }

    def main(args: Array[String]) = {
        generate_code_fills()
        var generated_scala_program = fill_template();

        val fileWriter = new FileWriter(new File("generated_1.scala"))
        fileWriter.write(generated_scala_program)
        fileWriter.close()
    }
}