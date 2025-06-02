(
	global MxUtils
	struct MxUtils
	(
		private
		version = 1.0,
		localPath = pathConfig.removePathLeaf(getThisScriptFilename()) + @"\",

		public
		JSON  = filein(localPath + @"Json\JSON.ms"),
		HTTP  = filein(localPath + @"Http\HTTP.ms"),
		Regex = filein(localPath + @"Regex\Regex.ms"),
		Task  = filein(localPath + @"Task\Task.ms"),
		Benchmark  = filein(localPath + @"Benchmark\Benchmark.ms"),
		Types = filein(localPath + @"Types\Types.ms"),

		on create do 
		(
			format "[MxUtils v%] initialized.\n" version
		)
	)
	MxUtils = MxUtils()
	silentValue 
)