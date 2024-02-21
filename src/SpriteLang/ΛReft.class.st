Class {
	#name : #'ΛReft',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛReft class >> new [
"
instance Monoid Reft where
  mempty = KReft v r where F.Reft (v, r) = mempty
"
	^KnownReft new
]

{ #category : #semigroup }
ΛReft >> , anotherReft [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ΛReft >> collect: aBlock [ 
	^aBlock value: self
]

{ #category : #'fresh monad' }
ΛReft >> freshR: Γ _: t [
"
freshR :: F.SrcSpan -> Env -> F.Sort -> Reft -> CG Reft
"
	self subclassResponsibility
]

{ #category : #testing }
ΛReft >> isKnown [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ΛReft >> refactorAppR: _ [
	^self
]

{ #category : #SubARef }
ΛReft >> subsAR: p ar: ar [
	^self
]

{ #category : #'F.Subable' }
ΛReft >> subst1: su [
	"instance F.Subable Reft where..."
	self subclassResponsibility
]

{ #category : #'F.Subable' }
ΛReft >> subst: f [
	"instance F.Subable Reft where..."
	self subclassResponsibility
]

{ #category : #'F.Subable' }
ΛReft >> substa: f [
	"instance F.Subable Reft where..."
	self subclassResponsibility
]

{ #category : #'F.Subable' }
ΛReft >> substf: f [
	"instance F.Subable Reft where..."
	self subclassResponsibility
]

{ #category : #'F.Subable' }
ΛReft >> syms [
	"instance F.Subable Reft where..."
	self subclassResponsibility
]

{ #category : #'α-renaming' }
ΛReft >> uniq2: α [
	"α-rename all variables. Returns a copy of receiver with all names unique."

	self subclassResponsibility.
]
