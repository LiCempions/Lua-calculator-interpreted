dofile("Calculator-v2.lua")

print("Insert the expression")
local exp = io.read() -- Demo expression to copy and paste:    5*(3 +   1)-8+3**2
local parts = TokenizeExpression(exp)
local result = EvaluateTokenized(parts)

print( result )