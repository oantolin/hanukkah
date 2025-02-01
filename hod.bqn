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

