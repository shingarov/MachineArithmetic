Class {
	#name : #EIf,
	#superclass : #'ΛExpression',
	#instVars : [
		'cond',
		'trueE',
		'falseE'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
EIf class >> cond: cond trueE: trueE falseE: falseE [ 
	^self basicNew cond: cond; trueE: trueE; falseE: falseE ; yourself
]

{ #category : #verification }
EIf >> check: Γ rtype: t [
"
     Γ            ⊦ v  <== bool    
     Γ, _:{v}     ⊦ e1 <== t      
     Γ, _:{not v} ⊦ e2 <== t
     ----------------------------- [Chk-If]
     Γ ⊦ if v e1 e2 <== t
"
	| v e1 e2 cv xv pv tT tF c1 c2 |
	v := cond. e1 := trueE. e2 := falseE.
	cv := (EImm imm: v) check: Γ rtype: "rBool" TBool instance bTrue.
	pv := v .
	tT := pv predRType.
	tF := pv not predRType.
	xv := Γ grdSym.
	c1 := tT cAll: xv cstr: (e1 check: Γ rtype: t).
	c2 := tF cAll: xv cstr: (e2 check: Γ rtype: t).
	^c1 & c2
]

{ #category : #accessing }
EIf >> cond [
	^ cond
]

{ #category : #accessing }
EIf >> cond: anObject [
	cond := anObject
]

{ #category : #polymorphism }
EIf >> elabC: Γ rtype: t [
	| trueE_ falseE_ |
	trueE_ := trueE elabC: Γ rtype: t.
	falseE_ := falseE elabC: Γ rtype: t.
	^EIf cond: cond trueE: trueE_ falseE: falseE_
]

{ #category : #'reflect - embedding' }
EIf >> embed [
"
go (EIf i e1 e2 _)  = F.EIte (embedImm i) (go e1) (go e2)
"
	^EIte
		if: cond embed
		then: trueE embed
		else: falseE embed
]

{ #category : #accessing }
EIf >> falseE [
	^ falseE
]

{ #category : #accessing }
EIf >> falseE: anObject [
	falseE := anObject
]

{ #category : #'as yet unclassified' }
EIf >> goSubsTyExpr: su [ 
	^EIf cond: cond trueE: (trueE goSubsTyExpr: su) falseE: (falseE goSubsTyExpr: su)
]

{ #category : #GT }
EIf >> gtChildren [
	^{cond . trueE . falseE}

]

{ #category : #inlining }
EIf >> macroExpandEVar: f to: aΛExpr [
	^EIf
		cond: cond "this can only be an EVar, and at least for now we aren't considering reflecting on value-Bools"
		trueE: (trueE macroExpandEVar: f to: aΛExpr)
		falseE: (falseE macroExpandEVar: f to: aΛExpr)
]

{ #category : #accessing }
EIf >> trueE [
	^ trueE
]

{ #category : #accessing }
EIf >> trueE: anObject [
	trueE := anObject
]

{ #category : #'α-renaming' }
EIf >> uniq2: α [
	^self class
		cond: (cond uniq2: α)
		trueE: (trueE uniq2: α)
		falseE: (falseE uniq2: α).

]
