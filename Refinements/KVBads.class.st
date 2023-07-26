"
type KvBads    = M.HashMap F.KVar [F.Symbol]
"
Class {
	#name : #KVBads,
	#superclass : #SEnv,
	#category : #Refinements
}

{ #category : #sanitizing }
KVBads >> dropBadParams: k _: kEnv [
"
dropBadParams :: KvBads -> F.KVar -> F.SEnv F.BindId -> F.SEnv F.BindId
                  self      k           kEnv
"
	| xs |
	xs := self at: k ifAbsent: [ Set new ].
	^xs inject: kEnv into: [ :soFar :thisBad | soFar deleteSEnv: thisBad ]
]
