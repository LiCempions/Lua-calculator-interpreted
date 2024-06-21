dofile("Calculator-v2.lua")

print("Inserisci l'espressione")
local exp = io.read() --[[5*(3 +   1)-8+3**2]]
local parts = TokenizeExpression(exp)

print( table.pack( EvaluateTokenized(parts) )[1] )