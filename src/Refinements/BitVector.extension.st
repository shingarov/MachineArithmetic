Extension { #name : #BitVector }

{ #category : #'*Refinements' }
BitVector >> isEBin [
	"Answer whether Fixpoint would consider this node a EBin."

	^{
		"Arithmetic" Z3_OP_BADD. Z3_OP_BSUB. Z3_OP_BMUL. Z3_OP_BSDIV. Z3_OP_BUDIV . Z3_OP_BSREM. Z3_OP_BUREM. Z3_OP_BSMOD.
		"Shifts"     Z3_OP_BSHL. Z3_OP_BLSHR. Z3_OP_BASHR.
	} includes: self funcDeclKind.
]
