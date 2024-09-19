Class {
	#name : #Z3CAPITODOTest,
	#superclass : #Object,
	#category : #'Z3-Tests'
}

{ #category : #tests }
Z3CAPITODOTest >> testErrorCode1 [
	"Demonstrates how error codes can be read instead of registering an error handler."
	self shouldBeImplemented
]

{ #category : #tests }
Z3CAPITODOTest >> testErrorCode2 [
	"Demonstrates how error handlers can be used."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testFPA [
	"Demonstrates some basic features of the FloatingPoint theory."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testForest [
	"Create a forest of trees.

   forest ::= nil | cons(tree, forest)
   tree   ::= nil | cons(forest, forest)"
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testIncremental [
	"Simple example using the functions:
	#mk_ext_context, #assert_retractable_cnstr, #retract_cnstr, #reassert_cnstr and #del_ext_context."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testMkModel [
	"Demonstrates some basic features of model construction"
	| ctx m |
	ctx := Z3Context fromDefault.
	m := Z3Model on: ctx.
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testParser2 [
	"Demonstrates how to initialize the parser symbol table."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testParser3 [
	"Demonstrates how to initialize the parser symbol table."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testParser5 [
	"Demonstrates how to handle parser errors using Z3 error handling support."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testProve2 [
	"Prove <tt>not(g(g(x) - g(y)) = g(z)), x + z <= y <= x implies z < 0 </tt>.
   Then, show that <tt>z < -1</tt> is not implied.

   This example demonstrates how to combine uninterpreted functions and arithmetic."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testReferenceCounter [
	"Simple example showing how to use reference counters in Z3
   to manage memory efficiently."
	self shouldBeImplemented 
]

{ #category : #tests }
Z3CAPITODOTest >> testTuple1 [
	"Simple tuple type example. It creates a tuple that is a pair of real numbers."
	self shouldBeImplemented 
]
