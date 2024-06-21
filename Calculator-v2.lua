dofile("Tables.lua")

function IsAlpha(char)
    --[[if type(char)~="string" then
        return false
    end]]

    return (char>='A' and char<='Z') or (char>='a' and char<='z')
end
function IsNum(char)
    --[[if type(char)~="string" then
        return false
    end]]

    return (char>='0' and char<='9') or char=='.'
end
function GetType(char)
    if IsNum(char) then                 return 0 --0s are cast to numbers
    elseif IsAlpha(char) then           return 1
    elseif char=='(' or char==')' then  return 3
    elseif char==' ' then               return 4 --4s are separation characters to be ignored
    else                                return 2
    end
end
function Concatenate(first, second)
    if first then
        return first..second
    else
        return second
    end
end

function NextPartCheck(current, currentType, currentChar, parts)
    if currentType ~= GetType(currentChar) then

        if currentType==0 then
            table.insert(parts, tonumber(current))
        elseif currentType~=4 then
            table.insert(parts, current)
        end

        current = nil
        currentType = GetType(currentChar)
    end

    return current, currentType
end

function GetPart_num(parts, i)
    local j = i
    local num = nil
    
    if parts[i]=='(' then
        return EvaluateTokenized(parts, i+1)
    end

    if type(parts[i])=="number" then
        return parts[i], i+1
    else
        if Values_tbl[parts[i]] then
            return Values_tbl[parts[i]], i+1
        elseif Op_tbl[parts[i]] then
            num, i = GetPart_num(parts, i+1)
            return Op_tbl[parts[j]](num), i
        else
            assert(false, parts[i].." doesn't exist among the values!")
        end
    end
end
function GetPart_op(parts, i)
    if parts[i]==')' then
        return nil, i+1
    elseif (type(parts[i])=="number" or not Op_tbl[parts[i]]) and parts[i]~=nil then
        return '*', i
    else
        return parts[i], i+1
    end
end
function Calculate(first, second, op, nextOp, parts, i)
    local third = nil
    local thirdOp = nil

    if nextOp then
        while Priorities[nextOp]>Priorities[op] do
            third, i = GetPart_num(parts, i)
            thirdOp, i = GetPart_op(parts, i)

            second, i, nextOp = Calculate(second, third, nextOp, thirdOp, parts, i)
            if not nextOp then break end
        end
    end

    return Op_tbl[op](first, second), i, nextOp
end

function TokenizeExpression(exp)
    local parts = {}
    local i = 1
    local strLen = string.len(exp)


    local current = nil
    local currentChar = string.sub(exp, i, i)
    local currentType = GetType(currentChar)

    while i<=strLen do
        current = Concatenate(current, currentChar)

        i = i+1
        currentChar = string.sub(exp, i, i)

        current, currentType = NextPartCheck(current, currentType, currentChar, parts)
    end

    return parts
end

function EvaluateTokenized(parts, i)
    i = i or 1
    local result = 0
    local second = 0
    local op = nil
    local nextOp = nil

    result, i = GetPart_num(parts, i)
    op, i = GetPart_op(parts, i)

    while op~=nil do
        second, i = GetPart_num(parts, i)
        nextOp, i = GetPart_op(parts, i)

        result, i, nextOp = Calculate(result, second, op, nextOp, parts, i)

        op = nextOp
    end

    return result, i
end