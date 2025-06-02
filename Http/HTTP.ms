(
	struct HttpResponseMessage
	(
		StatusCode,
		Headers,
		Content
	)

	struct HTTP 
	(
		fn Get urlRequest =
		(
			try
			(
				dotNet.loadAssembly "System.Net.Http"
				httpClient = dotNetObject "System.Net.Http.HttpClient"
				(dotNetClass "System.Net.ServicePointManager").SecurityProtocol = (dotNetClass "System.Net.SecurityProtocolType").Tls12
				
				responseTask = httpClient.GetAsync urlRequest
				Task = MxUtils.Task
				result = Task.GetResult responseTask

				statusCode = responseTask.Result.StatusCode.ToString()
				headers = result.Headers.ToString()
				content = Task.GetResult(result.Content.ReadAsStringAsync())

				result = HttpResponseMessage StatusCode:statusCode Headers:headers Content:content
				return result
			)
			catch
			(
				errorMessage = (FilterString (getCurrentException()) ":")[3]
				
				format "\n[MxUtils.HTTP ERROR]\n"
				format "  → Url: %\n" urlRequest
				format "  → Message: %\n" errorMessage
			)
		)
	)

)