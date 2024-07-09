Extension { #name : #IceRepository }

{ #category : #'*PreSmalltalks-Pharo' }
IceRepository class >> gitDirectoryDefiningClass: aClass [
	| packageName definingRepo |
	packageName := aClass package name.
	definingRepo := self registry
		detect:[ :each | each loadedPackages contains: [ :icep | icep name = packageName ] ]
		ifNone:[ NotFound signalFor: aClass ].
	^definingRepo location "which is a FileReference"
]
