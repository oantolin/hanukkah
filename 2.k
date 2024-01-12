/ want a JP who had bagels & cleaning supplies in 2017

d2:{
 bagels:products[`sku]@&{~^(" "\_x)?"bagel"}'products[`desc]
 cleaner:*products[`sku]@&"Rug Cleaner"~/:products[`desc]
 ords:&~{(^x[`sku]?z)|&/^x[`sku]?y}[;bagels;cleaner]'orders[`items]
 ords:(2017=`I$4#/:orders[`ordered]@)#ords
 custs:customers@customers[`customerid]?orders[ords;`customerid]
 custs:{{"JP"~x@!2}'x[`name]^\:" .",`c$"a"+!26}#custs
 *custs[`phone]}
