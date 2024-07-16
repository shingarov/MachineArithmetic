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

{ #category : #'refinement typing' }
ΛBase >> bTrue [
"
bTrue :: Base -> RType
bTrue b = TBase b mempty

Here TBase parametrizes over r, but the result needs to be
RType where r=Reft, here Reft meaning ΛReft.
"
	^TBase b: self r: ΛReft new
]

{ #category : #'refinement typing' }
ΛBase >> baseSort [
	self subclassResponsibility 
]

{ #category : #polymorphism }
ΛBase >> bsubst: t tVar: a reft: r [
	^TBase b: self r: r
]

{ #category : #'refinement typing' }
ΛBase >> freeTVarsGoB [
	^Set new
]

{ #category : #'α-renaming' }
ΛBase >> uniq2: α [
	"α-rename all variables. Returns a copy of receiver with all names unique."

	self subclassResponsibility.
]
