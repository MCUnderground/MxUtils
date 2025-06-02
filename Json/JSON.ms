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

		fn Serialize obj = 
		(
			if isKindOf obj StructDef then
			(
				throw ("Cannot serialize definition: ")
			)
			else if isStruct obj or isValidObj obj then
			(
				json = "{"

				typeName = try (classof obj as string) catch ("Unknown")

				json += "\"__type\": \"" + typeName + "\", "

				props = getPropNames obj
				for i = 1 to props.count do
				(
					propName = props[i]
					propValue = getProperty obj propName
					json += "\"" + propName as string + "\": " + Serialize propValue
					if i != props.count do json += ", "
				)
				json += "}"
				json
			)
			else if isKindOf obj Array then
			(
				json = "["
				for i = 1 to obj.count do
				(
					json += Serialize obj[i]
					if i != obj.count do json += ", "
				)
				json += "]"
				json
			)
			else if isKindOf obj String then
			(
				"\"" + obj + "\"" 
			)
			else if isKindOf obj BooleanClass  then
			(
				if obj then "true" else "false"
			)
			else if obj == undefined then
			(
				"null"
			)
			else if isKindOf obj Number then
			(
				obj as string
			)
			else if isKindOf obj Point2 then
			(
				"[" + obj.x as string + ", " + obj.y as string + "]"
			)
			else if isKindOf obj Point3 then
			(
				"[" + obj.x as string + ", " + obj.y as string + ", " + obj.z as string + "]"
			)
			else if isKindOf obj Color then
			(
				"[" + obj.r as string + ", " + obj.g as string + ", " + obj.b as string + "]"
			)
			else if isKindOf obj Point4 then
			(
				"[" + obj.x as string + ", " + obj.y as string + ", " + obj.z as string + ", " + obj.w as string + "]"
			)
			else if isKindOf obj Box2 then
			(
				"{\"min\": " + Serialize obj.min + ", \"max\": " + Serialize obj.max + "}"
			)
			else if isKindOf obj Box3 then
			(
				"{\"min\": " + Serialize obj.min + ", \"max\": " + Serialize obj.max + "}"
			)
			else if isKindOf obj Matrix3 then
			(
				"{\"row1\": " + Serialize obj.row1 + ", \"row2\": " + Serialize obj.row2 + ", \"row3\": " + Serialize obj.row3 + ", \"pos\": " + Serialize obj.row4 + "}"
			)
			else
			(
				throw ("Cannot serialize type: " + classof obj as string)
			)
		)

	)
	JSON = JSON()
)