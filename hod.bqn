csv ⇐ BQNLib "csv"

DLData ⇐ {𝕤
 •SH ⟨"wget", "https://hanukkah.bluebird.sh/5784/noahs-csv.zip"⟩
 •SH ⟨"unzip", "-P", "5777", "noahs-csv.zip"⟩
}

LoadTable ⇐ {
 h‿t ← (⊑⋈(⍉∘>1↓¯1↓⊢)) csv.Split •FChars "5784/noahs-"∾𝕩∾".csv"
 (•BQN "{["∾(1↓∾','∾¨h)∾"]⇐𝕩}")∘⊢ •ParseFloat¨⎊⊢˘t
}
 
Load ⇐ {𝕤
 customers‿orders‿items‿products ⇐ LoadTable¨ ⟨
  "customers", "orders", "orders_items", "products"
 ⟩
}

# String utilities

Split ⇐  ((⊢-˜+`×¬)=)⊔⊢                # from bqncrate

LowerCase ⇐ (('a'-'A')×'A'⊸≤∧≤⟜'Z')⊸+

# Find someone with phone number = last name on the keypad

suffixes ← ⟨"I", "II", "III", "IV", "V", "Jr."⟩

LastName ⇐ ¯1⊑·(∊⟜suffixes⌾< ¯1⊸⊑)⊸↓ ' '⊸Split

D1 ⇐ { ⟨c⇐customers⟩ :
 keypad ← 1+"adgjmptw"⊸⍋¨ LowerCase LastName¨ c.name
 phones ← '0' -˜ '-'⊸≠⊸/¨ c.phone
 ⊑ (phones ≡¨ keypad) / c.phone
}

# Find a JP who bought bagels in 2017

D2 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 jp ← c.customerid /˜ ("J P"≡3↑'a'⊸>⊸/)¨ c.name
 bo ← i.orderid /˜ i.sku ∊ p.sku /˜ "Bagel"⊸(∨´⍷)¨ p.desc
 m ← (o.customerid∊jp) ∧  (o.orderid∊bo) ∧ ("2017"≡4⊸↑)¨o.ordered
 c.phone ⊑˜ c.customerid ⊐ m/o.customerid
}

# Find a Cancer born in a year of the rabbit who bought rug
# cleaner

# Chinese years don't exactly line up with Gregorian ones,
# so for example one year of the rabbit was from 25 January
# 1963 to 12 February 1964, but if you are a Cancer you must
# be from the first of those calendar years, i.e. a year
# that is 7 mod 12. Cancer goes from June 22 to July 22.

D3 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 [y,m,d] ← ⍉ > •ParseFloat¨∘('-'⊸Split)¨ c.birthdate
 dob ← (7=12|y) ∧ ((m=6)∧d≥22) ∨ ((m=7)∧d≤22)
 rco ← i.orderid /˜ i.sku ∊ p.sku /˜ "Rug Cleaner"⊸(∨´⍷)¨ p.desc
 brc ← o.customerid /˜ o.orderid ∊ rco
 (dob ∧ c.customerid ∊ brc) / ⍉[c.name, c.birthdate, c.phone]
}

# Find a woman who bought pastries before 5am circa 2017

D4 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 bakery ← o.orderid ∊ i.orderid /˜ i.sku ∊ ("BKY"≡3⊸↑)¨⊸/ p.sku
 orders ← 4=10⊸×⊸+˝-'0'-⍉11‿12⊸⊏˘>bakery/o.ordered
 earlybird ← ⊑ ((⌈´⊸=≠¨∘⊔∘⊐)/⍷) orders/bakery/o.customerid
 c.phone /˜ c.customerid = earlybird
}

# Find a woman from Staten Island that buys the most cat food

D5 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 cf ← p.sku /˜ "Cat Food"⊸(∨´⍷)¨ p.desc
 si ← c.customerid /˜ "Staten Island"⊸(∨´⍷)¨c.citystatezip
 sicf ← (o.customerid∊si) ∧ o.orderid∊i.orderid /˜ i.sku∊cf
 ⊑ c.phone ⊏˜ c.customerid ⊐ ⌈´⊸=∘⊒⊸/ sicf / o.customerid
}

# Find someone who uses so many coupons Noah's loses money

D6 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 fow ← i.unitprice÷p.wholesalecost⊏˜p.sku⊐i.sku
 ! o.orderid ≡ ⍷ i.orderid # already lines up!
 deals ← o.customerid ((+´1⊸>)¨⊐⊸⊔) i.orderid ((+´÷≠)¨⊐⊸⊔) fow
 c.phone ⊑˜ c.customerid ⊐ (⌈´⊸=deals)/⍷o.customerid
}

# Find someone who made a purchase close in time to person from day 6,
# of the same item in a different color

D7 ⇐ { ⟨c⇐customers,o⇐orders,i⇐items,p⇐products⟩ :
 w ← c.customerid ⊑˜ ⊑ c.phone ⊐ <D6 𝕩
 s ← ⍷ i.sku ⊏˜ i.orderid ⊐ o.orderid /˜ o.customerid = w
 s /˜↩ > '(' ∊¨ p.desc ⊏˜ p.sku ⊐ s
 o.customerid ⊏˜ o.orderid ⊐ ⍷ i.orderid /˜ i.sku ∊ s
}
