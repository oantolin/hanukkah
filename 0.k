/ For day 0 you just need to download the data and decrypt.
/ The password is the year in the hebrew calendar corresponding
/ to some date in 2017; it could be 5777 or 5778.

sh:{"\n"\`x((" "\"/usr/bin/env ",x);"")}

dldata:{
 sh "wget https://hanukkah.bluebird.sh/5784/noahs-jsonl.zip"
 sh "unzip -P 5777 noahs-jsonl.zip"
}

load:{
 json:{`j?/:0:"5784/noahs-",x,".jsonl"}
 (customers;orders;products)::json'("customers";"orders";"products")
 customers[`customerid]:_customers[`customerid]
 orders[`customerid]:_orders[`customerid]
 orders[`orderid]:_orders[`orderid]
}
