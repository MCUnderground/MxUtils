(
	struct Benchmark
	(

		fn Run fnc args:#() optionalArgs:(Dictionary()) =
		(
			if(classof(args) != Array) do throw("Benchmark: Args parameter should be of type Array")
			if(classof(optionalArgs) != Dictionary) do throw("Benchmark: OptionalArgs parameter should be of type Dictionary")
			
			execStr = ""
			if(classof fnc == string) then
			(
				append execStr fnc
			)
			else
			(
				fncString = fnc as string
				append execStr (subString fncString 1 (fncString.count-2))
			)
			
			if(args.count == 0 and optionalArgs.count == 0) then (append execStr "()") 
			else 
			(
				for arg in args do
				(
					append execStr " "
					if(classof(arg) == string) do append execStr "\""
					append execStr (arg as string)
					if(classof(arg) == string) do append execStr "\""
				)
				for arg in optionalArgs do
				(
					append execStr " "
					append execStr (arg.key as string + ":")
					if(classof(arg.value) == string) do append execStr "\""
					append execStr (arg.value as string)
					if(classof(arg.value) == string) do append execStr "\""
				)
			)

			execStr = substituteString execStr "\n" ""

			time1 = timeStamp()
			execute(execStr)
			time2 = timeStamp()
			
			timeFinal = ((time2 - time1) / 1000.0) as string
			
			print(fnc as string + " took " + timeFinal  + " seconds")
		)
	)
)