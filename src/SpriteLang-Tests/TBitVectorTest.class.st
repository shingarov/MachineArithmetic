Class {
	#name : #TBitVectorTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
TBitVectorTest >> test_01 [
	self proveSafe: '
	    ⟦val int8 : bv8 ⟧
	    let int8 = bv8(127);
	'
]

{ #category : #tests }
TBitVectorTest >> test_02 [
	self proveSafe: '
	    ⟦val int8 : bv8 ⟧
	    let int8 = bvadd8(bv8(126),bv8(1));
	'
]

{ #category : #tests }
TBitVectorTest >> test_03n [
	self proveUnsafe: '
	    ⟦val int8 : bv8[v|v === 127] ⟧
	    let int8 = bvadd8(bv8(126),bv8(2));
	'
]

{ #category : #tests }
TBitVectorTest >> test_03p [
	self proveSafe: '
	    ⟦val int8 : bv8[v|v === -128] ⟧
	    let int8 = bvadd8(bv8(126) , bv8(2));
	'
]

{ #category : #tests }
TBitVectorTest >> test_04 [
	self should:[
		self proveSafe: '
		    ⟦val int8 : bv8[v|v === 127] ⟧
		    let int8 = bv8(126) + bv10(1);
		'
	] raise: Error "Cannot unify"
]

{ #category : #tests }
TBitVectorTest >> test_05n [
	self proveUnsafe: '
		    ⟦val int8 : bv8[v|v === 127] ⟧
		    let int8 = {
					bv8(128)
				};
		'
]

{ #category : #tests }
TBitVectorTest >> test_05p [
	self proveSafe: '
		    ⟦val int32 : bv32[v|v === 127] ⟧
		    let int32 = {
					bv32(127)
				};
		'
]

{ #category : #tests }
TBitVectorTest >> test_06n [
	self proveUnsafe: '
		    ⟦val int8 : bv8[v|v === 127] ⟧
		    let int8 = {
					let v126 = bv8(126);
					bvadd8(v126 , bv8(10))
				};
		'
]

{ #category : #tests }
TBitVectorTest >> test_06p [
	self proveSafe: '
		    ⟦val int8 : bv8[v|v === 127] ⟧
		    let int8 = {
					let v126 = bv8(126);
					bvadd8(v126 , bv8(1))
				};
		'
]

{ #category : #tests }
TBitVectorTest >> test_07n [
	self proveUnsafe: '
		    ⟦val int16 : bv16[v|v === 0] ⟧
		    let int16 = bvmul16(bv16(10),bv16(1));
		'
]

{ #category : #tests }
TBitVectorTest >> test_07p [
	self proveSafe: '
		    ⟦val int64 : bv64[v|v === 0] ⟧
		    let int64 = bvmul64(bv64(10),bv64(0));
		'
]

{ #category : #tests }
TBitVectorTest >> test_08p [
	self proveSafe: '
		    ⟦val t : bool[v|v === Bool true] ⟧
		    let t = bvgt64(bv64(10),bv64(0));
		'
]

{ #category : #tests }
TBitVectorTest >> test_09n [
	self proveUnsafe: '
		    ⟦val t : bv8 => bool[v|v] ⟧
		    let t = (x) => {
					x == bv8(5)
			  };
		'
]

{ #category : #tests }
TBitVectorTest >> test_09p [
	self proveSafe: '
		    ⟦val t : bv8 => bool[v|v] ⟧
		    let t = (x) => {
					x == x
			  };
		'
]

{ #category : #tests }
TBitVectorTest >> test_sum_Gauss_BV [
	self proveSafe: '
[--check-termination]
⟦reflect sum : n:bv8 => bv8 / [n]⟧
let rec sum = (n) => {
  let base = n == bv8(0);
  if (base) {
    bv8(0)
  } else {
    let n1 = bvsub8(n,bv8(1));
    let t1 = sum(n1);
    bvadd8(n,t1)
  }
};

⟦val thm_sum : n:bv8 => bv8[w| 2///8*(sum value: n) === (n+1 * n)] / [n]⟧
let rec thm_sum = (n) => {
  let base = n == bv8(0);
  if (base) {
    bv8(0)
  } else {
    let n1 = bvsub8(n,bv8(1));
    thm_sum(n1)
  }
};
'
]
