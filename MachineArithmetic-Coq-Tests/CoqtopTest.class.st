Class {
	#name : #CoqtopTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Coq-Tests'
}

{ #category : #tests }
CoqtopTest >> testCreateCoqtop [
	| coqtop |
	coqtop := Coqtop new.
	coqtop start.
	coqtop about.
	coqtop advance: 'Theorem implication: forall A B : Prop, A -&gt; (A -&gt; B) -&gt; B.'.
	coqtop advance: 'intros A B.'.
	coqtop goal.
]
