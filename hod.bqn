csv ⇐ BQNLib "csv"

DLData ⇐ {𝕤
 •SH ⟨"wget", "https://hanukkah.bluebird.sh/5784/noahs-csv.zip"⟩
 •SH ⟨"unzip", "-P", "5777", "noahs-csv.zip"⟩
}

LoadTable ⇐ {
 h‿t ← (⊑⋈⍉∘>∘(1⊸↓)∘(¯1⊸↓)) csv.Split •FChars "5784/noahs-"∾𝕩∾".csv"
 (•BQN "{["∾(1↓∾','∾¨h)∾"]⇐𝕩}") {𝕎𝕩} •ParseFloat¨⎊⊢˘t
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
 jpIDs ← c.customerid ⊏˜ / ("J P"≡3↑'a'⊸>⊸/)¨ c.name
 bagelSKUs ← ("Bagel"⊸(∨´⍷)¨ p.desc) / p.sku
 bagelOrderIDs ← (∊⟜bagelSKUs⌾<¨ i.sku) / i.orderid
 id ← (∧´⟨o.orderid∊bagelOrderIDs
          ("2017"≡4⊸↑)¨o.ordered
          o.customerid∊jpIDs⟩) / o.customerid
 c.phone ⊑˜ c.customerid⊐id
}
