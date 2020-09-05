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

{ #category : #'string conversion' }
LibZ3 >> astToString: ctx ast: ast [
	"Convert the given AST node into a string.

       \warning The result buffer is statically allocated by Z3. It will
       be automatically deallocated when #Z3_del_context is invoked.
       So, the buffer is invalidated in the next call to \c Z3_ast_to_string."
	^ self ffiCall: #(String Z3_ast_to_string (Z3Context ctx, AST ast) )

]

{ #category : #'as yet unclassified' }
LibZ3 >> astVectorToString: ctx astVector: fs [
	^ self ffiCall: #( String Z3_ast_vector_to_string (Z3Context ctx, ASTVector fs) )

]

{ #category : #'ref-counting' }
LibZ3 >> decRef: ctx astVector: fs [
	self ffiCall: #( void Z3_ast_vector_dec_ref (Z3Context ctx, ASTVector fs) )
]

{ #category : #'ref-counting' }
LibZ3 >> decRef: ctx model: model [
	self ffiCall: #( void Z3_model_dec_ref (Z3Context ctx, Z3Model model) )
]

{ #category : #'ref-counting' }
LibZ3 >> decRef: ctx solver: solver [
	self ffiCall: #( void Z3_solver_dec_ref (Z3Context ctx, Solver solver) )
]

{ #category : #context }
LibZ3 >> delContext: c [
	"Delete the given logical context."
	^ self ffiCall: #(void  Z3_del_context (Z3Context c) )
]

{ #category : #context }
LibZ3 >> delSolver: c solver: s [
	"Delete the given logical context."
	^ self ffiCall: #(void  Z3_solver_dec_ref (Z3Context c, Solver s) )
]

{ #category : #accessors }
LibZ3 >> funcDeclToAST: ctx funcDecl: aFuncDecl [
	"Convert a Z3_func_decl into Z3_ast.
	Z3 API documentation claims 'This is just type casting'
	but this doesn't work for me."
	^ self ffiCall: #( void* Z3_get_func_decl_id (Z3Context ctx, FuncDecl aFuncDecl) )
]

{ #category : #accessors }
LibZ3 >> getAppArg: ctx app: a index: zeroBasedIndex [
	"Return the i-th argument of the given application.
       def_API('Z3_get_app_arg', AST, (_in(CONTEXT), _in(APP), _in(UINT)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_app a, unsigned i);"
	^ self ffiCall: #( void*  Z3_get_app_arg (Z3Context ctx, ASTKindAPP a, uint zeroBasedIndex) )
]

{ #category : #accessors }
LibZ3 >> getAppDecl: ctx app: aZ3App [
	"Return the declaration of a function application."
	^ self ffiCall: #( FuncDecl  Z3_get_app_decl (Z3Context ctx, ASTKindAPP aZ3App) )
]

{ #category : #accessors }
LibZ3 >> getAppNumArgs: ctx app: a [
	"Return the number of argument of an application.
	If a is a constant, then the number of arguments is 0.
	    unsigned Z3_API Z3_get_app_num_args(Z3_context c, Z3_app a);"
	^ self ffiCall: #( uint  Z3_get_app_num_args (Z3Context ctx, ASTKindAPP a) )
]

{ #category : #accessors }
LibZ3 >> getArity: ctx funcDecl: aFuncDecl [
	"Alias for getDomainSize."
	^ self ffiCall: #( uint  Z3_get_arity (Z3Context ctx, FuncDecl aFuncDecl) )
]

{ #category : #'as yet unclassified' }
LibZ3 >> getAstHash: ctx ast: a [
	"Return a hash code for the given AST.
	The hash code is structural."
	^ self ffiCall: #( uint Z3_get_ast_hash (Z3Context ctx, AST a) )
]

{ #category : #'as yet unclassified' }
LibZ3 >> getAstKind: ctx ast: a [
	"Return the kind of the given AST.
	 In Smalltalk, see ASTKind class."
	^ self ffiCall: #( uint Z3_get_ast_kind (Z3Context ctx, AST a) )
]

{ #category : #sorts }
LibZ3 >> getBVSortSize: ctx sort: aZ3Sort [
	"Return the size of the given bit-vector sort.
	The sort kind Z3_get_sort_kind(c, t) must be Z3_BV_SORT."
	^self ffiCall: #( uint Z3_get_bv_sort_size (Z3Context ctx, Z3Sort aZ3Sort ) )

]

{ #category : #accessors }
LibZ3 >> getDeclName: ctx funcDecl: d [
	"Return the constant declaration name as a symbol."
	^ self ffiCall: #( Z3Symbol  Z3_get_decl_name (Z3Context ctx, FuncDecl d) )
]

{ #category : #miscellaneous }
LibZ3 >> getFullVersion [
	^ self ffiCall: #(String Z3_get_full_version( ) )

]

{ #category : #symbols }
LibZ3 >> getNumeralString: ctx ast: anAST [
	"Return numeral value, as a string of a numeric constant term.
	\pre Z3_get_ast_kind(c, a) == Z3_NUMERAL_AST"
	^ self ffiCall: #( String  Z3_get_numeral_string (Z3Context ctx, AST anAST) )

]

{ #category : #accessors }
LibZ3 >> getSort: ctx ast: ast [
	"Return the sort of an AST node.
	The AST node must be a constant, application, numeral, bound variable, or quantifier."
	^ self ffiCall: #( Z3Sort  Z3_get_sort (Z3Context ctx, AST ast) )
]

{ #category : #accessors }
LibZ3 >> getSort: ctx astHandle: ast [
	"Return the sort of an AST node.
	The AST node must be a constant, application, numeral, bound variable, or quantifier."
	^ self ffiCall: #( Z3Sort  Z3_get_sort (Z3Context ctx, void* ast) )
]

{ #category : #accessors }
LibZ3 >> getSortKind: ctx sort: t [
"Return the sort kind (e.g., array, tuple, int, bool, etc).

       \sa Z3_sort_kind

       def_API('', UINT, (_in(CONTEXT), _in(SORT)))
    */
    Z3_sort_kind Z3_API Z3_get_sort_kind(Z3_context c, Z3_sort t);"
	^ self ffiCall: #( uint  Z3_get_sort_kind (Z3Context ctx, Z3Sort t) )
]

{ #category : #accessors }
LibZ3 >> getSortName: ctx sort: aZ3Sort [
	"Return the sort of an AST node.
	The AST node must be a constant, application, numeral, bound variable, or quantifier."
	^ self ffiCall: #( Z3Symbol  Z3_get_sort_name (Z3Context ctx, Z3Sort aZ3Sort) )
]

{ #category : #symbols }
LibZ3 >> getSymbolInt: ctx symbol: s [
	"Return the symbol int value."
	^ self ffiCall: #( int  Z3_get_symbol_int (Z3Context ctx, Z3Symbol s) )

]

{ #category : #accessors }
LibZ3 >> getSymbolKind: ctx symbol: s [
	"Return Z3_INT_SYMBOL=0 if the symbol was constructed
	using Z3_mk_int_symbol, and Z3_STRING_SYMBOL=1 if the symbol
	was constructed using #Z3_mk_string_symbol."
	^ self ffiCall: #( uint  Z3_get_symbol_kind (Z3Context ctx, Z3Symbol s) )
]

{ #category : #symbols }
LibZ3 >> getSymbolString: ctx symbol: s [
	"Return the symbol name.

       \pre Z3_get_symbol_kind(s) == Z3_STRING_SYMBOL

       \warning The returned buffer is statically allocated by Z3. It will
       be automatically deallocated when #Z3_del_context is invoked.
       So, the buffer is invalidated in the next call to \c Z3_get_symbol_string."
	^ self ffiCall: #( String  Z3_get_symbol_string (Z3Context ctx, Z3Symbol s) )

]

{ #category : #miscellaneous }
LibZ3 >> getVersion: maj minor: min build: b revision: r [
	^ self ffiCall: #(void Z3_get_version(UINT_PTR maj, UINT_PTR min, UINT_PTR b, UINT_PTR r) )

]

{ #category : #'global parameters' }
LibZ3 >> globalParam: paramId set: paramValue [
	"Set a global (or module) parameter.
	This setting is shared by all Z3 contexts.
	
	When a Z3 module is initialized it will use the value of these parameters
	when Z3_params objects are not provided.
	
	The name of parameter can be composed of characters [a-z][A-Z], digits [0-9], '-' and '_'.
	The character '.' is a delimiter (more later).
	
	The parameter names are case-insensitive. The character '-' should be viewed as an 'alias' for '_'.
	Thus, the following parameter names are considered equivalent: 'pp.decimal-precision' and 'PP.DECIMAL_PRECISION'.
	
	This function can be used to set parameters for a specific Z3 module.
	This can be done by using <module-name>.<parameter-name>.
	For example:
	Z3_global_param_set('pp.decimal', 'true')
	will set the parameter 'decimal' in the module 'pp' to true."
   ^ self ffiCall: #( void Z3_global_param_set (String paramId, String paramValue) )

]

{ #category : #'ref-counting' }
LibZ3 >> incRef: ctx astVector: fs [
	self ffiCall: #( void Z3_ast_vector_inc_ref (Z3Context ctx, ASTVector fs) )
]

{ #category : #'ref-counting' }
LibZ3 >> incRef: ctx model: model [
	self ffiCall: #( void Z3_model_inc_ref (Z3Context ctx, Z3Model model) )
]

{ #category : #'ref-counting' }
LibZ3 >> incRef: ctx solver: solver [
	self ffiCall: #( void Z3_solver_inc_ref (Z3Context ctx, Solver solver) )
]

{ #category : #symbols }
LibZ3 >> isAsArray: ctx ast: a [
	^ self ffiCall: #( bool  Z3_is_as_array (Z3Context ctx, AST a) )
]

{ #category : #symbols }
LibZ3 >> isNumeral: ctx ast: anAST [
	^ self ffiCall: #( bool  Z3_is_numeral_ast (Z3Context ctx, AST anAST) )

]

{ #category : #'integers and reals' }
LibZ3 >> mkAdd: ctx numArgs: n args: args [
	"Create an AST node representing arg1 + ... + argN.
	The array args must have num_args elements.
	All arguments must have int or real sort.
	NB: The number of arguments must be greater than zero."
	^ self ffiCall: #( Int Z3_mk_add (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkAnd: ctx numArgs: n args: args [
	"Create an AST node representing arg1 and ... and argN.
	 The array args must have num_args elements.
	 All arguments must have Boolean sort.
	 The number of arguments must be greater than zero."
	^ self ffiCall: #( Bool Z3_mk_and (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #'constants and applications' }
LibZ3 >> mkApp: ctx func: decl arity: numArgs args: ffiArray [
	"Call Z3_mk_app with 0 args."
	^ self ffiCall: #( void*  Z3_mk_app (Z3Context ctx, FuncDecl decl, uint numArgs, FFIExternalArray ffiArray) )
]

{ #category : #sorts }
LibZ3 >> mkArraySort: ctx domain: domain range: range [
	"Create an array type.
	We usually represent the array type as: [domain -> range].
	Arrays are usually used to model the heap/memory in software verification."
	^self ffiCall: #( Z3Sort  Z3_mk_array_sort (Z3Context ctx, Z3Sort domain, Z3Sort range) )

]

{ #category : #'bit vectors' }
LibZ3 >> mkBV2Int: ctx t1: t1 isSigned: aBool [
	"CCreate an integer from the bit-vector argument \c t1.
       If \c is_signed is false, then the bit-vector \c t1 is treated as unsigned.
       So the result is non-negative
       and in the range \ccode{[0..2^N-1]}, where N are the number of bits in \c t1.
       If \c is_signed is true, \c t1 is treated as a signed bit-vector.


       The node \c t1 must have a bit-vector sort.

       def_API('Z3_mk_bv2int', AST, (_in(CONTEXT), _in(AST), _in(BOOL)))
    */
    Z3_ast Z3_API (Z3_context c,Z3_ast t1, bool is_signed);"
	^ self ffiCall: #( void * Z3_mk_bv2int (void * ctx, void * t1, bool aBool) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVadd: ctx t1: t1 t2: t2 [
	"Standard two's complement addition.
	The nodes \c t1 and \c t2 must have the same bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvadd (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVand: ctx t1: t1 t2: t2 [
	"Bitwise and.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvand (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVashr: ctx  t1: t1 t2: t2 [
	"Arithmetic shift right.

       It is like logical shift right except that the most significant
       bits of the result always copy the most significant bit of the
       second argument.

       The semantics of shift operations varies between environments. This
       definition does not necessarily capture directly the semantics of the
       programming language or assembly architecture you are modeling.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))

"
	^ self ffiCall: #( void * Z3_mk_bvashr (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVmul: ctx t1: t1 t2: t2 [
	"Standard two's complement multiplication.

        The nodes \c t1 and \c t2 must have the same bit-vector sort.

        def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvmul(Z3_context c, Z3_ast t1, Z3_ast t2);"
	^ self ffiCall: #( BitVector Z3_mk_bvmul (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVnand: ctx t1: t1 t2: t2 [
	"Bitwise nand.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_bvnand (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVneg: ctx t1: t1 [
	"Standard two's complement unary minus.

       The node \c t1 must have bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_bvneg (void * ctx, void * t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVnor: ctx t1: t1 t2: t2 [
	"Bitwise nor.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_bvnor (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVnot: ctx t1: t1 [
	"Bitwise negation.

       The node \c t1 must have a bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvnot (Z3Context ctx, BitVector t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVor: ctx t1: t1 t2: t2 [
	"Bitwise or.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvxor (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVredand: ctx t1: t1 [
	"Take conjunction of bits in vector, return vector of length 1.

       The node \c t1 must have a bit-vector sort.

       def_API('Z3_mk_bvredand', AST, (_in(CONTEXT), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1);
"
	^ self ffiCall: #( void * Z3_mk_bvredand (void * ctx, void * t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVredor: ctx t1: t1 [
	"Take disjunction of bits in vector, return vector of length 1.

       The node \c t1 must have a bit-vector sort.
"
	^ self ffiCall: #( void * Z3_mk_bvredor (void * ctx, void * t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsdiv: ctx t1: t1 t2: t2 [
	"Two's complement signed division.

        It is defined in the following way:

        - The \c floor of \ccode{t1/t2} if \c t2 is different from zero, and \ccode{t1*t2 >= 0}.

        - The \c ceiling of \ccode{t1/t2} if \c t2 is different from zero, and \ccode{t1*t2 < 0}.

        If \ccode{t2} is zero, then the result is undefined.

        The nodes \c t1 and \c t2 must have the same bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvsdiv (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsge: ctx t1: t1 t2: t2 [
	"Two's complement signed greater than or equal to.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_bvsge', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);

"
	^ self ffiCall: #( void * Z3_mk_bvsge (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsgt: ctx t1: t1 t2: t2 [
	"Two's complement signed greater than.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvsgt(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_bvsgt (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVshl: ctx  t1: t1 t2: t2 [
	"Shift left.

       It is equivalent to multiplication by \ccode{2^x} where \c x is the value of the
       third argument.

       NB. The semantics of shift operations varies between environments. This
       definition does not necessarily capture directly the semantics of the
       programming language or assembly architecture you are modeling.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_bvshl', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);

"
	^ self ffiCall: #( BitVector Z3_mk_bvshl (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsle: ctx t1: t1 t2: t2 [
	"Two's complement signed less than or equal to.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_bvsle', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);"
	^ self ffiCall: #( Bool  Z3_mk_bvsle (Z3Context ctx, Int t1, Int t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVslt: ctx t1: t1 t2: t2 [
	"Two's complement signed less than.

       It abbreviates:
       \code
        (or (and (= (extract[|m-1|:|m-1|] t1) bit1)
                (= (extract[|m-1|:|m-1|] t2) bit0))
            (and (= (extract[|m-1|:|m-1|] t1) (extract[|m-1|:|m-1|] t2))
                (bvult t1 t2)))
       \endcode

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvslt(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( Bool  Z3_mk_bvslt (Z3Context ctx, #BitVector t1, #BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsmod: ctx t1: t1 t2: t2 [
	"Two's complement signed remainder (sign follows divisor).

       If \ccode{t2} is zero, then the result is undefined.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       \sa Z3_mk_bvsrem

       def_API('Z3_mk_bvsmod', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_bvsmod (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsrem: ctx t1: t1 t2: t2 [
	"Two's complement signed remainder (sign follows dividend).

       It is defined as \ccode{t1 - (t1 /s t2) * t2}, where \ccode{/s} represents signed division.
       The most significant bit (sign) of the result is equal to the most significant bit of \c t1.

       If \ccode{t2} is zero, then the result is undefined.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.
"
	^ self ffiCall: #( void * Z3_mk_bvsrem (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVsub: ctx t1: t1 t2: t2 [
	"Standard two's complement subtraction.

        The nodes \c t1 and \c t2 must have the same bit-vector sort.

        def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvsub(Z3_context c, Z3_ast t1, Z3_ast t2);"
	^ self ffiCall: #(#BitVector  Z3_mk_bvsub (Z3Context ctx, #BitVector t1, #BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVudiv: ctx t1: t1 t2: t2 [
	"Unsigned division.
	
	It is defined as the floor of t1/t2 if t2 is
	different from zero. If t2 is zero, then the result is undefined.
	The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_bvudiv (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVuge: ctx t1: t1 t2: t2 [
	"Unsigned greater than or equal to.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvuge(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_bvuge (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVugt: ctx t1: t1 t2: t2 [
	"Unsigned greater than.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_bvugt', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);

"
	^ self ffiCall: #( void * Z3_mk_bvugt (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVule: ctx t1: t1 t2: t2 [
	"Unsigned less than or equal to.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvule(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_bvule (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVult: ctx t1: t1 t2: t2 [
	"Unsigned less than.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_bvult', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_bvult (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVurem: ctx t1: t1 t2: t2 [
	"Unsigned remainder.

       It is defined as \ccode{t1 - (t1 /u t2) * t2}, where \ccode{/u} represents unsigned division.

       If \ccode{t2} is zero, then the result is undefined.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_bvurem(Z3_context c, Z3_ast t1, Z3_ast t2);"
	^ self ffiCall: #( void * Z3_mk_bvurem (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVxnor: ctx t1: t1 t2: t2 [
	"Bitwise xnor.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_bxvnor (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkBVxor: ctx t1: t1 t2: t2 [
	"Bitwise xor.
	 The nodes t1 and t2 must have the same bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_bvxor (void * ctx, void * t1, void * t2) )
]

{ #category : #sorts }
LibZ3 >> mkBoolSort: ctx [
	"Create the Boolean type.
	 This type is used to create propositional variables and predicates."
	^ self ffiCall: #( Z3Sort  Z3_mk_bool_sort (Z3Context ctx) )

]

{ #category : #quantifiers }
LibZ3 >> mkBound: ctx index: anUnsigned sort: ty [
	"Create a bound variable.
	
	Bound variables are indexed by de-Bruijn indices.
	It is perhaps easiest to explain the meaning of de-Bruijn indices
	by indicating the compilation process from non-de-Bruijn formulas to de-Bruijn format.

       abs(forall (x1) phi) = forall (x1) abs1(phi, x1, 0)
       abs(forall (x1, x2) phi) = abs(forall (x1) abs(forall (x2) phi))
       abs1(x, x, n) = b_n
       abs1(y, x, n) = y
       abs1(f(t1,...,tn), x, n) = f(abs1(t1,x,n), ..., abs1(tn,x,n))
       abs1(forall (x1) phi, x, n) = forall (x1) (abs1(phi, x, n+1))

	The last line is significant: the index of a bound variable is different depending
	on the scope in which it appears. The deeper x appears, the higher is its index."
	^self ffiCall: #( void*  Z3_mk_bound (Z3Context ctx, uint anUnsigned, Z3Sort ty) )

]

{ #category : #sorts }
LibZ3 >> mkBvSort: ctx size: sz [
	"Create a bit-vector type of the given size.
	 This type can also be seen as a machine integer.
	 NB: The size of the bit-vector type must be greater than zero."
	^ self ffiCall: #( Z3Sort Z3_mk_bv_sort (Z3Context ctx, uint sz) )

]

{ #category : #'bit vectors' }
LibZ3 >> mkConcat: ctx t1: t1 t2: t2 [
	"Concatenate the given bit-vectors."
	^ self ffiCall: #( BitVector Z3_mk_concat (Z3Context ctx, BitVector t1, BitVector t2) )
]

{ #category : #configuration }
LibZ3 >> mkConfig [
	^ self ffiCall: #(Z3Config Z3_mk_config () )

]

{ #category : #'constants and applications' }
LibZ3 >> mkConst: ctx symbol: s sort: ty [
	"Declare and create a constant.
	 Answers a Z3_ast pointer.
	 Z3 says this function is a shorthand for:
       Z3_func_decl d = Z3_mk_func_decl(c, s, 0, 0, ty);
       Z3_ast n            = Z3_mk_app(c, d, 0, 0);"
	^ self ffiCall: #( void*  Z3_mk_const (Z3Context ctx, Z3Symbol s, Z3Sort ty) )
]

{ #category : #sorts }
LibZ3 >> mkConstructor: ctx name: name recognizer: recognizer uint: numFields fieldNames: fieldNames sorts: sorts sortRefs: refs [
	"Create a constructor.
	Args:
	- ctx: logical context.
	- name constructor name.
	- recognizer name of recognizer function.
	- num_fields number of fields in constructor.
	- field_names names of the constructor fields.
	- sorts field sorts, 0 if the field sort refers to a recursive sort.
	- sort_refs reference to datatype sort that is an argument to the constructor;
	  if the corresponding sort reference is 0, then the value in sort_refs should
	  be an index referring to one of the recursive datatypes that is declared."
	self shouldBeImplemented .
	^ self ffiCall: #( Z3Sort Z3_mk_int_sort (Z3Context ctx) )

]

{ #category : #context }
LibZ3 >> mkContext: cfg [
	^ self ffiCall: #(Z3Context  Z3_mk_context (Z3Config cfg) )

]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkDistinct: ctx numArgs: n args: args [
	"Create an AST node representing distinct(arg1, ... argN).
	 The distinct construct is used for declaring the arguments pairwise distinct.
	 That is, Forall 0 <= i < j < num_args. not args[i] = args[j].
	 All arguments must have the same sort.
	 Remark: The number of arguments of a distinct construct must be greater than one."
	^ self ffiCall: #( void * Z3_mk_distinct (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkDiv: ctx dividend: l divisor: r [
	"Create an AST node representing \ccode{arg1 div arg2}.

       The arguments must either both have int type or both have real type.
       If the arguments have int type, then the result type is an int type, otherwise the
       the result type is real.

       def_API('Z3_mk_div', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_div(Z3_context c, Z3_ast arg1, Z3_ast arg2);"
	^ self ffiCall: #( Int Z3_mk_div (Z3Context ctx, AST l, AST r) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkEq: ctx l: l r: r [
	"Create an AST node representing l = r.
	 The nodes l and r must have the same type."
	^ self ffiCall: #( Bool Z3_mk_eq (Z3Context ctx, AST l, AST r) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkExtRotateLeft: ctx  t1: t1 t2: t2 [
	"Rotate bits of \c t1 to the left \c t2 times.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_ext_rotate_left(Z3_context c, Z3_ast t1, Z3_ast t2);

"
	^ self ffiCall: #( void * Z3_mk_ext_rotate_left (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkExtRotateRight: ctx  t1: t1 t2: t2 [
	"Rotate bits of \c t1 to the right \c t2 times.

       The nodes \c t1 and \c t2 must have the same bit-vector sort.

       def_API('Z3_mk_ext_rotate_right', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( void * Z3_mk_ext_rotate_right (void * ctx, void * t1, void * t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkExtract: ctx high: h low: l t1: t1 [
	"Extract the bits \c high down to \c low from a bit-vector of
	size \c m to yield a new bit-vector of size \c n, where \ccode{n = high - low + 1}.
	The node \c t1 must have a bit-vector sort."
	^ self ffiCall: #( BitVector Z3_mk_extract (Z3Context ctx, uint h, uint l, BitVector t1) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkFalse: ctx [
	"Create an AST node representing false."
	^ self ffiCall: #( void* Z3_mk_false (Z3Context ctx) )

]

{ #category : #'constants and applications' }
LibZ3 >> mkFuncDecl: ctx symbol: s domainSize: nDim domain: anFFIExternalArray range: rangeSort [
	"Declare a constant or function.
	Arguments:
		ctx logical context.
		s name of the constant or function.
		domainSize number of arguments. It is 0 when declaring a constant.
		domain array containing the sort of each argument.
		       The array must contain domain_size elements. It is 0 when declaring a constant.
		rangeSort sort of the constant or the return sort of the function.
	After declaring a constant or function, the function Z3_mk_app can be used
	to create a constant or function application.
	See also: Z3_mk_app"
	^ self ffiCall: #( FuncDecl  Z3_mk_func_decl (Z3Context ctx, Z3Symbol s, 
		uint nDim, FFIExternalArray anFFIExternalArray,
		Z3Sort rangeSort) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkGe: ctx t1: t1 t2: t2 [
	"Create greater than or equal to.
	The nodes t1 and t2 must have the same sort, and must be int or real."
	^ self ffiCall: #( AST Z3_mk_ge (Z3Context ctx, AST t1, AST t2) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkGt: ctx t1: t1 t2: t2 [
	"Create greater than.
	The nodes t1 and t2 must have the same sort, and must be int or real."
	^ self ffiCall: #( AST Z3_mk_gt (Z3Context ctx, AST t1, AST t2) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkITE: ctx t1: t1 t2: t2 t3: t3 [
	"Create an AST node representing an if-then-else: ite(t1, t2, t3).
	The node t1 must have Boolean sort;
	t2 and t3 must have the same sort.
	The sort of the new node is equal to the sort of t2 and t3."
	^self ffiCall: #( void* Z3_mk_ite (Z3Context ctx, AST t1, AST t2, AST t3) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkIff: ctx t1: t1 t2: t2 [
	"Create an AST node representing \ccode{t1 iff t2}.

       The nodes \c t1 and \c t2 must have Boolean sort.

       def_API('Z3_mk_iff', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_iff(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( Bool  Z3_mk_iff (Z3Context ctx, Bool t1, Bool t2) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkImplies: ctx t1: t1 t2: t2 [
	"Create an AST node representing
		t1 => t2.
	The nodes t1 and t2 must have Boolean sort."
	^ self ffiCall: #( Bool Z3_mk_implies (Z3Context ctx, Bool t1, Bool t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkInt2BV: ctx length: n t1: t1 [
	"Create an \c n bit bit-vector from the integer argument \c t1.

       The resulting bit-vector has \c n bits, where the i'th bit (counting
       from 0 to \c n-1) is 1 if \c (t1 div 2^i) mod 2 is 1.       

       The node \c t1 must have integer sort.

       def_API('', AST, (_in(CONTEXT), _in(UINT), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_int2bv(Z3_context c, unsigned n, Z3_ast t1);"
	^ self ffiCall: #( void * Z3_mk_int2bv (void * ctx, uint n, void * t1) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkInt2real: ctx t1: t1 [
	"Coerce an integer to a real.

        There is also a converse operation exposed.
        It follows the semantics prescribed by the SMT-LIB standard.

        You can take the floor of a real by
        creating an auxiliary integer constant \c k and
        and asserting \ccode{mk_int2real(k) <= t1 < mk_int2real(k)+1}.

        The node \c t1 must have sort integer.

        \sa Z3_mk_real2int
        \sa Z3_mk_is_int

        def_API('', AST, (_in(CONTEXT), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_int2real(Z3_context c, Z3_ast t1);"
	^ self ffiCall: #( void * Z3_mk_int2real (void * ctx, void * t1) )
]

{ #category : #sorts }
LibZ3 >> mkInt: ctx int: v sort: ty [
	"Create a numeral of an int, bit-vector, or finite-domain sort.
	This function can be used to create numerals that fit in a machine integer.
	It is slightly faster than Z3_mk_numeral since it is not necessary to parse a string.

       def_API('Z3_mk_int', AST, (_in(CONTEXT), _in(INT), _in(SORT)))
    */
    Z3_ast Z3_API Z3_mk_int(Z3_context c, int v, Z3_sort ty)"
	^ self ffiCall: #( Int Z3_mk_int (Z3Context ctx, int v, Z3Sort ty ) )

]

{ #category : #sorts }
LibZ3 >> mkIntSort: ctx [
	"Create the integer type.
	This type is not the int type found in programming languages.
	A machine integer can be represented using bit-vectors. The function
	Z3_mk_bv_sort creates a bit-vector type."
	^ self ffiCall: #( Z3Sort Z3_mk_int_sort (Z3Context ctx) )

]

{ #category : #symbols }
LibZ3 >> mkIntSymbol: ctx int: i [
	"Create a Z3 symbol using an int.
	 Symbols are used to name several term and type constructors.
	 NB. In Z3 itself, not all integers can be passed to this function.
	 The legal range of unsigned integers is 0 to 2^30-1."
	^ self ffiCall: #(Z3Symbol  Z3_mk_int_symbol (Z3Context ctx, int i) )

]

{ #category : #'integers and reals' }
LibZ3 >> mkLe: ctx t1: t1 t2: t2 [
	"Create less than or equal to.
	The nodes t1 and t2 must have the same sort, and must be int or real."
	^ self ffiCall: #( AST Z3_mk_le (Z3Context ctx, AST t1, AST t2) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkLt: ctx t1: t1 t2: t2 [
	"Create less than.
	The nodes t1 and t2 must have the same sort, and must be int or real."
	^ self ffiCall: #( AST Z3_mk_lt (Z3Context ctx, AST t1, AST t2) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkMod: ctx arg1: arg1 arg2: arg2 [
	"Create an AST node representing \ccode{arg1 mod arg2}.

       The arguments must have int type.

       def_API('Z3_mk_mod', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, Z3_ast arg1, Z3_ast arg2);
"
	^ self ffiCall: #( void * Z3_mk_mod (void * ctx, void * arg1, void * arg2) )
]

{ #category : #models }
LibZ3 >> mkModel: ctx [
	"Create a fresh model object. It has reference count 0."
	^ self ffiCall: #( Z3Model  Z3_mk_model(Z3Context ctx) ).

]

{ #category : #'integers and reals' }
LibZ3 >> mkMul: ctx numArgs: n args: args [
	"Create an AST node representing \ccode{args[0] * ... * args[num_args-1]}.

       The array \c args must have \c num_args elements.
       All arguments must have int or real sort.

       \remark Z3 has limited support for non-linear arithmetic.
       \remark The number of arguments must be greater than zero.

       def_API('Z3_mk_mul', AST, (_in(CONTEXT), _in(UINT), _in_array(1, AST)))
    */
    Z3_ast Z3_API Z3_mk_mul(Z3_context c, unsigned num_args, Z3_ast const args[]);"
	^ self ffiCall: #( Int Z3_mk_mul (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkNot: ctx ast: a [
	"Create an AST node representing \ccode{t1 iff t2}.

       The nodes \c t1 and \c t2 must have Boolean sort.

       def_API('Z3_mk_iff', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_iff(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( Bool Z3_mk_not (Z3Context ctx, Bool a) )
]

{ #category : #numerals }
LibZ3 >> mkNumeral: ctx numeral: aString type: aSort [
	"Create a numeral of a given sort.
	Arguments:
	 * aString - represents the numeral value in decimal notation.
	             The string may be of the form `[num]*[.[num]*][E[+|-][num]+]`.
	             If the given sort is a real, then the numeral can be a rational,
	             that is, a string of the form `[num]* / [num]*` .
	 * ty - the sort of the numeral.
	        In the current implementation, the given sort can be an int, real,
	        finite-domain, or bit-vectors of arbitrary size."
	^ self ffiCall: #( void*  Z3_mk_numeral (Z3Context ctx, String aString, Z3Sort aSort) )	
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkOr: ctx numArgs: n args: args [

	^ self ffiCall: #( Bool Z3_mk_or (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #parameters }
LibZ3 >> mkParams: ctx [
	"Create an empty parameter set.
	Starting at Z3 4.0, parameter sets are used to configure many components such as:
	simplifiers, tactics, solvers, etc.
	
	Reference counting must be used to manage parameter sets,
	even when the Z3_context was created using #Z3_mk_context instead of #Z3_mk_context_rc."
	
	^ self ffiCall: #(Z3ParameterSet  Z3_mk_params (Z3Context ctx) )

]

{ #category : #quantifiers }
LibZ3 >> mkPattern: ctx numPatterns: anUnsigned terms: anAstArray [
self shouldBeImplemented 
]

{ #category : #'integers and reals' }
LibZ3 >> mkPower: ctx arg1: arg1 arg2: arg2 [
	"Create an AST node representing \ccode{arg1 ^ arg2}.

       The arguments must have int or real type.

       def_API('Z3_mk_power', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_power(Z3_context c, Z3_ast arg1, Z3_ast arg2);"
	^ self ffiCall: #( void * Z3_mk_power (void * ctx, void * arg1, void * arg2) )
]

{ #category : #'integers and reals' }
LibZ3 >> mkReal2Int: ctx t1: t1 [
	"Coerce a real to an integer.

        The semantics of this function follows the SMT-LIB standard
        for the function to_int"
	^ self ffiCall: #( void * Z3_mk_real2int (void * ctx, void * t1) )
]

{ #category : #sorts }
LibZ3 >> mkRealSort: ctx [
	"Create the real type.
	Note that this type is not a floating point number."
	^ self ffiCall: #( Z3Sort Z3_mk_real_sort (Z3Context ctx) )

]

{ #category : #'integers and reals' }
LibZ3 >> mkRem: ctx arg1: arg1 arg2: arg2 [

	^ self ffiCall: #( void * Z3_mk_rem (void * ctx, void * arg1, void * arg2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkRepeat: ctx i: i t1: t1 [
	"Repeat the given bit-vector up length i.
	The node t1 must have a bit-vector sort."
	^self ffiCall: #( BitVector Z3_mk_repeat (Z3Context ctx, uint i, BitVector t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkRotateLeft: ctx i: i t1: t1 [
	"Rotate bits of t1 to the left i times.
	The node t1 must have a bit-vector sort."
	^self ffiCall: #(AST Z3_mk_rotate_left (Z3Context ctx, uint i, AST t1) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkRotateRight: ctx i: i t1: t1 [
	"Rotate bits of t1 to the right i times.
	The node t1 must have a bit-vector sort."
	^self ffiCall: #(AST Z3_mk_rotate_right (Z3Context ctx, uint i, AST t1) )
]

{ #category : #arrays }
LibZ3 >> mkSelect: ctx a: a i: i [
	"Array read.
       The argument \c a is the array and \c i is the index of the array that gets read.

       The node \c a must have an array sort \ccode{[domain -> range]},
       and \c i must have the sort \c domain.
       The sort of the result is \c range.

       \sa Z3_mk_array_sort
       \sa Z3_mk_store

       def_API('', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_select(Z3_context c, Z3_ast a, Z3_ast i);"
	^ self ffiCall: #( void* Z3_mk_select (Z3Context ctx, AST a, AST i) )
]

{ #category : #sets }
LibZ3 >> mkSet: ctx sort: ty [
	"Create Set type."
	^ self ffiCall: #(void * Z3_mk_set_sort (void * ctx, void * ty) )

]

{ #category : #'bit vectors' }
LibZ3 >> mkSignExtend: ctx i: i t1: t1 [
	"Sign-extend the given bit-vector to the (signed) equivalent bit-vector of
	 size {m+i} where m is the size of the given bit-vector.
	 The node t1 must have a bit-vector sort."
	^ self ffiCall: #( void * Z3_mk_sign_ext (void * ctx, uint i, void * t1) )
]

{ #category : #solvers }
LibZ3 >> mkSolver: ctx [
	"Create a new solver. This solver is a 'combined solver' (see
       combined_solver module) that internally uses a non-incremental (solver1) and an
       incremental solver (solver2). This combined solver changes its behaviour based
       on how it is used and how its parameters are set.

       If the solver is used in a non incremental way (i.e. no calls to
       #Z3_solver_push() or #Z3_solver_pop(), and no calls to
       #Z3_solver_assert() or #Z3_solver_assert_and_track() after checking
       satisfiability without an intervening #Z3_solver_reset()) then solver1
       will be used. This solver will apply Z3's 'default' tactic.

       The 'default' tactic will attempt to probe the logic used by the
       assertions and will apply a specialized tactic if one is supported.
       Otherwise the general `(and-then simplify smt)` tactic will be used.

       If the solver is used in an incremental way then the combined solver
       will switch to using solver2 (which behaves similarly to the general
       'smt' tactic).

       Note however it is possible to set the `solver2_timeout`,
       `solver2_unknown`, and `ignore_solver1` parameters of the combined
       solver to change its behaviour.

       The function #Z3_solver_get_model retrieves a model if the
       assertions is satisfiable (i.e., the result is \c
       Z3_L_TRUE) and model construction is enabled.
       The function #Z3_solver_get_model can also be used even
       if the result is \c Z3_L_UNDEF, but the returned model
       is not guaranteed to satisfy quantified assertions.

       \remark User must use #Z3_solver_inc_ref and #Z3_solver_dec_ref to manage solver objects.
       Even if the context was created using #Z3_mk_context instead of #Z3_mk_context_rc.

"
	^ self ffiCall: #(Solver Z3_mk_solver (Z3Context ctx) )

]

{ #category : #arrays }
LibZ3 >> mkStore: ctx a: a i: i v: v [
	"Array update.

       The node \c a must have an array sort \ccode{[domain -> range]}, \c i must have sort \c domain,
       \c v must have sort range. The sort of the result is \ccode{[domain -> range]}.
       The semantics of this function is given by the theory of arrays described in the SMT-LIB
       standard. See http://smtlib.org for more details.
       The result of this function is an array that is equal to \c a (with respect to \c select)
       on all indices except for \c i, where it maps to \c v (and the \c select of \c a with
       respect to \c i may be a different value)."
	^ self ffiCall: #( void* Z3_mk_store (Z3Context ctx, AST a, AST i, AST v) )
]

{ #category : #symbols }
LibZ3 >> mkStringSymbol: ctx string: s [
	"Create a Z3 symbol using a Smalltalk String.
	Symbols are used to name several term and type constructors."
	^ self ffiCall: #(Z3Symbol  Z3_mk_string_symbol (Z3Context ctx, String s) )

]

{ #category : #'integers and reals' }
LibZ3 >> mkSub: ctx numArgs: n args: args [
	"Create an AST node representing \ccode{args[0] - ... - args[num_args - 1]}.

       The array \c args must have \c num_args elements.
       All arguments must have int or real sort.

       \remark The number of arguments must be greater than zero.

       def_API('Z3_mk_sub', AST, (_in(CONTEXT), _in(UINT), _in_array(1, AST)))
    */
    Z3_ast Z3_API Z3_mk_sub(Z3_context c, unsigned num_args, Z3_ast const args[]);"
	^ self ffiCall: #( Int Z3_mk_sub (Z3Context ctx, int n, FFIExternalArray args) )
]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkTrue: ctx [
	"Create an AST node representing true."
	^ self ffiCall: #( void * Z3_mk_true (Z3Context ctx) )

]

{ #category : #'integers and reals' }
LibZ3 >> mkUnaryMinus: ctx arg: a [
	"Create an AST node representing \ccode{- arg}.

       The arguments must have int or real type.

       def_API('Z3_mk_unary_minus', AST, (_in(CONTEXT), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_unary_minus(Z3_context c, Z3_ast arg);
"
	^ self ffiCall: #( void * Z3_mk_unary_minus (void * ctx, void * a) )
]

{ #category : #sorts }
LibZ3 >> mkUninterpretedSort: ctx symbol: s [
	"Create a free (uninterpreted) type using the given name (symbol).
	Two free types are considered the same iff the have the same name."
	^ self ffiCall: #( Z3Sort Z3_mk_uninterpreted_sort (Z3Context ctx, Z3Symbol s ) )

]

{ #category : #'propositional logic and equality' }
LibZ3 >> mkXor: ctx t1: t1 t2: t2 [
	"Create an AST node representing \ccode{t1 xor t2}.

       The nodes \c t1 and \c t2 must have Boolean sort.

       def_API('Z3_mk_xor', AST, (_in(CONTEXT), _in(AST), _in(AST)))
    */
    Z3_ast Z3_API Z3_mk_xor(Z3_context c, Z3_ast t1, Z3_ast t2);
"
	^ self ffiCall: #( Bool Z3_mk_xor (Z3Context ctx, Bool t1, Bool t2) )
]

{ #category : #'bit vectors' }
LibZ3 >> mkZeroExtend: ctx i: i t1: t1 [
	"Extend the given bit-vector with zeros to the (unsigned) equivalent
       bit-vector of size \ccode{m+i}, where \c m is the size of the
       given bit-vector.

       The node \c t1 must have a bit-vector sort.

       def_API('Z3_mk_zero_ext', AST, (_in(CONTEXT), _in(UINT), _in(AST)))
    */
    Z3_ast Z3_API (Z3_context c, unsigned i, Z3_ast t1);
"
	^ self ffiCall: #( void * Z3_mk_zero_ext (void * ctx, uint i, void * t1) )
]

{ #category : #models }
LibZ3 >> modelEval: ctx model: m ast: t completion: aBool dest: v [
	"Evaluate the AST node t in the given model.
	Return \c true if succeeded, and store the result in v.

       If \c model_completion is \c true, then Z3 will assign an interpretation for any constant or function that does
       not have an interpretation in \c m. These constants and functions were essentially don't cares.

       If \c model_completion is \c false, then Z3 will not assign interpretations to constants for functions that do
       not have interpretations in \c m. Evaluation behaves as the identify function in this case.

       The evaluation may fail for the following reasons:

       - \c t contains a quantifier.

       - the model \c m is partial, that is, it doesn't have a complete interpretation for uninterpreted functions.
       That is, the option \ccode{MODEL_PARTIAL=true} was used.

       - \c t is type incorrect.

       - \c Z3_interrupt was invoked during evaluation.
"
	^ self ffiCall: #( bool  Z3_model_eval (Z3Context ctx, Z3Model m, AST t, bool aBool, void * v) )	
]

{ #category : #models }
LibZ3 >> modelGetConstDecl: ctx model: m index: j [
	"Return the i-th constant in the given model."
	^ self ffiCall: #( FuncDecl  Z3_model_get_const_decl(Z3Context ctx, Z3Model m, uint j) )	
]

{ #category : #models }
LibZ3 >> modelGetConstInterp: ctx model: m funcDecl: aFuncDecl [ 
	"Return the i-th constant in the given model."
	^ self ffiCall: #( void*  Z3_model_get_const_interp(Z3Context ctx, Z3Model m, FuncDecl aFuncDecl ) )	
]

{ #category : #models }
LibZ3 >> modelGetConstInterp: ctx model: m index: j [
	"Return the i-th constant in the given model."
	^ self ffiCall: #( FuncDecl  Z3_model_get_const_decl(Z3Context ctx, Z3Model m, uint j) )	
]

{ #category : #models }
LibZ3 >> modelGetNumConsts: ctx model: m [
	"Return the number of constants assigned by the given model.

       \sa Z3_model_get_const_decl
"
	^ self ffiCall: #( uint  Z3_model_get_num_consts(Z3Context ctx, Z3Model m) )	
]

{ #category : #models }
LibZ3 >> modelIncRef: ctx model: m [
	"Increment the reference counter of the given model."
	^ self ffiCall: #( void  Z3_model_inc_ref(Z3Context ctx, Z3Model m) ).
]

{ #category : #models }
LibZ3 >> modelToString: ctx model: m [

"Convert the given model into a string.

       \warning The result buffer is statically allocated by Z3. It will
       be automatically deallocated when #Z3_del_context is invoked.
       So, the buffer is invalidated in the next call to \c Z3_model_to_string."
	^ self ffiCall: #( String  Z3_model_to_string (Z3Context ctx, Z3Model m) )	
]

{ #category : #'interaction logging' }
LibZ3 >> openLog: filename [
	"Log interaction to a file.

       extra_API('Z3_open_log', INT, (_in(STRING),))
    */
    bool Z3_API Z3_open_log(Z3_string filename);
"
]

{ #category : #parameters }
LibZ3 >> paramsDecRef: ctx p: p [
	"Decrement the reference counter of the given parameter set."
	^ self ffiCall: #( void Z3_params_inc_ref (void * c, void * p) )
]

{ #category : #parameters }
LibZ3 >> paramsIncRef: ctx p: p [
	"Increment the reference counter of the given parameter set."
	^ self ffiCall: #( void Z3_params_inc_ref (void * c, void * p) )
]

{ #category : #parameters }
LibZ3 >> paramsSetUint: ctx p: p symbol: k unsigned: v [
	"Decrement the reference counter of the given parameter set."
	^ self ffiCall: #( void  Z3_params_inc_ref (Z3Context ctx, Z3ParameterSet p, Z3Symbol k, uint v) )
]

{ #category : #parameters }
LibZ3 >> paramsToString: ctx p: p [
	"Convert a parameter set into a string.
	This function is mainly used for printing the contents of a parameter set."
	^ self ffiCall: #( String  Z3_params_to_string (Z3Context ctx, Z3ParameterSet p) )
]

{ #category : #'parser interface' }
LibZ3 >> parseSmtlib2: ctx string: str unsigned: numSorts z3symbols: sortNames z3sorts: sorts unsigned: numDecls z3symbols: declNames funcDecls: decls [
	"Parse the given string using the SMT-LIB2 parser.
	It returns a formula comprising of the conjunction of assertions in the scope
	(up to push/pop) at the end of the string."
	^ self ffiCall: #( ASTVector  Z3_parse_smtlib2_string (Z3Context ctx, String str,
		uint numSorts, void* sortNames, void* sorts, uint numDecls, void* declNames, void* decls) )
]

{ #category : #'string conversion' }
LibZ3 >> setAstPrintMode: ctx mode: anInt [
	"Select mode for the format used for pretty-printing AST nodes.

       The default mode for pretty printing AST nodes is to produce
       SMT-LIB style output where common subexpressions are printed
       at each occurrence. The mode is called \c Z3_PRINT_SMTLIB_FULL.
       To print shared common subexpressions only once,
       use the \c Z3_PRINT_LOW_LEVEL mode.
       To print in way that conforms to SMT-LIB standards and uses let
       expressions to share common sub-expressions use \c Z3_PRINT_SMTLIB2_COMPLIANT."
	^ self ffiCall: #(void Z3_set_ast_print_mode (void * ctx, int anInt) )


]

{ #category : #simplification }
LibZ3 >> simplify: ctx ast: ast [
	"Interface to simplifier.
	Provides an interface to the AST simplifier used by Z3.
	It returns an AST object which is equal to the argument.
	The returned AST is simplified using algebraic simplification rules,
	such as constant propagation (propagating true/false over logical connectives).

	Implementation note: for now, there are special versions of this
	method for simplifications of each sort: apparently simplifying
	a bitvector can only yield a bitvector, etc."
	^ self ffiCall: #( void*  Z3_simplify (Z3Context ctx, AST ast) ).


]

{ #category : #solvers }
LibZ3 >> solverAssert: ctx solver: s ast: a [
	"Assert a constraint into the solver.

       The functions #Z3_solver_check and #Z3_solver_check_assumptions should be
       used to check whether the logical context is consistent or not.

       \sa Z3_solver_assert_and_track
       \sa Z3_solver_reset

       def_API('Z3_solver_assert', VOID, (_in(CONTEXT), _in(SOLVER), _in(AST)))
    */
    void Z3_API Z3_solver_assert(Z3_context c, Z3_solver s, Z3_ast a);"
	^ self ffiCall: #( void  Z3_solver_assert (Z3Context ctx, Solver s, Bool a) )

]

{ #category : #solvers }
LibZ3 >> solverCheck: ctx solver: s [
	"
	Check whether the assertions in a given solver are consistent or not.

       The function #Z3_solver_get_model retrieves a model if the
       assertions is satisfiable (i.e., the result is \c
       Z3_L_TRUE) and model construction is enabled.
       Note that if the call returns \c Z3_L_UNDEF, Z3 does not
       ensure that calls to #Z3_solver_get_model succeed and any models
       produced in this case are not guaranteed to satisfy the assertions.

       The function #Z3_solver_get_proof retrieves a proof if proof
       generation was enabled when the context was created, and the
       assertions are unsatisfiable (i.e., the result is \c Z3_L_FALSE).

       \sa Z3_solver_check_assumptions

       def_API('Z3_solver_check', INT, (_in(CONTEXT), _in(SOLVER)))
    */
    Z3_lbool Z3_API (Z3_context c, Z3_solver s);

	"
	^ self ffiCall: #( int Z3_solver_check (Z3Context ctx, Solver s) )

]

{ #category : #solvers }
LibZ3 >> solverGetModel: ctx solver: s [
	"Retrieve the model for the last #Z3_solver_check or #Z3_solver_check_assumptions

       The error handler is invoked if a model is not available because
       the commands above were not invoked for the given solver, or if the result was \c Z3_L_FALSE."
	^self ffiCall: #( Z3Model  Z3_solver_get_model (Z3Context ctx, Solver s) ).


]

{ #category : #solvers }
LibZ3 >> solverGetNumScopes: ctx solver: s [
	"Return the number of backtracking points."
	^self ffiCall: #( uint  Z3_solver_get_num_scopes (Z3Context ctx, Solver s) ).

]

{ #category : #solvers }
LibZ3 >> solverPop: ctx solver: s n: n [
	"Backtrack n backtracking points."
	^self ffiCall: #( void  Z3_solver_pop (Z3Context ctx, Solver s, uint n) ).


]

{ #category : #solvers }
LibZ3 >> solverPush: ctx solver: s [
	"Create a backtracking point.
	 The solver contains a stack of assertions."
	^ self ffiCall: #( void  Z3_solver_push (Z3Context ctx, Solver s) ).

]

{ #category : #modifiers }
LibZ3 >> substitute: ctx ast: a numExprs: anUnsigned from: fromAstArray to: toAstArray [
	"Substitute every occurrence of from[i] in a with to[i], for i<numExprs.
	
	The result is the new AST.
	The arrays from and to must have size numExprs.
	
       For every \c i smaller than \c num_exprs, we must have that sort of \ccode{from[i]} must be equal to sort of \ccode{to[i]}.
."
	^self ffiCall: #( void*  Z3_substitute(Z3Context ctx, AST a, uint anUnsigned,
		FFIExternalArray fromAstArray, FFIExternalArray toAstArray) )
]

{ #category : #modifiers }
LibZ3 >> substituteVars: ctx ast: a numExprs: anUnsigned to: toAstArray [
	"Substitute the free variables in a with the expressions in toAstArray.
       For every \c i smaller than \c num_exprs, the variable with de-Bruijn index \c i is replaced with term \ccode{to[i]}"
	^self ffiCall: #( void*  Z3_substitute_vars(Z3Context ctx, AST a, uint anUnsigned, FFIExternalArray toAstArray) )
]

{ #category : #'accessing platform' }
LibZ3 >> unix64LibraryName [
	^ 'libz3.so'
]

{ #category : #'accessing platform' }
LibZ3 >> unix64ModuleName [
	^ 'libz3.so'
]
