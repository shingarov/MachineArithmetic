Extension { #name : #TonelWriter }

{ #category : #'*PreSmalltalks-Pharo' }
TonelWriter >> writePackage: aDefinition [

	packageDir := self obtainPackageDir: aDefinition.
	"this is lame... removing and rewriting full package needs to be rethink :)"
	(self fileUtils directoryExists: self packageDir) ifTrue: [
		"No, it is not only lame, it is dangerous and utterly stupid.
		 Repeat after me: I'll not mess up with files I do not know!.
		 Hundred times!"
		| dir |
		
		dir := self packageDir.
		dir allChildren do:[:file |
			file isRegular" file" ifTrue:[
				((file pathString endsWith: '.class.st') 
				or:[file pathString endsWith:'.extension.st']) ifTrue:[
					"Okay, this file looks like Smalltalk source, remove it.
					 (it will be recreated later)"
					file delete.
				].
			]
		].	
	].
	self fileUtils ensureDirectoryExists: self packageDir.
	self fileUtils 
		writeStreamFor: 'package.st' 
		in: self packageDir 
		do: [ :s | 
			s 
				<< 'Package ' 
				<< (self toSTON: { #name ->  packageDir asSymbol } asDictionary) 
				<< self newLine ] 
]
