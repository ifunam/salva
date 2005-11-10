# Do something only once. Called this way:
#
#  once('variable-name') { block }
#
# *variable-name* is a string. The corresponding variable is referenced
# within the block's binding using eval().
#
# If the variable doesn't exist, or if it's false or nil:
#       The block is executed.
#       The variable is set to true, within the block's binding.
#       True is returned.
#
# If the variable is true:
#
#       False is returned.
#
# Although this will by default create a simple boolean, more complex
# variables such as object.method calls, array and hash references work
# fine. I've used it effectively with 2-dimensional hashes.
#
# Copyright (C) 2005 Bruce Perens <bruce@perens.com>
# Distributable under the same license as Ruby.
def once var, &block
  begin
    result = eval(var, block.binding)
  rescue NameError
    result = false
  end
  if not result
    eval(var + " = true", block.binding)
    yield
    true
  else
    false
  end
end
