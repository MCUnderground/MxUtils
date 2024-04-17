(
	global MxUtils
	struct MxUtils
	(
		private
		localPath = pathConfig.removePathLeaf(getThisScriptFilename()) + @"\",

		public
		JSON  = filein(localPath + @"Json\JSON.ms"),
		HTTP  = filein(localPath + @"Http\HTTP.ms"),
		Regex = filein(localPath + @"Regex\Regex.ms"),
		Task  = filein(localPath + @"Task\Task.ms"),
		Benchmark  = filein(localPath + @"Benchmark\Benchmark.ms")
	)
	MxUtils = MxUtils()
)