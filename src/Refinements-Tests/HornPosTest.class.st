Class {
	#name : #HornPosTest,
	#superclass : #HornTest,
	#category : #'Refinements-Tests'
}

{ #category : #'example programs' }
HornPosTest >> abs02re [
^'
(constraint 
  (and
      (forall ((x Int) (Bool true))
       (forall ((VV Int) (VV === 10))
        ((VV >= 0))))
      (forall ((z Int) (Bool true))
       (and
        (forall ((r Int) (r >= 0))
         (forall ((v Int) (v >= 0 & (v === r)))
          (((v >= 0)))))
        (forall ((_t1 Int) (_t1 >= 0))
         (forall ((v Int) (v >= 0))
          (((v >= 0)))))))))
'
]

{ #category : #'example programs' }
HornPosTest >> constant [
^'
(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 100)))

(constraint 
  (forall ((x Int) (x > 0))
    (and
     (forall ((v Int) (v === (f value: x)))
       (($k0 v)))
     (forall ((z Int) ($k0 z))
       ((z === (f value: x)))))))

(constant f (func(0, [Int;Int])))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind01 [
^'
(constraint
  (forall ((m Int) (Bool true))
    (exists ((x1 Int) (Bool true))
      (and
        (forall ((v Int) (v === (m + 1))) ((v === x1)))
        (forall ((v Int) (v === (x1 + 1))) ((v === (2 + m))))))))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind02 [
^'
(var $k ((Int)))

(constraint
  (forall ((m Int) (Bool true))
    (forall ((z Int) (z === (m - 1)))
      (and
        (forall ((v1 Int) (v1 === (z + 2))) (($k v1)))
        (exists ((x1 Int) (Bool true))
          (and
            (forall ((v2 Int) ($k v2)) ((v2 === x1)))
            (forall ((v3 Int) (v3 === (x1 + 1))) ((v3 === (m + 2))))))))))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind03 [
^'
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
 (forall ((v Int) ($kb v)) ((v === 3)))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex1 [
^'
(fixpoint "--eliminate=horn")

(var $k ((Int)))

(constraint
  (forall ((x Int) (x >= 0))
    (and
      (forall ((v Int) (v === (x - 1)))
       (($k v)))
      (forall ((y Int) ($k y))
        (forall ((v Int) (v === (y + 1)))
          ((v >= 0)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex2 [
^'
(fixpoint "--eliminate=horn")

(var $kx ((Int)))
(var $ky ((Int)))

(constraint
  (forall ((x Int) (x >= 0))
    (and
      (forall ((n Int) (n === (x - 1)))
       (forall ((p Int) (p === (x + 1)))
         (and
           (forall ((v Int) (v === n)) (($kx v)))
           (forall ((v Int) (v === p)) (($ky v)))
           (forall ((v Int) ($kx p)) (($ky v))))))
      (forall ((y Int) ($ky y))
        (forall ((v Int) (v === (y + 1)))
          ((v >= 0)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex3 [
^'
(fixpoint "--eliminate=horn")

(var $ka ((Int)))
(var $kb ((Int)))
(var $kc ((Int)))

(constraint
 (and
  (forall ((a Int) ($ka a))
   (forall ((v Int) (v === (a - 1))) (($kb v))))
  (forall ((b Int) ($kb b))
   (forall ((v Int) (v === (b + 1)))
    (($kc v))))
  (forall ((v Int) (v >= 0)) (($ka v)))
  (forall ((v Int) ($kc v)) ((v >= 0)))))
'
]

{ #category : #'example programs' }
HornPosTest >> sumRec [
^'
(qualif Bar ((v Int)) (v >= 0))

(var $k_ºº1 ((Int) (Int)))

(constraint
  (and
      (forall ((n Int) (Bool true))
       (forall ((cond bool) (cond <=> (n <= 0)))
        (and
         (forall ((lq_tmpßgrdºº4 bool) (cond))
          (forall ((VV Int) (VV === 0))
           (($k_ºº1 VV n))))
         (forall ((lq_tmpßgrdºº4 bool) (cond not))
          (forall ((n1 Int) (n1 === (n - 1)))
           (forall ((t1 Int) ($k_ºº1 t1 n1))
            (forall ((v Int) (v === (n + t1)))
             (($k_ºº1 v n1)))))))))
      (forall ((y Int) (Bool true))
       (forall ((r Int) ($k_ºº1 r y))
        (forall ((ok1 bool) (ok1 <=> (0 <= r)))
           (forall ((vb bool) (and (vb <=> (0 <= r)) (vb === ok1)))
            ((vb)))))))) 
'
]

{ #category : #'example programs' }
HornPosTest >> sumRecOk [
^'
(qualif Bar ((v Int)) (v >= 0))

(var $k_ºº1 ((Int)))

(constraint
  (and
      (forall ((n int) (Bool true))
       (forall ((cond bool) (cond <=> (n <= 0)))
        (and
         (forall ((lq_tmp_grdºº4 bool) (cond))
          (forall ((VV int) (VV === 0))
           (($k_ºº1 VV))))
         (forall ((lq_tmp_grdºº4 bool) (cond not))
          (forall ((n1 int) (n1 === (n - 1)))
           (forall ((t1 int) ($k_ºº1 t1))
            (forall ((v int) (v === (n + t1)))
             (($k_ºº1 v)))))))))
      (forall ((y int) (Bool true))
       (forall ((r int) ($k_ºº1 r))
        (forall ((ok1 bool) (ok1 <=> (0 <= r)))
           (forall ((v bool) (and (v <=> (0 <= r)) (v === ok1)))
            ((v)))))))) 

'
]

{ #category : #'example programs' }
HornPosTest >> t00 [
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
         ((v > 0))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t000 [
^'
(fixpoint "--eliminate=horn")

(constraint
  (forall ((x Int) (x > 0))
    (forall ((y Int) (y > x))
      (forall ((v Int) (v === (x + y)))
         ((v > 0))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t01 [
^'
(fixpoint "--eliminate=horn")

(constraint 
  (forall ((x Int) (x > 0))
    (and
      (forall ((y Int) (y > x))
        (forall ((v Int) (v === (x + y)))
          ((v > 0))))
      (forall ((z Int) (z > 100))
        (forall ((v Int) (v === (x + z))) 
          ((v > 100)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t02 [
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
          ((v > 100)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t03 [
^'
(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 0)))

(constraint 
  (and 
    (forall ((x Int) (x > 0))
      (forall ((v Int) (v === x)) 
        (($k0 v))))
    (forall ((y Int) ($k0 y))
      (forall ((v Int) (v === (y + 1)))
        (($k0 v))))
    (forall ((z Int) ($k0 z))
        ((z > 0)))))
'
]

{ #category : #'tests - safety' }
HornPosTest >> test00 [
	self provePos: self t00
]

{ #category : #'tests - safety' }
HornPosTest >> test000 [
	self provePos: self t000
]

{ #category : #'tests - safety' }
HornPosTest >> test01 [
	self provePos: self t01
]

{ #category : #'tests - safety' }
HornPosTest >> test02 [
	self provePos: self t02
]

{ #category : #'tests - safety' }
HornPosTest >> test03 [
	self provePos: self t03
]

{ #category : #'tests - simple' }
HornPosTest >> testAB [
	self provePos: '
(var $k ((int) (`t)))

(constraint
    (and
      (forall ((x Int) (x === 0))
       (($k x A)))
      (forall ((x Int) ($k x B))
          ((x === 0)))))
'
]

{ #category : #'tests - safety' }
HornPosTest >> testAbs02re [
	self provePos: self abs02re
]

{ #category : #'tests - safety' }
HornPosTest >> testConstant [
	self provePos: self constant
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind01 [
	self provePos: self ebind01
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind02 [
	self provePos: self ebind02
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind03 [
	self provePos: self ebind03
]

{ #category : #'tests - simple' }
HornPosTest >> testHorn0000 [
	"parallel to ProofTest>>testHorn0000"
	self provePos: '
(var $k0 ((Int)))

(constraint 
  (forall ((x Int) ($k0 x))
          ((x>10))))
'
]

{ #category : #'tests - simple' }
HornPosTest >> testHornAbsurd [
	self provePos: '
(var $k0 ((Int)))

(constraint 
  (forall ((z Int) ($k0 z))
          ((z>100 & (z<0)))))
'
]

{ #category : #'tests - simple' }
HornPosTest >> testHornSimple [
	self provePos: '
(var $k0 ((Int)))

(constraint 
 (and
  (forall ((x Int) (x > 100))
          (($k0 x)))
  (forall ((z Int) ($k0 z))
          ((z > 100)))
))
'
]

{ #category : #'tests - simple' }
HornPosTest >> testHornSimpleParallelClash [
	self provePos: '
(var $k0 ((Int)))

(constraint 
 (and
  (forall ((z Int) (z > 100))
          (($k0 z)))
  (forall ((z Int) ($k0 z))
          ((z > 100)))
))
'
]

{ #category : #'tests - simple' }
HornPosTest >> testHornUninterpretedOrder [
	self provePos: '
(var $k0 ((`a) (`a)))

(constraint 
 (and
  (forall ((x `a) (Bool true))
    (forall ((y `a) (x <= y))
          (($k0 x y))))
  (forall ((v `a) (Bool true))
    (forall ((w `a) ($k0 v w))
          ((v <= w))))
))
'
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex1 [
	self provePos: self icfp17ex1
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex2 [
	self provePos: self icfp17ex2
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex3 [
	self provePos: self icfp17ex3
]

{ #category : #'tests - simple' }
HornPosTest >> testIsZero [
^'
(var $k ((Int)))

(constraint
    (and
      (forall ((x Int) (x === 0))
       (($k x)))
      (forall ((x Int) ($k x))
          ((x === 0)))))))
'
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsEbind01 [
	| q |
	q := NNFParser parse: self ebind01.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsEbind02 [
	| q |
	q := NNFParser parse: self ebind02.
	self assert: q qCstr first boundKVars equals: (Set with: 'k')
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT00 [
	| q |
	q := NNFParser parse: self t00.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT01 [
	| q |
	q := NNFParser parse: self t01.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT02 [
	| q |
	q := NNFParser parse: self t02.
	self assert: q qCstr first boundKVars equals: (Set with: 'k0')
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT03 [
	| q |
	q := NNFParser parse: self t03.
	self assert: q qCstr first boundKVars equals: (Set with: 'k0')
]

{ #category : #'tests - simple' }
HornPosTest >> testNestedAlphaRename [
	self provePos: '
(constraint
  (forall ((_ Int) (Bool true))
    (forall ((_ Int) (Bool true)) ((_ === _)))))
'
]

{ #category : #'tests - corner cases' }
HornPosTest >> testReftConjuncts1 [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((z int) (and ($k z y) ((z === res))))
       ((0 <= z)))))))
'

]

{ #category : #'tests - corner cases' }
HornPosTest >> testReftConjunctsM [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((z int) (and (and ($k z y) ((Bool true))) ((z === res))))
       ((0 <= z)))))))
'

]

{ #category : #'tests - simple' }
HornPosTest >> testSimpleDependentForall [
	self provePos: '
		(constraint
  	  (forall ((x Int) (x>0))
  	    (forall ((y Int) (y>x))
         ((y*y >= (x*x))))))'
]

{ #category : #'tests - simple' }
HornPosTest >> testSimpleForall [
	self provePos: '
		(constraint
  	  (forall ((x Int) (Bool true))
         ((x*x >= 0))))'
]

{ #category : #'tests - simple' }
HornPosTest >> testSimpleForall2 [
	self provePos: '
		(constraint
  	  (forall ((x Int) (x > 0))
         ((x >= 0))))'
]

{ #category : #'tests - simple' }
HornPosTest >> testSimplePleX [
	"Even though there is no information about what 'adder' is,
	 Z3 can still use the congruence axiom."
	self provePos: '
(constant adder (func(0, [Int;Int;Int])))

(constraint 
  (forall ((x Int) (x > 0))
     (forall ((y Int) (y === 0))
       (((adder value: x value: y) - (adder value: x value: y) === 0)))))
'
]

{ #category : #'tests - sol1' }
HornPosTest >> testSol1_1 [
"
Cf. Horn/Transformations.hs:
-- >> c <- qCstr . fst <$> parseFromFile hornP tests/horn/pos/test02.smt2'
-- >> sol1 ('k0') (scope 'k0' c)
-- [[((y int) (y > x + 100)),((v int) (v == x + y)),((_ bool) (κarg$k0#1 == v))]]
"
	| q scope c sol binds fExprs |
	q := NNFParser parse: self t02.
	self deny: q isPetitFailure.
	c := q qCstr first.
	scope := c scope: 'k0'.  "-> Cstr"
	sol := scope sol1: 'k0'.  "-> [([Bind], [F.Expr])]"
	binds := sol first key.  "[ y:ℤ | «y > (x + 100)» , v:ℤ | «v === (x + y)» ]"
	fExprs := sol first value.  " [ PAtomEq «kkargßk0º1»=«v» ] "
	
	self assert: binds size equals: 2.
	self assert: fExprs size equals: 1.
	"We could assert a lot more here but this is more an example
	 to experiment with, than a test."
]

{ #category : #'tests - sol1' }
HornPosTest >> testSol1_2 [
"
Cf. Horn/Transformations.hs:
-- >> c <- qCstr . fst <$> parseFromFile hornP 'tests/horn/pos/test03.smt2'
-- >> sol1 ('k0') (scope 'k0' c)
-- [[((x int) (x > 0)),((v int) (v == x)),((_ bool) (κarg$k0#1 == v))],[((y int) (k0 y)),((v int) (v == y + 1)),((_ bool) (κarg$k0#1 == v))]]
"
	| q scope c sol binds fExprs |
	q := NNFParser parse: self t03.
	self deny: q isPetitFailure.
	c := q qCstr first.
	scope := c scope: 'k0'.  "-> Cstr"
	sol := scope sol1: 'k0'.  "-> [([Bind], [F.Expr])]"
	binds := sol first key.  "[ x:ℤ | «x > 0» , v:ℤ | «v === x» ]"
	fExprs := sol first value.  " [ PAtomEq «kkargßk0º1»=«v» ] "
	
	self assert: binds size equals: 2.
	self assert: fExprs size equals: 1.
	"We could assert a lot more here but this is more an example
	 to experiment with, than a test."
]

{ #category : #'tests - sol1' }
HornPosTest >> testSol1_3 [
"
Cf. Horn/Transformations.hs:
-- >> let c = doParse' hCstrP '' '(forall ((a Int) (p a)) (forall ((b Int) (q b)) (and (($k a)) (($k b)))))'
-- >> sol1 'k' c
-- [[((a int) (p a)),((b int) (q b)),((_ bool) (κarg$k#1 == a))],[((a int) (p a)),((b int) (q b)),((_ bool) (κarg$k#1 == b))]]
"
	| c sol sa sb |
	c := (NNFParser new productionAt: #forall) parse: 'forall ((a Int) (p a)) (forall ((b Int) (q b)) (and (($k a)) (($k b))))'.
	self deny: c isPetitFailure.
	sol := c sol1: 'k'.  "-> [([Bind], [F.Expr])]"
	self assert: sol size equals: 2.
	
	"the 'κarg$k#1 = a' solution:"
	sa := sol detect: [ :s | s value anySatisfy: [ :eq | eq y sym = 'a' ] ].
	self assert: sa key size equals: 2.
	
	"the 'κarg$k#1 = b' solution:"
	sb := sol detect: [ :s | s value anySatisfy: [ :eq | eq y sym = 'b' ] ].
	self assert: sb key size equals: 2.
]

{ #category : #'tests - safety' }
HornPosTest >> testSumRec [
	self provePos: self sumRec
]

{ #category : #'tests - safety' }
HornPosTest >> testSumRecOk [
	self provePos: self sumRecOk
]

{ #category : #'tests - simple' }
HornPosTest >> testTrivialTypeVar [
	self provePos: '
		(constraint
  	 (forall ((x `a) (Bool true))
   		 ((Bool true))))'
]
