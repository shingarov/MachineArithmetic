| repo |

'LibZ3-generated.st' asFileReference fileIn.

repo := TonelRepository new directory:'..' asFileReference.
{ Z3 . LibZ3 } do: [:class |
 		| mcpkg mcwc mcversion |

 		mcpkg := MCPackage named: class package name.
 		mcwc := mcpkg workingCopy.
 		[
 			mcversion := mcwc newVersionIn: repo.
 		] on:MCVersionNameAndMessageRequest do:[:ex |
 			ex resume:(Array with:'automated update' with:'automated update')
 		].
 		repo storeVersion:mcversion.
].
Smalltalk exit: 0