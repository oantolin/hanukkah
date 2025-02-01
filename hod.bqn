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

# Find someone whose last name gives you the phone number on the keypad

suffixes ← ⟨"I", "II", "III", "IV", "V", "Jr."⟩

LastName ⇐ ¯1⊑·(∊⟜suffixes⌾< ¯1⊸⊑)⊸↓ ' '⊸Split

D1 ⇐ {
 keypad ← 1+"adgjmptw"⊸⍋¨ LowerCase LastName¨ 𝕩.customers.name
 phones ← '0' -˜ '-'⊸≠⊸/¨ 𝕩.customers.phone
 ⊑ (phones ≡¨ keypad) / 𝕩.customers.phone
}
