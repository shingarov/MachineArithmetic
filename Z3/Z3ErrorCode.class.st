Class {
	#name : #Z3ErrorCode,
	#superclass : #SharedPool,
	#classVars : [
		'DEC_REF_ERROR',
		'EXCEPTION',
		'FILE_ACCESS_ERROR',
		'INTERNAL_FATAL',
		'INVALID_ARG',
		'INVALID_PATTERN',
		'INVALID_USAGE',
		'IOB',
		'MEMOUT_FAIL',
		'NO_PARSER',
		'OK',
		'PARSER_ERROR',
		'SORT_ERROR'
	],
	#category : #'Z3-Core'
}

{ #category : #initialization }
Z3ErrorCode class >> initialize [
	"Invoked at system start or when the class is dynamically loaded."

	"  please change as required (and remove this comment)"

	OK := 0.
	SORT_ERROR := 1.
	IOB := 2.
	INVALID_ARG := 3.
	PARSER_ERROR := 4.
	NO_PARSER := 5.
	INVALID_PATTERN := 6.
	MEMOUT_FAIL := 7.
	FILE_ACCESS_ERROR := 8.
	INTERNAL_FATAL := 9.
	INVALID_USAGE := 10.
	DEC_REF_ERROR := 11.
	EXCEPTION := 12.

]
