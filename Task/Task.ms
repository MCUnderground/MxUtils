(
	struct Task 
	(
		fn GetResult task =
		(
			if(MatchPattern (task as string) pattern:"dotNetObject:System.Threading.Tasks.Task*") then
			(
				task.Wait()
				task.Result
			)
			else throw("Task is of type " + (classof(task) as string) + " but should be of type [dotNetObject:System.Threading.Tasks.Task]")
		) 
	)
)