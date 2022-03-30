Class {
	#name : #EAnn,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'rtype'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
EAnn class >> expr: e rtype: t [ 
	^ self basicNew
		expr: e;
		rtype: t;
		yourself
]

{ #category : #accessing }
EAnn >> expr [
	^ expr
]

{ #category : #accessing }
EAnn >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
EAnn >> rtype [
	^ rtype
]

{ #category : #accessing }
EAnn >> rtype: anObject [
	rtype := anObject
]

{ #category : #'as yet unclassified' }
EAnn >> synth: Γ [
"
{- [Syn-Ann]
  
     Γ |- e <== t
     ----------------- 
     Γ |- e:t => t
  
  -}
  synth g (EAnn e t _) = do
    c <- check g e t
    return (c, t)
"
	| c |
	c := expr check: Γ rtype: rtype.
	^{ c . rtype }
]
