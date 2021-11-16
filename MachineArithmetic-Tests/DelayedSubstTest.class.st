Class {
	#name : #DelayedSubstTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #tests }
DelayedSubstTest >> testPrint1 [
	| ds |
	ds := DelayedSubst from: 'a' to: 'b' in: #dummy.
	self assert: ds printString equals: '#dummy[b/a]'
	
]

{ #category : #tests }
DelayedSubstTest >> testPrintMany [
	| substs ds |
	substs := Dictionary newFromAssociations: { 'a'->'b'. 'x'->'y'. }.
	ds := DelayedSubst subst: substs in: #dummy.
	self assert: (ds printString includesSubstring: 'x/y')
	
]
