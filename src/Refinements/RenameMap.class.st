"
key :: String -- variable name
value :: Association of
          Integer   -- how many times we've seen this name
       -> [Integer] -- name mappings
"
Class {
	#name : #RenameMap,
	#superclass : #Dictionary,
	#category : #Refinements
}
