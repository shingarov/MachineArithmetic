"
Constraint Dependencies

IVars:
cSucc   :: !(F.CMap [F.SubcId]) -- ^ Constraints *written by* a SubcId
cPrev   :: !(F.CMap [F.KVar])   -- ^ (Cut) KVars *read by*    a SubcId
cRank   :: !(F.CMap Rank)       -- ^ SCC rank of a SubcId
cNumScc :: !Int                 -- ^ Total number of Sccs

"
Class {
	#name : #CDeps,
	#superclass : #Object,
	#instVars : [
		'succ',
		'prev',
		'rank',
		'numScc'
	],
	#category : #'MachineArithmetic-Refinement'
}
