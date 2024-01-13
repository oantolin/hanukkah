/ For day 0 you just need to download the data and decrypt.
/ The password is the year in the hebrew calendar corresponding
/ to some date in 2017; it could be 5777 or 5778.

sh:{"\n"\`x((" "\"/usr/bin/env ",x);"")}

dldata:{
 sh "wget https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip"
 sh "unzip -P 5777 noahs-jsonl.zip"
}

load:{
 json:{{`j?x^"_"}'0:"5784/noahs-",x,".jsonl"}
 (customers;orders;products)::json'("customers";"orders";"products")
 customers[`customerid]:_customers[`customerid]
 orders[`customerid]:_orders[`customerid]
 orders[`orderid]:_orders[`orderid]
}

/ want a customer whose last name on a phonepad is his number

phone:(`c$"a"+!26)!2+&@[8#3;5 7;+;1]

lastname:{$[^("Jr.";"II";"III";"IV";"V")?*|x;*|x;x[(#x)-2]]}@" "\

d1:{
 phones:-"0"-customers[`phone]^\:"-"
 lastnames:(phone@_:lastname@)'customers[`name]
 *customers[`phone]@&phones~'lastnames}

/ want a JP who had bagels & cleaning supplies in 2017

d2:{
 bagels:products[`sku]@&{~^(" "\_x)?"bagel"}'products[`desc]
 cleaner:*products[`sku]@&"Rug Cleaner"~/:products[`desc]
 ords:&~{(^x[`sku]?z)|&/^x[`sku]?y}[;bagels;cleaner]'orders[`items]
 ords:(2017=`I$4#/:orders[`ordered]@)#ords
 custs:customers@customers[`customerid]?orders[ords;`customerid]
 custs:{{"JP"~x@!2}'x[`name]^\:" .",`c$"a"+!26}#custs
 *custs[`phone]}

/ want a cancer born in the year of the rabbit

/ chinese years don't exactly line up with gregorian ones,
/ so for example one year of the rabbit was from
/ 25 January 1963 to 12 February 1964, but if you are a cancer
/ you must be from the first of those calendar years, i.e.
/ a year that is 7 mod 12

/ cancer goes from june 22 to july 22

d3:{
 dob:(`I$"-"\)'customers[`birthdate]
 rabbit:7=12!dob[;0]
 cancer:((6=dob[;1])&21<dob[;2])|((7=dob[;1])&23>dob[;2])
 bydob:customers[`customerid]@&rabbit&cancer
 byrug:?orders[`customerid]@&{~&/^x[`sku]?"HOM2761"}'orders[`items]
 custs:customers@&|/'customers[`customerid]=\:2(bydob^)/byrug
 / this produces two people only one of which is male
 custs[1;`phone]}

/ want someone who bought pastries before 5am

d4:{
 times:+`y`M`d`h`m`s!+{`I$" "\@[x;&~^" -:"?x;:;" "]}'orders[`ordered]
 pastries:{&/"BKY"~/:3#/:x[`sku]}'orders[`items]
 ords:orders@&(0=2017 2019'times[`y])&(0=2 6'times[`h])&pastries
 custs:({1<{+/x`qty}'x`items}#ords)[`customerid]
 *customers[`phone]@customers[`customerid]??custs}
