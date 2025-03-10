"
type KVEnv a  = HashMap Language.Fixpoint.Symbol (Language.Fixpoint.Horn.Info.KVInfo a)

Cf. Horn/Info.hs
"
Class {
	#name : #KVEnv,
	#superclass : #Dictionary,
	#category : #'Refinements-Horn'
}
