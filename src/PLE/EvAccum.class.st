"
type EvAccum = S.HashSet (Expr, Expr)
cf. PLE.hs

Contains accumulated equalities.
"
Class {
	#name : #EvAccum,
	#superclass : #Set,
	#category : #PLE
}
