Class {
	#name : #Z3ObjectType,
	#superclass : #FFIExternalObjectType,
	#category : #'Z3-FFI-Pharo'
}

{ #category : #'emitting code' }
Z3ObjectType >> emitReturn: aBuilder resultTempVar: resultVar context: aContext [
	^ aBuilder 
		storeTemp: resultVar;
		popTop;
		"return := self objectClass wrapAround: result"
		pushLiteralVariable: self objectClass binding;
		pushTemp: resultVar;
		send: #fromExternalAddress:;
		returnTop	
]
