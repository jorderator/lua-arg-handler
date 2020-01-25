-- 'arguments' is the lua 'args' table, and 'options' is the table that is supplied by, and returned to,
--  the upstream program, containing the options and their values
arguments = {}
options = {}
help_text = ""

function process_args(arguments_input, options_input, help_file)
	-- Make the inputs global
	arguments = arguments_input
	options = options_input

	arg_count = 0
	for i, value in ipairs(arguments) do
		if value:sub(1,1) == "-" then 
			if #value > 2 then
				value = value:sub(2)
				for i=1, #value do
					handle_arg(value:sub(i,i))
				end
			else
				handle_arg(value:sub(2))
			end
		else
			arg_count = arg_count + 1
			options[arg_count] = value
		end
	end

	for k, v in pairs(options) do
		if type(k) == "string" and v ~= true then options[k] = false end
	end

	if (options["help"] or help_text ~= "") and help_file then
		local file = io.open(help_file)
		help_text = (help_text ~= "" and (help_text .. "\n") or "") .. file:read("*a")
		file:close()
	end

	if help_text ~= "" then options["help-text"] = help_text end

	return options
end

function handle_arg(argument)
	for k, option in pairs(options) do
		if argument == option then
			options[k] = true
			return
		end
	end

	if help_text == "" then help_text = "Unkown option(s): "
	else help_text = help_text .. ", "
	end
	help_text = help_text .. argument
end
