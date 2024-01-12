phone:(`c$"a"+!26)!2+&@[8#3;5 7;+;1]

lastname:{$[^("Jr.";"II";"III";"IV";"V")?*|x;*|x;x[(#x)-2]]}@" "\

d1:{
 phones:-"0"-customers[`phone]^\:"-"
 lastnames:(phone@_:lastname@)'customers[`name]
 *customers[`phone]@&phones~'lastnames}
