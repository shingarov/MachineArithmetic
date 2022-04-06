Class {
	#name : #SpriteHornNegTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-L2' }
SpriteHornNegTest >> proveNeg: txt [
	self assert: (self verify: txt) equals: #Unsafe
]

{ #category : #'tests-L1' }
SpriteHornNegTest >> testL1inc00 [
	self proveNeg: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x - 1)))
     (((v === (x + 1)))))))
  (and
   (and
    (and)
    (forall ((VV int) (VV === 10))
     ((Bool true))))
   (forall ((bar int) (bar === (10 + 1)))
    (and
     (and)
     (forall ((VV int) (VV === 0))
      ((Bool true))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornNegTest >> testL1inc01 [
	self proveNeg: '
(constraint
 (and
  (forall ((x int) (0 <= x))
   (and
    (and
     (and
      (and)
      (forall ((v int) (0 <= v))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((0 <= v))))))
  (and
   (forall ((x int) (Bool true))
    (and
     (and
      (and
       (and)
       (forall ((VV int) (Bool true))
        ((Bool true))))
      (forall ((VV int) (VV === 1))
       ((Bool true))))
     (forall ((v int) (v === (x - 1)))
      (((v === (x - 1)))))))
   (and
    (forall ((x int) (0 <= x))
     (and
      (and
       (and)
       (forall ((v int) (0 <= v))
        (((0 <= v)))))
      (forall ((tmp int) (0 <= tmp))
       (and
        (and
         (and)
         (forall ((v int) (0 <= v))
          ((Bool true))))
        (forall ((v int) (v === (tmp - 1)))
         (((0 <= v))))))))
    (and
     (and)
     (forall ((VV int) (VV === 0))
      ((Bool true))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornNegTest >> testL1inc02 [
	self proveNeg: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x - 1)))
     (((v === (x - 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and
       (and)
       (forall ((v int) (0 <= v))
        (((0 <= v)))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))
     (and
      (and
       (and)
       (and
        (forall ((v int) (0 <= v))
         ((Bool true)))
        (forall ((_zzz int) (0 <= _zzz))
         (forall ((v int) (v === (_zzz - 1)))
          (((0 <= v)))))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornNegTest >> testL1int01 [
	self proveNeg: '
(constraint
 (and
  (and)
  (forall ((v1 int) (v1 === 1))
   (and
    (and)
    (forall ((v2 int) (v2 === 2))
     (and
      (and
       (and
        (and
         (and)
         (forall ((VV int) (VV === 1))
          ((Bool true))))
        (forall ((VV int) (VV === 2))
         ((Bool true))))
       (forall ((v int) (v === (v1 + v2)))
        (((v === 30)))))
      (forall ((top int) (top === 30))
       (and
        (and)
        (forall ((VV int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L2' }
SpriteHornNegTest >> testL2cmp00 [
	self proveNeg: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (VV === x))
       ((Bool true))))
     (forall ((VV int) (VV === 10))
      ((Bool true))))
    (forall ((cond bool) (cond <=> (x < 10)))
     (and
      (forall ((lq_tmpßgrdºº2 bool) (cond))
       (and
        (and)
        (forall ((VV bool) (VV <=> Bool true))
         (((VV <=> (x < 0)))))))
      (forall ((lq_tmpßgrdºº2 bool) (cond not))
       (and
        (and)
        (forall ((VV bool) (VV <=> Bool false))
         (((VV <=> (x < 0)))))))))))
  (and
   (and)
   (forall ((VV int) (VV === 0))
    ((Bool true))))))
'
]

{ #category : #'tests-L2' }
SpriteHornNegTest >> testL2cmp00α [
	self proveNeg: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV1 int) (VV1 === x))
       ((Bool true))))
     (forall ((VV2 int) (VV2 === 10))
      ((Bool true))))
    (forall ((cond bool) (cond <=> (x < 10)))
     (and
      (forall ((lq_tmpßgrdºº2 bool) (cond))
       (and
        (and)
        (forall ((VV3 bool) (VV3 <=> Bool true))
         (((VV3 <=> (x < 0)))))))
      (forall ((lq_tmpßgrdºº2 bool) (cond not))
       (and
        (and)
        (forall ((VV4 bool) (VV4 <=> Bool false))
         (((VV4 <=> (x < 0)))))))))))
  (and
   (and)
   (forall ((VV5 int) (VV5 === 0))
    ((Bool true))))))
'
]

{ #category : #'tests-L3' }
SpriteHornNegTest >> testL3abs02 [
	self proveNeg: '
(var $k_ºº5 ((int) (int)))
(var $k_ºº3 ((int) (int)))
(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (forall ((b bool) (b)) 
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (and
     (and
      (forall ((VV int) (VV === 0))
       (and)) 
      (forall ((VV int) (and (Bool true) (VV === x)))
       (and)))
     (forall ((pos bool) (pos <=> (0 <= x)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
        (and
         (and
          (forall ((VV int) (VV === 0))
           (and)) 
          (forall ((VV int) (and (Bool true) (VV === x)))
           (and)))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))))
   (and
    (forall ((x int) (Bool true))
     (and
      (and
       (forall ((VV int) (and (Bool true) (VV === x)))
        (and)) 
       (forall ((r int) ($k_ºº3 r x))
        (forall ((VVºº2 int) (and ($k_ºº3 VVºº2 x) (VVºº2 === r)))
         (($k_ºº5 VVºº2 x)))))
      (and
       (and
        (forall ((VV int) (Bool true))
         (and)) 
        (forall ((_ int) (Bool true))
         (forall ((VVºº0 int) ($k_ºº1 VVºº0 _))
          (($k_ºº3 VVºº0 x)))))
       (forall ((res int) ($k_ºº5 res x))
        (and
         (and
          (forall ((VV int) (VV === 0))
           (and)) 
          (forall ((VVºº4 int) (and ($k_ºº5 VVºº4 x) (VVºº4 === res)))
           (and)))
         (forall ((ok bool) (ok <=> (0 < res)))
          (and
           (forall ((v bool) (and (v <=> (0 < res)) (v === ok)))
            ((v))) 
           (forall ((VV int) (Bool true))
            (and)))))))))
    (forall ((VV int) (VV === 0))
     (and))))))
'
]

{ #category : #'tests-L3' }
SpriteHornNegTest >> testL3abs02shorter [
	self proveNeg: '
(var $k5 ((int) (int)))
(var $k3 ((int) (int)))
(var $k1 ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
     (forall ((pos bool) (pos <=> (0 <= x)))
      (and
       (forall ((grd1 bool) (pos))
        (forall ((VV int) (VV === x))
         (($k1 VV x))))
       (forall ((grd2 bool) (pos not))
         (forall ((v int) (v === (0 - x)))
          (($k1 v x)))))))
    (forall ((x int) (Bool true))
     (and
       (forall ((r int) ($k3 r x))
        (forall ((VVºº2 int) (and ($k3 VVºº2 x) (VVºº2 === r)))
         (($k5 VVºº2 x))))
        (forall ((a1 int) (Bool true))
         (forall ((VVºº0 int) ($k1 VVºº0 a1))
          (($k3 VVºº0 x))))
       (forall ((res int) ($k5 res x))
         (forall ((ok bool) (ok <=> (0 < res)))
           (forall ((v bool) (and (v <=> (0 < res)) (v === ok)))
            ((v)))))))))
'
]

{ #category : #'tests-L3' }
SpriteHornNegTest >> testL3test3 [
	self proveNeg: '
(var $k_1 ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 42))
     (($k_1 VV x))))
    (forall ((a int) (Bool true))
      (forall ((z int) ($k_1 z a))
        (forall ((VV0 int) (and ($k_1 VV0 a) (VV0 === z)))
         (((VV0 === 1))))))))


'
]
