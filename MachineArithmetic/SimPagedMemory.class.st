"
bound methods:
_SimPagedMemory__changed_bytes
__contains__
__delitem__

valued attributes:
_check_perms
_cowed {524271}
_executable_pages (false)
_initialized {524271}
_memory_backer (Clemory)
_name_mapping (cooldict.BranchingDict)
_permissions_backer (Array, 1->false, 2-> dict from addr ranges to 3bit-masks )
_permission_map ( dict from addr ranges to 3bit-masks )
_page_size (4096)
_pages ( dict n->ListPage )
state
byte_width (8)
allow_segv (false)
_updated_mappings (set())
_symbolic_addrs (dict: 524271->set()
_preapproved_stack (an angr.misc.range.IRange)


#('_hash_mapping' ''  '__init__' '_page_align_down' '_page_align_up' '_is_page_aligned' '_num_pages' '_page_id' '_page_addr' '_page_base_addrs' '__getstate__' '__setstate__' 'branch' '__getitem__' '__setitem__' '' '' '' 'load_objects' '_create_page' '_initialize_page' '_get_page' '' 'contains_no_backer' 'keys' '__len__' 'changed_bytes' '' '_apply_object_to_page' '_containing_pages' '_containing_pages_mo' 'store_memory_object' 'replace_memory_object' 'replace_all' '_mark_updated_mapping' '_update_range_mappings' '_update_mappings' 'get_symbolic_addrs' 'addrs_for_name' 'addrs_for_hash' 'memory_objects_for_name' 'memory_objects_for_hash' 'permissions' 'map_region' 'unmap_region' 'flush_pages' '__dict__' '__weakref__' '__repr__' '__hash__' '__str__' '__getattribute__' '__setattr__' '__delattr__' '__lt__' '__le__' '__eq__' '__ne__' '__gt__' '__ge__' '__new__' '__reduce_ex__' '__reduce__' '__subclasshook__' '__init_subclass__' '__format__' '__sizeof__' )
"
Class {
	#name : #SimPagedMemory,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
SimPagedMemory class >> pythonClassName [ 
	^'SimPagedMemory'
]

{ #category : #'instance creation' }
SimPagedMemory class >> with: aPage state: aSimState [
	^self withAll: (Array with: aPage) state: aSimState 
]

{ #category : #'instance creation' }
SimPagedMemory class >> withAll: anArrayOfPages state: aSimState [
	| namedArgs result |
	namedArgs := Dictionary new.
	anArrayOfPages isNil ifFalse: [
		| pagesDictionary |
		pagesDictionary := Dictionary new.
		anArrayOfPages doWithIndex: [ :page :index |
			pagesDictionary at: index - 1 put: page ].
		namedArgs at: 'pages' put: pagesDictionary ].
	result := GenericPyObject
		create: 'angr.storage.paged_memory.SimPagedMemory'
		constructorNamedArgs: namedArgs.
	aSimState isNil ifFalse: [ result at: 'state' put: aSimState ].
	^result

]
