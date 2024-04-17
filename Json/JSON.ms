(

	include "Lexer/Lexer.ms"
	include "Parser/Parser.ms"

	struct StructTokenType
	(
		NewLine = "\n",
		ArrayOpen = "#(",
		BracketOpening = "(",
		BracketClosing = ")",
		StructVal = "struct ",
		Comma = ","
	)
	StructTokenType = StructTokenType()

	struct JSON 
	(
		private
		fn StructStartString structName =  StructTokenType.BracketOpening + StructTokenType.StructVal + structName + StructTokenType.NewLine + StructTokenType.BracketOpening + StructTokenType.NewLine,
		fn StructEndString structName = StructTokenType.NewLine + StructTokenType.BracketClosing + StructTokenType.NewLine  + structName + StructTokenType.BracketOpening + StructTokenType.BracketClosing + StructTokenType.NewLine  + StructTokenType.BracketClosing,
		fn ParseAstToStruct node objectName =
		(
			if node.type == ASTNodeType.Object then 
			(
				structFields = #()
				for pair in node.value do
				(
					fieldName = pair.key
					fieldValue = ParseAstToStruct pair.value pair.key
					append structFields (fieldName + " = " + fieldValue as string)
				)
				structString = StructStartString(objectName)
				for i = 1 to structFields.count do 
				(
					structString +=  structFields[i]
					if(i != structFields.count) do structString += StructTokenType.Comma + StructTokenType.NewLine
				)
				structString += StructEndString(objectName)
				structString
			)
			else if node.type == ASTNodeType.Array then
			(
				arrayElements = #()
				k = 1
				for element in node.value do
				(
					arrayElement = ParseAstToStruct element (objectName + "_element" + (k as string))
					append arrayElements arrayElement
					k += 1
				)
				str = StructTokenType.ArrayOpen
				for i = 1 to arrayElements.count do
				( 
					append str arrayElements[i] 
					if(i != arrayElements.count) do str += StructTokenType.Comma + StructTokenType.NewLine
				)
				str += StructTokenType.BracketClosing
				str
			)
			else if node.type == ASTNodeType.String then
			(
				("\"" + node.value + "\"")
			)
			else if node.type == ASTNodeType.Boolean then
			(
				node.value
			)
			else if node.type == ASTNodeType.Null then
			(
				node.value
			)
			else if node.type == ASTNodeType.Number then
			(
				node.value
			)
			else
			(
				throw("Unknown node type")
			)
		),

		public
		fn Deserialize jsonString objectName:"JSONObject" = 
		(
			if(classof(jsonString) != string) do return "Input is not of type string"
			if(jsonString == "") do return "Input is empty"

			tokens = Lexer.Tokenize(jsonString)
			jsonAST = Parser.Parse(tokens)
			jsonObject = ParseAstToStruct jsonAST objectName

			return execute(jsonObject)
		),

		fn Serialize strut = 
		(
		)
	)
	JSON = JSON()
)