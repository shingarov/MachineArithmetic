"
TestCaseWithZ3Context is a abstract testcase superclass ensuring that each
test is run in a separate `Z3Context`, leaving the default 'global' context
intact.

There's no real to make Z3 tests a subclass of `TestCaseWithZ3Context`, tests
should pass even when subclassing SUnit's `TestCase` directly (in which case,
a default ""global"" `Z3Context` will be used).

`TestCaseWithZ3Context` is used merely to make sure the codebase works
correctly when using custom `Z3Context` provided via query.

"
Class {
	#name : #TestCaseWithZ3Context,
	#superclass : #TestCase,
	#category : #'Z3-Tests'
}

{ #category : #private }
TestCaseWithZ3Context >> runCase [
	| ctx |

	ctx := Z3Context fromDefault.
	"Z3Context createGlobalContext."
	[
		Z3ContextQuery answer: ctx do: [
			super runCase
		].
	] ensure: [
		ctx release.
		"Z3Context current release."
	].
]
