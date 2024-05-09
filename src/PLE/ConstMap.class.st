"
-- ValueMap maps expressions to constants (including data constructors)
  type ConstMap = M.HashMap Expr Expr
  type LDataCon = Symbol              -- Data Constructors

cf. PLE.hs
"
Class {
	#name : #ConstMap,
	#superclass : #Dictionary,
	#category : #PLE
}
