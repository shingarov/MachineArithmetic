Class {
	#name : #SpriteHornNegTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
SpriteHornNegTest >> proveNeg: txt [
	self assert: (self verify: txt) equals: #Unsafe
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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
