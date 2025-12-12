"
See LH-Proper because this does not exist in upstream Sprite.

data RType c tv r
  = ...
  | RRTy  {
      rt_env   :: ![(Symbol, RType c tv r)]
    , rt_ref   :: !r
    , rt_obl   :: !Oblig
    , rt_ty    :: !(RType c tv r)
    }

--------------------------------------------------------------------------------
-- | Different kinds of Check ""Obligations"" ------------------------------------
--------------------------------------------------------------------------------
data Oblig
  = OTerm -- ^ Obligation that proves termination
  | OInv  -- ^ Obligation that proves invariants
  | OCons -- ^ Obligation that proves subtyping constraints
Cf. liquidhaskell/src/Language/Haskell/Liquid/Types/Errors.hs
"
Class {
	#name : #'RRTy_OCons',
	#superclass : #RType,
	#instVars : [
		'env',
		'ty'
	],
	#category : #Metalanguage
}

{ #category : #'instance creation' }
RRTy_OCons class >> env: env ty: ty [
	^self basicNew
		env: env;
		ty: ty;
		yourself
]

{ #category : #accessing }
RRTy_OCons >> env [
	^ env
]

{ #category : #accessing }
RRTy_OCons >> env: anObject [
	env := anObject
]

{ #category : #printing }
RRTy_OCons >> printOn: aStream [
"
{x₁ :: t₁, x₂ :: t₂ |- tl <: tr} => ty
Cf. liquidhaskell/src/Language/Haskell/Liquid/Types/PrettyPrint.hs

Representation in env is:
+----------+----------+-----+-------------+-------------+
|  x₁->t₁  |  x₂->t₂  | ... |  namel->tl  |  namer->tr  |
+----------+----------+-----+-------------+-------------+
where namel and namer are always 'LIQUID$dummy'
"
	| tr tl envProper |
	tr := env last value.
	tl := env nextToLast value.
	envProper := env allButLast: 2.
	envProper do: [ :x_t |
			aStream nextPutAll: x_t key.
			aStream nextPutAll: ' :: '.
			x_t value printOn: aStream
		] separatedBy: [
			aStream nextPutAll: ', '
		].
	aStream nextPutAll: ' ⊢ '.
	tl printOn: aStream.
	aStream nextPutAll: ' ≺: '.
	tr printOn: aStream.
	aStream nextPutAll: ' =>'; crlf.
	ty printOn: aStream.
]

{ #category : #accessing }
RRTy_OCons >> ty [
	^ ty
]

{ #category : #accessing }
RRTy_OCons >> ty: anObject [
	ty := anObject
]
