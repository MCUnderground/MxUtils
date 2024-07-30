(
	-- If size is provided, queue is bound to that capacity/length, otherwise the queue reallocates memory for each new item. Queue can be bound to specific type.
	-- myQueue = Queue()
	-- myQueue = Queue Size:5 T:string
	struct Queue
	(
		private
		front, rear, capacity,
		items = #(),
		type,

		fn GetItemType item = classof(item) as string,
		fn GetListType item = type as string,

		fn IsQueueEmpty = front > rear,
		fn IsQueueFull = (capacity != undefined and rear == capacity),
		fn IsCorrectType item = (type == undefined or classof(item) == type),
		fn _Dequeue = 
		(
			item = items[front]

			for i = 1 to rear do items[i] = items[i + 1]

	        rear -= 1
	        item
		),

		public
		Size,
		T,
		fn Enqueue item =
		(
			if(IsCorrectType(item) == false) do throw("Expected a value of type " + GetListType(item) + " got " + GetItemType(item) + ".")
			if(IsQueueFull()) do throw("Queue Overflow")
			items[rear += 1] = item 
		),
		fn Dequeue =
		(
			if(IsQueueEmpty()) do throw("Queue is Empty")
			_Dequeue()

		),
		fn TryDequeue &item = 
		(
			result = false
			if(IsQueueEmpty() == false) do
			(
				item = _Dequeue()
				result = true
			)
			result
		),
		fn Peek = if(IsQueueEmpty()) then throw("Queue is Empty") else items[front],
		fn TryPeek &item = 
		(
			result = false
			if(IsQueueEmpty() == false) do
			(
				item = items[front]
				result = true
			)
			result
		),
		fn Display = 
		(
			if(IsQueueEmpty()) then print("Queue is Empty")
			else
			(

				outStr = ""
				for i = front to rear do
				(
					outStr += (items[i] as string + " <-- ")
				)
				print outStr
			) 
		),
		on create do 
		(
			if(Size != undefined) do
			(
				if(classof Size != integer) then throw ("Size expects type Integer.")
				if(Size < 1) then throw ("Size expects a positive Integer.")
			)
			front = 1
			rear = 0
			capacity = Size
			if(capacity != undefined) do items[capacity] = undefined
			if(T != undefined) do type = T

		)
	)
)