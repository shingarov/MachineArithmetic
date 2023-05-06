Class {
	#name : #HornNegTest,
	#superclass : #HornTest,
	#category : #'Refinements-Tests'
}

{ #category : #'example programs' }
HornNegTest >> abs02re [
^'
(fixpoint "--eliminate=horn")

(var $k_1 ((Int) (Int)))
(var $k_3 ((Int) (Int)))

(constraint
  (and
      (forall ((x int) (Bool true))
       (forall ((pos bool) (pos <=> (x >= 0)))
        (and
         (forall ((lq_tmp_grd3 bool) (pos))
          (forall ((VV int) (VV === x))
           (($k_1 VV x))))
         (forall ((lq_tmp_gr3 bool) (pos not))
          (forall ((v int) (v === (0 - x)))
           (($k_1 v x)))))))
      (forall ((z int) (Bool true))
       (and
        (forall ((r int) (r >= 0))
         (forall ((v int) (v === (r + 1)))
          (($k_3 v z))))
        (and
         (forall ((t1 int) (t1 >= 0))
          (forall ((VV0 int) ($k_1 VV0 t1))
           (((VV0 >= 0)))))
         (forall ((res int) ($k_3 res z))
          (forall ((ok bool) (ok <=> (6660 <= res)))
           (forall ((v bool) ((v <=> (6660 <= res)) & (v === ok)))
            ((v))))))))))
'
]

{ #category : #'example programs' }
HornNegTest >> ebind03 [
^'
(fixpoint "--eliminate=horn")

(var $ka ((Int)))
(var $kb ((Int)))

(constraint
(and
 (exists ((x1 Int) (Bool true))
  (and
   (forall ((v Int) (v === 1)) ((v === x1)))
   (forall ((v Int) (v === (x1 + 1))) (($ka v)))))
 (exists ((x2 Int) (Bool true))
  (and
   (forall ((v Int) ($ka v)) ((v === x2)))
   (forall ((v Int) (v === (x2 + 1))) (($kb v)))))
 (forall ((v Int) ($kb v)) ((v === 5)))))
'
]

{ #category : #'example programs' }
HornNegTest >> t00 [
^'
(fixpoint "--eliminate=horn")

(qualif  Foo ((v Int) (x Int)) (v = x))
(qualif  Bar ((v Int) (x Int)) (v > x))

(var $k1 ((Int) (Int) (Int)))
(var $k2 ((Int) (Int) (Int)))
(var $k3 ((Int) (Int) (Int)))

(constraint 
(forall ((x Int) (x > 0))
  (forall ((y Int) (y > x))
    (forall ((v Int) (v === (x + y))) 
       ((v > 10))))))
'
]

{ #category : #'example programs' }
HornNegTest >> t000 [
^'
(fixpoint "--eliminate=horn")

(constraint 
(forall ((x Int) (x > 0))
  (forall ((y Int) (y > x))
    (forall ((v Int) (v === (x + y))) 
       ((v > 10))))))
'
]

{ #category : #'example programs' }
HornNegTest >> t01 [
^'
(fixpoint "--eliminate=horn")

(constraint 
(forall ((x Int) (x > 0))
  (and
    (forall ((y Int) (y > x))
      (forall ((v Int) (v === (x + y))) 
        ( (v > 0)  )))
    (forall ((z Int) (z > 10))
      (forall ((v Int) (v === (x + z)))
        (tag (v > 100) "gt-100" ))))))
'
]

{ #category : #'example programs' }
HornNegTest >> t01notag [
^'
(fixpoint "--eliminate=horn")

(constraint 
(forall ((x Int) (x > 0))
  (and
    (forall ((y Int) (y > x))
      (forall ((v Int) (v === (x + y))) 
        ((v > 0))))
    (forall ((z Int) (z > 10))
      (forall ((v Int) (v === (x + z)))
        ((v > 100)))))))
'
]

{ #category : #'example programs' }
HornNegTest >> t02 [
^'
(fixpoint "--eliminate=horn")

(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 100)))

(constraint 
  (forall ((x Int) (x > 0))
    (and
      (forall ((y Int) (y > (x + 100)))
        (forall ((v Int) (v === (x + y)))
          (($k0 v))))
      (forall ((z Int) ($k0 z))
        (forall ((v Int) (v === (x + z)))
          ((v > 200)))))))
'
]

{ #category : #'example programs' }
HornNegTest >> t03 [
^'
(fixpoint "--eliminate=horn")

(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 10)))

(constraint 
  (and 
    (forall ((x Int) (x > 0))
      (forall ((v Int) (v = x)) 
        (($k0 v))))
    (forall ((y Int) ($k0 y))
      (forall ((v Int) (v = y + 1)) 
        (($k0 v))))
    (forall ((z Int) ($k0 z))
        ((z > 0)))))
'
]

{ #category : #tests }
HornNegTest >> test00 [
	self proveNeg: self t00
]

{ #category : #tests }
HornNegTest >> test000 [
	self proveNeg: self t000
]

{ #category : #tests }
HornNegTest >> test01 [
	self proveNeg: self t01notag 
]

{ #category : #tests }
HornNegTest >> test02 [
	self proveNeg: self t02
]

{ #category : #tests }
HornNegTest >> test03 [
	self
		should: [ self proveNeg: self t03 ]
		raise: CyclicConstraint 
]

{ #category : #tests }
HornNegTest >> testAbs02re [
	self proveNeg: self abs02re
]

{ #category : #tests }
HornNegTest >> testEbind03 [
	self
		should: [ self proveNeg: self ebind03 ]
		raise: ShouldNotImplement 
]

{ #category : #tests }
HornNegTest >> testIrregularADT00 [
"we want this to fail because FingerTree is NOT a 'regular' datatype. See `isRegularDataDecl`"

'

(data Node 1 = [
       | Node3 {Node3_lqdc_select_Node3_1 : @(0), Node3_lqdc_select_Node3_2 : @(0), Node3_lqdc_select_Node3_3 : @(0)}
       | Node2 {Node2_lqdc_select_Node2_1 : @(0), Node2_lqdc_select_Node2_2 : @(0)}
])

(data Digit 1 = [
       | Four {Four_lqdc_select_Four_1 : @(0), Four_lqdc_select_Four_2 : @(0), Four_lqdc_select_Four_3 : @(0), Four_lqdc_select_Four_4 : @(0)}
       | Three {Three_lqdc_select_Three_1 : @(0), Three_lqdc_select_Three_2 : @(0), Three_lqdc_select_Three_3 : @(0)}
       | Two {Two_lqdc_select_Two_1 : @(0), Two_lqdc_select_Two_2 : @(0)}
       | One {One_lqdc_select_One_1 : @(0)}
])

(data FingerTree 1 = [
       | Deep {Deep_lqdc_select_Deep_1 : (Digit @(0)), Deep_lqdc_select_Deep_2 : (FingerTree (Node @(0))), Deep_lqdc_select_Deep_3 : (Digit @(0))}
       | Single {Single_lqdc_select_Single_1 : @(0)}
       | EmptyT {}
])


(constant len (func(1, [(FingerTree @(0)), int])))

(define len(l: [a]) : int = {
  if (is$VNil l) then 0 else (1 + len(tail l))
})

(constraint
  (forall ((x (FingerTree int)) (true))
    (forall ((y (FingerTree int)) (y = x)) 
      (forall ((z (FingerTree int)) (z = y)) 
        (((len z) == (len x)))
      )
    )
  )
)
'
]

{ #category : #tests }
HornNegTest >> testPle0 [
'
(fixpoint "--rewrite")

(constant adder (func(0, [int, int, int])))

(define adder(x : int, y : int) : int = { x + y })

(constraint 
   (forall ((x int) (x == 5)) 
     (forall ((y int) (y == 6)) 
       (( (adder x y) = 12 ))
     )
   )
)
'
]

{ #category : #tests }
HornNegTest >> testPleList00 [
'
(fixpoint "--rewrite")

(constant len (func(1, [(Main.List  @(0)), int])))
(constant Cons (func(2, [@(0), (Main.List  @(0)), (Main.List @(0))])))
(constant Nil  (Main.List @(0)))

(match len Nil = 0)
(match len Cons x xs = (1 + len xs))

(constraint
  ((len (Cons 1 (Cons 2 (Cons 3 Nil))) = 4))
)
'
]

{ #category : #tests }
HornNegTest >> testPleList01ADT [
'
(fixpoint "--rewrite")

(data Vec 1 = [
  | VNil  { }
  | VCons { head : @(0), tail : Vec @(0)}
])

(constant len (func(1, [(Vec @(0)), int])))

(define len(l: [a]) : int = {
  if (is$VNil l) then 0 else (1 + len(tail l))
})

(constraint
  (forall ((x int) (true))
    (forall ((y int) (y = 2)) 
      (forall ((z int) (z = 3)) 
        ((len (VCons x (VCons y (VCons z VNil))) = 30))
      )
    )
  )
)
'
]

{ #category : #tests }
HornNegTest >> testPleList03 [
'
(fixpoint "--rewrite")

(define ints2 (): [int] = { 
   Cons 1 (Cons 20 Nil)
})

(define filter (lq1 : func(0 , [a##a29r;bool]),  lq2 : [a##a29r]) : [a##a29r] = {
  if (isNil lq2) then Nil else (
      if (lq1 (head lq2)) 
        then (Cons (head lq2) (filter lq1 (tail lq2))) 
        else (filter lq1 (tail lq2)))
})

(define ints0 () : [int] = { 
    Cons 0 (Cons 1 (Cons 2 Nil))
})

(define isPos (lq1 : int) : bool = {
    lq1 > 0
})


(match isCons Cons x xs = (true))
(match isNil  Cons x xs = (false))
(match isCons Nil       = (false))
(match isNil  Nil       = (true))
(match tail Cons x xs   = (xs))
(match head Cons x xs   = (x))

(constant isCons (func(1 , [[@(0)], bool])))
(constant isNil  (func(1 , [[@(0)], bool])))
(constant Nil    (func(1 , [[@(0)]])))
(constant tail   (func(1 , [[@(0)], [@(0)]])))
(constant head   (func(1 , [[@(0)], @(0)])))
(constant ints0   [int])
(constant ints2   [int])
(constant filter  (func(1 , [func(0 , [@(0), bool]), [@(0)], [@(0)]])))
                
(constant isPos  (func(0 , [int, bool])))
(constant Cons   (func(1 , [@(0), [@(0)], [@(0)]])))
(constant Nil    (func(1 , [[@(0)]])))

(constraint
  ((filter isPos ints0 == ints2))
)
'
]

{ #category : #tests }
HornNegTest >> testPleSum [
'
(fixpoint "--rewrite")

(constant sum  (func(0, [int, int])))

(define sum(n : int) : int = { if (n <= 0) then (0) else (n + sum (n-1)) })

(constraint 
   (forall ((x int) (x == 5)) 
       (( (sum x) = 150 ))
   )
)

'
]

{ #category : #tests }
HornNegTest >> testPleSumFuel5 [
'
(fixpoint "--rewrite")
(fixpoint "--save")
(fixpoint "--fuel=5")

(constant sum  (func(0, [int, int])))

(define sum(n : int) : int = { if (n <= 0) then (0) else (n + sum (n-1)) })

(constraint 
   (forall ((x int) ((5 <= x) && (0 <= (sum (x-5))))) 
       ((15 <= (sum x)))
   )
)

'
]

{ #category : #'tests - simple' }
HornNegTest >> testSimpleDependentForall [
	self proveNeg: '
		(constraint
  	  (forall ((x Int) (Bool true))
  	    (forall ((y Int) (y>x))
         ((y*y >= (x*x))))))'
]

{ #category : #'tests - simple' }
HornNegTest >> testSimpleForall [
	self proveNeg: '
		(constraint
  	  (forall ((x Int) (Bool true))
         ((x > 0))))'
]

{ #category : #'tests - simple' }
HornNegTest >> testSimplePleX [
	"This is like Pos>>testPle0 except there is no 'define adder',
	 so no information is available for PLE."
	self proveNeg: '
(constant adder (func(0, [int; int; int])))

(constraint 
   (forall ((x int) (x === 2)) 
     (forall ((y int) (y === 2)) 
       (( (adder value: x value: y) === 4 )))))
'
]

{ #category : #tests }
HornNegTest >> testTag00 [
'
(fixpoint "--eliminate=horn")

(constraint 
(forall ((x Int) (x > 0))
  (and
    (forall ((y Int) (y > x))
      (forall ((v Int) (v = x + y)) 
        ( (v > 0)  )))
    (forall ((z Int) (z > 10))
      (forall ((v Int) (v = x + z)) 
        (tag (v > 100) "gt-100" )))))
)


'
]
