Class {
	#name : #'ΓContext',
	#superclass : #Dictionary,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΓContext class >> empEnv [
"
empEnv :: Env
empEnv = F.emptySEnv
"
	^super new
]

{ #category : #'instance creation' }
ΓContext class >> new [ 
	self shouldNotImplement
]

{ #category : #accessing }
ΓContext >> extEnv: bx rtype: t [
"
extEnv :: Env -> Bind a -> RType -> Env
extEnv env bx t = F.insertSEnv (bindId bx) t env
"
	^self copy
		at: bx id put: t;
		yourself
]

{ #category : #accessing }
ΓContext >> getEnv: sym [
"
getEnv :: Env -> F.Symbol -> Maybe RType
getEnv env x = F.lookupSEnv x env
"
	^self at: sym
]
