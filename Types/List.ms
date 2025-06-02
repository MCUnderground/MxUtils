(
	struct List 
	(
		private
		arr = #(),
		type,

		fn IsNotOfType item = classof item != type,
		fn GetItemType item = classof(item) as string,
		fn GetListType item = type as string,

		public
		ZeroBasedIndex = false,
		T,

		fn Length = arr.count,

		fn Get index =
		(
			if(abs(index) < 1 or abs(index) > arr.count) do throw ("Get() Index must be within the bounds of the List.")
			if(index < 0) then arr[arr.count+1+index] else arr[index]
		),

		fn Add item = 
		(
			if(IsNotOfType(item)) do throw ("Add() Expected a value of type " + GetListType(item) + " got " + GetItemType(item) + ".")
			append arr item
		),

		fn Insert item index = 
		(
			if(IsNotOfType(item)) do throw ("Insert() Expected a value of type " + GetListType(item) + " got " + GetItemType(item) + ".")
			if(index < 1 or index > arr.count+1) do throw ("Insert() Index must be within the bounds of the List.")
			insertItem item arr index
			arr
		),

		fn Find item = 
		(
			if(IsNotOfType(item)) do throw ("Find() Expected a value of type " + GetListType(item) + " got " + GetItemType(item) + ".")
			findItem arr item
		),

		--Removes first occurrence of the specified item. setting optional all parameter as true "all:true" deletes all occurences.
		fn Remove item aLL:false = 
		(
			if(IsNotOfType(item)) do throw ("Remove() Expected a value of type " + GetListType(item) + " got " + GetItemType(item) + ".")

			itemCount = arr.count
		    if (all) then
		    (
		        for i = itemCount to 1 by -1 where arr[i] == item do deleteItem arr i
		        arr
		    )
		    else 
		    (
		        index = findItem arr item
		        if (index > 0) then deleteItem arr index
		    )
		),
		fn RemoveAt index =
		(
			if(index < 1 or index > arr.count) do throw ("RemoveAt() Index must be within the bounds of the List.")
			deleteItem arr index
		),

		fn AsArray = arr,

		on create do 
		(
			if T == undefined do throw("Type has to be specified.\nExample: List T:integer")
			type = T
		)
	)
)