(
	filein(pathConfig.removePathLeaf(getThisScriptFilename()) + @"\MxUtils.ms")

	url = "https://jsonplaceholder.typicode.com/users/2"

	MxUtils.Benchmark.Run "MxUtils.HTTP.Get" args:#(url)

	testJson = MxUtils.HTTP.Get url
	if(testJson.StatusCode == "OK") do 
	(
		result = MxUtils.JSON.Deserialize(testJson.Content)
		print(result.Address.Geo)
	)

	a = MxUtils.Types.Queue Size:2 T:string
	a.Enqueue("sad")
	a.Enqueue("lol")
	a.Display()
)