"
--------------------------------------------------------------------------------
-- | @CoSub@ is a map from (coercion) ty-vars represented as 'FObj s'
--   to the ty-vars that they should be substituted with. Note the
--   domain and range are both Symbol and not the Int used for real ty-vars.
--------------------------------------------------------------------------------
type CoSub = M.HashMap Symbol Sort
"
Class {
	#name : #CoSub,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #API }
CoSub >> applyCoSub: x [ 
"
applyCoSub :: CoSub -> Expr -> Expr
Cf. Visitor.hs
"
	self isEmpty ifFalse: [ ^self shouldBeImplemented ].
"
See Issue #255 and the associated test L8PosTest>>test_poly
and its Horn counterpart HornPosPleTest>>testL8poly.
The problem is the Z3 expression (= |xººcheqºº0| |yººcheqºº1|)
where |xººcheqºº0| and |yººcheqºº1| are of sort 'a;
applyCoSub changes them to ℤ.  But during PLE it's too late
because FObj(a) already SMT-serialized to Z3 Uninterpreted;
so we need the ability to mapExpr over Z3 node trees.
The difficulty comes from interpreted declKinds.
Consider e.g. (= |xººcheqºº0| |yººcheqºº1|).  Let's suppose
we have transformed the children and now is the time to
recreate the #= node.  We cannot naïvely create a FuncDecl
of name #= because that will give us Z3_OP_UNINTERPRETED,
not Z3_OP_EQ.  The only way to get Z3_OP_EQ is to call
Z3_mk_eq().  So for each member of enum Z3_decl_kind, there
needs to be Smalltalk code that knows what Z3 API to call to
create that kind of app."
	^x "BOGUS"
	"^x mapExpr: [ :e | e applyCoSub_fE: self ]"
]
