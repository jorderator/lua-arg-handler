# Argument Handler

An argument handler for lua, made to provide a simple, efficient, and loosely coupled way of handling 
command line options and arguments.

## Usage

 After requiring the module, define a table for containing program options, with the names of the options
 as the keys, and strings containing the letter to be used on the command line to specify the option as the 
 values. A generic example might look something like this:

```lua
args = require('arg-handler')
-- optional file containing text to print when help is needed
help_file = "help-file.txt"

-- some code

-- create the table, with options specified like so
options = {
	help = "h",
	verbose = "v",
	quiet = "q",
	recursive = "r"
}

-- pass the lua 'arg' table in with the rest, and the return result is the table 
--  used to access settings later
options = args.process_args(arg, options, help_file)


-- optional section for printing help messages, for help options or invalid inputs
if options["help"] or options["help-text"] then
	print(options["help-text"])
	os.exit()
end


-- example use of returned table:
if options['verbose'] then print("starting program") end
```

## Planned features

 Next, I plan to overhaul the option processing system, to handle specifying values with an option,
 for example setting intervals with a `ping` command, or similar. After that, I might add support for 
 long options, such as `--recursive`, as opposed to `-r`, for example, likely using the table keys for
 the long versions, or something.
