"
type KVEnv a  = HashMap Language.Fixpoint.Symbol (Language.Fixpoint.Horn.Info.KVInfo a)
"
Class {
	#name : #KVEnv,
	#superclass : #Dictionary,
	#category : #Refinements
}
