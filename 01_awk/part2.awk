# Day 2 is just a preprocessing pass for day 1.
# Run as:
#   awk -f day1b.awk day1a.input | awk -f day1a.awk
{
   gsub(/one/, "o1e")
   gsub(/two/, "t2o")
   gsub(/three/, "t3e")
   gsub(/four/, "f4r")
   gsub(/five/, "f5e")
   gsub(/six/, "s6x")
   gsub(/seven/, "s7n")
   gsub(/eight/, "e8t")
   gsub(/nine/, "n9e")
   gsub(/zero/, "z0o")
   print
}


