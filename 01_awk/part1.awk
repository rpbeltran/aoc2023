BEGIN {
  FS = "[^0-9]+"
  sum = 0
}

{
   if ($1=="")
      $1=$2
   if ($NF=="")
      NF -= 1

   a = substr($1, 1, 1) 
   b = substr($NF, length($NF), 1)  

   sum += (a b)
}

END {
   print sum
}
