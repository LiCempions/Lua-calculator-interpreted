Values_tbl= {   -- Place here custom values (you can also use variables)
    ['e'] = 2.718281828459,
    ['pi'] = math.pi,
    ['nice'] = 69
}
Op_tbl = {  -- Place here operands
    ['+'] = function (first, second) return first + second end,
    ['-'] = function (first, second) return first - second end,
    ['*'] = function (first, second) return first * second end,
    ['/'] = function (first, second) return first / second end,
    ['**'] = function (first, second) return first ^ second end,
    ['^'] = function (first, second) return Op_tbl['**'](first, second) end,
    ['cos'] = function (first) return math.cos(first) end,
    ['sin'] = function (first) return math.sin(first) end,
    ['neg'] = function (first) return -first end,
    ['log'] = function (first, second) return math.log(second, first) end,
    ['Log'] = function (first) return math.log(first, 10) end,
    ['ln'] = function (first) return math.log(first, Values_tbl['e']) end,
    ['%'] = function (first, second) return first % second end
}
Priorities = {  -- Every double-argument operand needs his priority. Higher priorities are executed before lower ones
    ['+'] = 0,
    ['-'] = 0,
    ['*'] = 1,
    ['/'] = 1,
    ['**'] = 2,
    ['^'] = 2,
--    ['sin'] = 3,
--    ['cos'] = 3,
    ['log'] = 3,
--    ['Log'] = 3,
--    ['ln'] = 3,
--    ['neg'] = 4,  single-argument operands always have the highest priority below parenthesis
    ['%'] = 1
}