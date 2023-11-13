| repo packages cycleDetector depChecker visited unwanted error |

error := false.

"
1. Collect MA packages.
"
repo := IceRepository registry detect:[:each |
				each workingCopy packages contains: [:pkg | pkg package = 'Z3' ] ].
packages := repo loadedPackages collect: #package.

"
2. Detect cycles
"
cycleDetector := DAPackageCycleDetector onPackagesNamed: packages.
cycleDetector runAlgorithm.
cycleDetector cycles do:[:cycle|
	error := true.
	Transcript show: 'ERROR: Package Dependency Cycle: '; show: cycle displayString; cr.

].

"
3. Ensure Z3 has no unwanted dependencies, namely:

   i)   PreSmalltalks has no dependencies within MA except 'PreSmalltalks-Pharo'
   ii)  Z3 has no dependencies within MA except 'PreSmalltalks' and its
        dependencies
"
depChecker := DADependencyChecker new.
visited := Set new.
packages do:[:packageName | depChecker computeDependenciesOf: packageName visitedPackages: visited ].

"i)"
unwanted := packages & (depChecker dependenciesOf: 'PreSmalltalks') \ #('PreSmalltalks-Pharo').
unwanted notEmpty ifTrue:[
	error := true.
	Transcript show: 'ERROR: Unwanted dependencies of PreSmalltalks: '; show: unwanted printString; cr.
].
"ii)"
unwanted := packages & (depChecker dependenciesOf: 'Z3')
						\ #('Z3-FFI-Pharo' 'PreSmalltalks' 'PreSmalltalks-Pharo').
unwanted notEmpty ifTrue:[
	error := true.
	Transcript show: 'ERROR: Unwanted dependencies of Z3: '; show: unwanted printString; cr.
].


"
4. Show help and exit (with proper error code)
"
error ifTrue:[
	Transcript show: '
To investigate dependencies, evaluate following in workspace:

    | repo packages cycleDetector |
    repo := IceRepository registry detect:[:each | each workingCopy packages contains: [:pkg | pkg package = ''Z3'' ] ].
    packages := repo loadedPackages collect: #package.
    (DAPackageAnalyzerPackageDependenciesWindow onPackagesNamed: packages) open.


ERROR: Some package(s) has dependency issues, see ERROR: messages above!!
'.
    Smalltalk exit: 1.
].
Smalltalk exit: 0
