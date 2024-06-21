# Interpreted Lua calculator
A calculator written in Lua. Takes a mathematical expression in the form of a string as an input and returns the result.

As shown in the Demo.lua file, save the expression in a string and pass it to TokenizeExpression().
Pass the result of the latter to EvaluateTokenized(). It will return the result followed by another variable, used during execution.
To dispose of it, call the function in a variable assignment:
```
local parts = TokenizeExpression(expression)
local result = EvaluateTokenized(parts)
```
In this exaple, "result" will contain the result.