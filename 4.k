/ want someone who bought pastries before 5am

d4:{
 times:+`y`M`d`h`m`s!+{`I$" "\@[x;&~^" -:"?x;:;" "]}'orders[`ordered]
 pastries:{&/"BKY"~/:3#/:x[`sku]}'orders[`items]
 ords:orders@&(0=2017 2019'times[`y])&(0=2 6'times[`h])&pastries
 custs:({1<{+/x`qty}'x`items}#ords)[`customerid]
 *customers[`phone]@customers[`customerid]??custs}
