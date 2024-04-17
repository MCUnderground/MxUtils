(
	include "ASTNode.ms"
	include "ASTNodeType.ms"

	struct Parser 
	(
		private
		tokens,
		current = 1,
		fn Advance = tokens[current+=1],

		fn ParseArray = 
		(
			node = ASTNode type:ASTNodeType.Array value:#()
			tkn = Advance()

			while(tkn.type != TokenType.BracketClose) do
			(
				value = this.parseValue()
				append (node.value) value

				tkn = Advance()
				if(tkn.type == TokenType.Comma) do tkn = Advance()
			)
			node
		),

		fn ParseObject =
		(
			node = ASTNode type:ASTNodeType.Object value:(Dictionary(#string))
			tkn = Advance()
			while(tkn.type != TokenType.BraceClose) do
			(
				if(tkn.type == TokenType.String) then
				(
					key = tkn.value
					tkn = Advance()
					if(tkn.type != TokenType.Colon) do throw("Expected : in key-value pair")
					tkn = Advance()
					value = this.parseValue()
					node.value[key] = value
				)
				else throw("Expected String key in object. Token type: " + tkn.type)
				tkn = Advance()
				if(tkn.type == TokenType.Comma) do tkn = Advance()
			)
			node
		),

		fn ParseValue = 
		(
			value = undefined
			tkn = tokens[current]
			if(tkn.type == TokenType.String) then (ASTNode type:(ASTNodeType.String) value:(tkn.value))
			else if(tkn.type == TokenType.Number) then  ASTNode type:ASTNodeType.Number value:tkn.value
			else if(tkn.type == TokenType.True) then ASTNode type:ASTNodeType.Boolean value:true
			else if(tkn.type == TokenType.False) then ASTNode type:ASTNodeType.Boolean value:false
			else if(tkn.type == TokenType.Null) then ASTNode type:ASTNodeType.Null value:undefined
			else if(tkn.type == TokenType.BraceOpen) then ParseObject()
			else if(tkn.type == TokenType.BracketOpen) then ParseArray()
			else throw("Unexpected token type: " + tkn.type)
		),

		public
		fn Parse tkns = 
		(
			tokens = tkns
			AST =  ParseValue()

			tokens = undefined
			current = 1

			AST
		)
	)
	Parser = Parser()
)