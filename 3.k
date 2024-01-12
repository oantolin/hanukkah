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

