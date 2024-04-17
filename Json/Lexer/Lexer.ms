(

	include "Token.ms"
	include "TokenType.ms"

	struct Lexer
	(
		private
		fn isNumber input = (classof(execute(input)) == integer),
		fn isBooleanTrue input = (toLower(input) == "true"),
		fn isBooleanFalse input = (toLower(input) == "false"),
		fn isNull input = (toLower(input) == "null"),

		public
		fn Tokenize input =
		(
			current = 1
			tokens = #()

			while(current <= input.count) do
			(
				char = input[current]

				if(char == "{") do 
				(
					append tokens (Token type:TokenType.BraceOpen value:char)
					current += 1
					continue
				)
				if(char == "}") do 
				(
					append tokens (Token type:TokenType.BraceClose value:char)
					current += 1
					continue
				)
				if(char == "[") do 
				(
					append tokens (Token type:TokenType.BracketOpen value:char)
					current += 1
					continue
				)
				if(char == "]") do 
				(
					append tokens (Token type:TokenType.BracketClose value:char)
					current += 1
					continue
				)
				if(char == ":") do 
				(
					append tokens (Token type:TokenType.Colon value:char)
					current += 1
					continue
				)
				if(char == ",") do 
				(
					append tokens (Token type:TokenType.Comma value:char)
					current += 1
					continue
				)
				if(char == "\"") do 
				(
					val = ""
					char = input[current+=1]
					while(char != "\"") do
					(
						val += char
						char = input[current+=1]
					)
					append tokens (Token type:TokenType.String value:val)
					current += 1
					continue
				)

				if(MxUtils.Regex.IsMatch char "[\\w\\d]") do
				(
					val = ""

					while(MxUtils.Regex.IsMatch char "[\\w\\d]") do
					(
						val += char
						char = input[current+=1]
					)


					if (isNumber(val)) then append tokens (Token type:TokenType.Number value:val)
					else if (isBooleanTrue(val)) then append tokens (Token type:TokenType.True value:val)
					else if (isBooleanFalse(val)) then append tokens (Token type:TokenType.False value:val)
					else if (isNull(val)) then append tokens (Token type:TokenType.Null value:val)
					else throw("Unexpected value: " + val)

					continue
				)

				if(MxUtils.Regex.IsMatch char "[\\s]") do
				(
					current += 1
					continue
				)

				throw("Unexpected character: " + char + " at position " + current as string)

			)
			tokens
		)
	)
	Lexer = Lexer()
)