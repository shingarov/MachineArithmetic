"
data EvalType =
    NoRW       -- Normal PLE
  | FuncNormal -- Expand to Function Defs, stop before branch expansion
  | RWNormal   -- Fully Expand Defs in context of rewriting
  deriving (Eq)
"
Class {
	#name : #EvalType,
	#superclass : #Object,
	#category : #PLE
}
