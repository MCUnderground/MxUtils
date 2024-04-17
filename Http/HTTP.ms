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
			response
			dotNet.loadAssembly "System.Net.Http"
			httpClient = (dotNetObject "System.Net.Http.HttpClient")
			(dotNetClass "System.Net.ServicePointManager").SecurityProtocol = (dotNetClass "System.Net.SecurityProtocolType").Tls12
			response = httpClient.GetAsync(urlRequest)

			Task = MxUtils.Task
			result = Task.GetResult(response)

			statusCode = response.Result.StatusCode.ToString()
			headers = result.Headers.ToString()
			content = Task.GetResult(result.Content.ReadAsStringAsync())

			result = HttpResponseMessage StatusCode:statusCode Headers:headers Content:content
			return result
		)
	)
)