(
	struct Regex 
	(
		private
		internal_letter_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_",
		internal_digit_chars = "0123456789",
		fn inString str char = (findString str char != undefined),

		fn isWordChar char = 
		(
			wordChars = internal_letter_chars
		    inString wordChars char
		),
		fn isDigitChar char =
		(
		    digitChars = internal_digit_chars
		    inString digitChars char
		),

		public
	    fn IsMatch char pattern =
	    (
	    	if(char == undefined) do throw("Char parameter can not be undefined")

	    	if(char.count > 1) do throw("Char parameter can be single character")

	    	result = false

	        -- Check if the pattern contains "\d" (digit) or "\w" (word character)
	        if (inString pattern "\\d") then
	        (
	            -- Check if the character is a digit
	            if(isDigitChar(char) == true) do result = true
	        )
	        if (inString pattern "\\w") then
	        (
	            -- Check if the character is a word character
	            if(isWordChar(char) == true) do result = true
	        )
	        if (inString pattern "\\s") then
	        (
	            -- Check if the character is a whitespace character
	            if(isSpace(char) == true) do result = true
	        )
	        result
	    )
	)
	Regex = Regex()
)