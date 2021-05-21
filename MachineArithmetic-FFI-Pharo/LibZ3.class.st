"
FFI interface to libz3.so
"
Class {
	#name : #LibZ3,
	#superclass : #FFILibrary,
	#classVars : [
		'UINT_PTR'
	],
	#category : #'MachineArithmetic-FFI-Pharo'
}

{ #category : #miscellaneous }
LibZ3 class >> getFullVersion [
	^self uniqueInstance getFullVersion
		
]

{ #category : #miscellaneous }
LibZ3 class >> getVersion [
	| maj min b r |
	maj := UINT_PTR new.
	min := UINT_PTR new.
	b   := UINT_PTR new.
	r   := UINT_PTR new.
	self uniqueInstance getVersion: maj minor: min build: b revision: r.
	^Array
		with: maj value
		with: min value
		with: b   value
		with: r   value
		
]

{ #category : #miscellaneous }
LibZ3 class >> getVersionString [
	| version |
	version := self getVersion. "Array of 4 Integers"
	^version first  printString, '.',
	 version second printString, '.',
	 version third  printString "omit rev, consistent with the Python API"

]

{ #category : #initialization }
LibZ3 class >> initFfiTypes [
	self initUintPtr
]

{ #category : #initialization }
LibZ3 class >> initUintPtr [
	UINT_PTR := FFIExternalValueHolder ofType: 'uint32'
]

{ #category : #initialization }
LibZ3 class >> initialize [
	self initFfiTypes
]

{ #category : #'accessing platform' }
LibZ3 >> unix64LibraryName [
	^ 'libz3.so'
]

{ #category : #'accessing platform' }
LibZ3 >> unix64ModuleName [
	^ 'libz3.so'
]
