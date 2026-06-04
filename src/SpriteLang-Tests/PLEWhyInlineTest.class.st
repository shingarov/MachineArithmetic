"
This is the place to save the LH Slack conversation of Mar 1, 2024 before it gets lost.
The conversation sheds light on fundamental design of PLE.

bgs> Sorry for going circles for like the thousandth time,
bgs> but I think I stopped understanding the simplest basic things.
bgs> The following Sprite is UNSAFE:

test1_n

bgs> even though this next one is SAFE:

test1_p

bgs> Have I gone out of my mind? Isn't `yourself(x)` unfolded to `x`???

… some discussion …

rj> Ok, I think I know what is going on.
rj> The deal with PLE (which is the reason why it terminates),
rj> is that it _only unfolds definitions that will *provably* ""execute""_.

rj> The provably part is done by querying SMT to check if the guards
rj> (if conditions) are guaranteed to hold.

rj> Now, in your `abs` example that is rejected, you define

rj>     let cond = x &gt; 0;
rj>     if (cond) {
rj>       yourself(x)
rj>     } else {
rj>       0 - x
rj>     }

rj> so `yourself(x)` occurs under the guard `cond`  (i.e. `x > 0` which of course,
rj> is *not* guaranteed to hold), and so `yourself` is NOT unfolded.

rj> If instead, you rewrote your definition as

rj>     let rec abs = (x) => {
rj>       let cond = x > 0;
rj>       let z = yourself(x);
rj>       if (cond) {
rj>         z
rj>       } else {
rj>         0 - x
rj>       }
rj>     };

rj> then it should work.

rj> Of course, all these restrictions are for _recursive_ functions.
rj> In the case of non-recursive functions, one can/should always just inline ...
rj> but I don't think we've ""taught"" fixpoint to do that.
rj> In LH you would mark the non-recursive functions with {-@ inline abs @-}
rj> and then all of this would verify just fine...

bgs> rj> If instead, you rewrote your definition as <...> then it should work.

bgs> sigh... it does not... same Unsafe...

bgs> I mean, yes I understand/agree about checking-the-guards parts,
bgs> but something else is also going on, and I can't figure out what that is...

rj> let me try to get sprite up-to-date with the latest fixpoint, and see what's happening!

rj> ugh -- its because of the way that fixpoint internally ""inlines"" all the let
rj> to reduce the recursive definitions to a ""guarded"" form, so
rj>   `let cond = x > 0; z = myself(x) in if (cond) then z else ...`
rj> is internally represented as `if cond > 0 then myself(x) else ...` :-p

bgs> Hmmm... once again, to ensure I understand,
bgs> rj> The provably part is done by querying SMT to check if the guards
bgs> rj> (if conditions) are guaranteed to hold
bgs> That's the isValid function in PLE.hs, right?

rj> :thumbs_up:

rj> So, for example to get your example working you can ""force"" the case split, by doing

rj>     let rec yourself = (y) => {
rj>       y
rj>     };
rj>     /**@ reflect abs : int => int / 0 **/
rj>     let rec abs = (x) => {
rj>       let cond = x > 0;
rj>       if (cond) {
rj>         yourself(x)
rj>       } else {
rj>         0 - x
rj>       }
rj>     };
rj>     /**@ val main : int => bool[b|b] **/
rj>     let main = (z) => {
rj>       let got = abs(z);
rj>       let cond1 = z > 0;
rj>       let res = got >= 0;
rj>       if (cond1) {
rj>         res
rj>       } else {
rj>         res
rj>       }
rj>     };
[ test1_n_split ]

bgs> so it's similar to how we case-split the base/inductive case in the body of Gauss thm_sum?

rj> :+100:

bgs> the `if (base)`
bgs> only it's really silly in this case because there is no recursion

rj> :+100:

bgs> rj> mark the non-recursive functions with {-@ inline abs @-} and then
bgs> So the plugin will simply replace every application of abs with the body?
bgs> I wonder how this would map to sprite's setting... so every
bgs>   `(EApp abs...)` (that's sprite's EApp, not F.EApp)
bgs> is ""macroexpanded""... at elaboration time?

rj> :+100:

"
Class {
	#name : #PLEWhyInlineTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
PLEWhyInlineTest >> test1_n [
self proveUnsafe: '
[--check-termination]

⟦reflect yourself : int => int / [0 toInt] ⟧
let rec yourself = (y) => { y };

⟦reflect abs : int => int / [0 toInt] ⟧
let rec abs = (x) => {
  let cond = x > 0;
  if (cond) {
    yourself(x)
  } else {
    0 - x
  }
};

⟦val main : int => bool[b|b] ⟧
let main = (z) => {
  let got = abs(z);
  got >= 0
};

'
]

{ #category : #tests }
PLEWhyInlineTest >> test1_n_split [
self proveSafe: '
[--check-termination]

⟦reflect yourself : int => int / [0 toInt] ⟧
let rec yourself = (y) => { y };

⟦reflect abs : int => int / [0 toInt] ⟧
let rec abs = (x) => {
  let cond = x > 0;
  if (cond) {
    yourself(x)
  } else {
    0 - x
  }
};

⟦val main : int => bool[b|b] ⟧
let main = (z) => {
  let got = abs(z);
  let cond1 = z > 0;
  let res = got >= 0;
  if (cond1) {
    res
  } else {
    res
  }
};

'
]

{ #category : #tests }
PLEWhyInlineTest >> test1_p [
self proveSafe: '
[--check-termination]

⟦reflect abs : int => int / [0 toInt] ⟧
let rec abs = (x) => {
  let cond = x > 0;
  if (cond) {
    x
  } else {
    0 - x
  }
};

⟦val main : int => bool[b|b] ⟧
let main = (x) => {
  let got = abs(x);
  got >= 0
};

'
]
