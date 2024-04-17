# MxUtils
 Helpful utilites for maxscript packed as one package MxUtils.

 ## Packages
 	- JSON
 	- HTTP
 	- Regex
 	- Task


 ## JSON

 ```
 MxUtils.JSON.Deserialize jsonString objectName:"JSONObject"

 Params:
 	- jsonString
 	- objectName: Base name for jsonObject, or if json is an array, its base name for each element in format of  "objectName_elemet(Index)"

 Returns interperted struct, which matches given JSON
 ```

 ## HTTP
 ```
 MxUtils.HTTP.Get url

 Params:
 	- urlRequest: Url string endpoint 

 Returns HttpResponseMessage

	struct HttpResponseMessage
	(
		StatusCode,
		Headers,
		Content
	)

 ```

 ## Regex
 ```
 MxUtils.Regex.IsMatch char pattern

 Params:
 	- char: Single character
 	- pattern: Regex pattern, supported (w, d, r)

 Returns boolean

 MxUtils.Regex.IsMatch "7" ["\\w\\d"] is true
 ```

 ## Task
 ```
 MxUtils.Task.GetResult task

 Params:
 	task: dotNetObject:System.Threading.Tasks.Task

 Returns result of task
 ```

 ## Benchmark
 ```
 MxUtils.Benchmark.Run fnc args:#() optionalArgs:(Dictionary())

 Params:
 	args: takes expected params in order
 	optionalArgs: named Dictionary of optional params

 Globally available functions should be passed as string name of function
 Nested function cant be accessed if it main parent isnt global
 If you have access to function where you call benchmark also just pass its call

 	global HelloWorld
 	fn HelloWorld = print("HelloWorld")
 	fn HelloWorldTitle title = print(title + ": HelloWorld")
 	fn HelloWorldOptionalTitle title:"Program" = print(title + ": HelloWorld")

 	MxUtils.Benchmark.Run "HelloWorld"
 	MxUtils.Benchmark.Run HelloWorldTitle args:#("MyProgram")
 	MxUtils.Benchmark.Run HelloWorldOptionalTitle
 	MxUtils.Benchmark.Run HelloWorldOptionalTitle optionalArgs:(Dictionary #(#title, "MyProgram"))
 ```