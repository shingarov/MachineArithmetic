"
Sprite's own concept of vulgar type.
"
Class {
	#name : #'ΛBase',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛBase class >> new [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
ΛBase >> bTrue [
"
bTrue :: Base -> RType
bTrue b = TBase b mempty

Here TBase parametrizes over r, but the result needs to be
RType where r=Reft, here Reft meaning ΛReft.
"
	^TBase b: self r: ΛReft new
]

{ #category : #'as yet unclassified' }
ΛBase >> baseSort [
	self subclassResponsibility 
]

{ #category : #polymorphism }
ΛBase >> bsubst: t tVar: a reft: r [
	^TBase b: self r: r
]

{ #category : #'as yet unclassified' }
ΛBase >> freeTVarsGoB [
	^Set new
]

{ #category : #'α-renaming' }
ΛBase >> rename: a to: b [
	"Because #rename:to: only renames expr-level vars
	 (cf. Expr>>rename:to:), and Sprite base types are
	 not dependent on expressions, do nothing."
	^self
]
