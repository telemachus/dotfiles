-- Add the config/nvim/lua directory to the Lua path so we can require our modules
local test_dir = debug.getinfo(1, "S").source:match("@(.*/)") or ""
package.path = test_dir .. "?.lua;"

local t = require("tapered")
local helpers = require("helpers")

-- Basic concatenation tests
local a = helpers.concat_table({ foo = 1, bar = 2 })
local b = helpers.concat_table({ baz = 3, qux = 4 })
local result = a .. b
t.same(
    result,
    { foo = 1, bar = 2, baz = 3, qux = 4 },
    "merges two non-empty tables"
)

-- Key conflicts - rightmost wins
a = helpers.concat_table({ foo = 1, bar = 2 })
b = helpers.concat_table({ bar = "overridden", baz = 3 })
result = a .. b
t.same(
    result,
    { foo = 1, bar = "overridden", baz = 3 },
    "handles key conflicts with last key winning"
)

-- Edge cases
a = helpers.concat_table()
b = helpers.concat_table({ foo = 1, bar = 2 })
result = a .. b
t.same(a, {}, "no arguments returns empty table")
t.same(result, { foo = 1, bar = 2 }, "empty table concatenation works")

a = helpers.concat_table({})
b = helpers.concat_table({ foo = 1, bar = 2 })
result = a .. b
t.same(result, { foo = 1, bar = 2 }, "handles empty first table")

a = helpers.concat_table({ foo = 1, bar = 2 })
b = helpers.concat_table({})
result = a .. b
t.same(result, { foo = 1, bar = 2 }, "handles empty second table")

a = helpers.concat_table({})
b = helpers.concat_table({})
result = a .. b
t.same(result, {}, "handles both tables empty")

-- Nil values
a = helpers.concat_table({ foo = 1, bar = nil })
b = helpers.concat_table({ bar = 2, baz = nil })
result = a .. b
t.is(result.foo, 1, "nil values: foo preserved")
t.is(result.bar, 2, "nil values: bar overridden")
t.is(result.baz, nil, "nil values: baz is nil")

-- Non-destructive behavior
a = helpers.concat_table({ foo = 1, bar = 2 })
b = helpers.concat_table({ baz = 3, qux = 4 })
local original_a = { foo = 1, bar = 2 }
local original_b = { baz = 3, qux = 4 }
result = a .. b
t.same(a, original_a, "does not modify first table")
t.same(b, original_b, "does not modify second table")

-- Chaining operations
a = helpers.concat_table({ a = 1 })
b = helpers.concat_table({ b = 2 })
local c = helpers.concat_table({ c = 3 })
result = a .. b .. c
t.same(result, { a = 1, b = 2, c = 3 }, "supports multiple concatenations")

a = helpers.concat_table({ key = "first" })
b = helpers.concat_table({ key = "second" })
c = helpers.concat_table({ key = "third" })
result = a .. b .. c
t.is(result.key, "third", "handles conflicts in chain with rightmost winning")

-- String keys work
a = helpers.concat_table({ ["string_key"] = "value1" })
b = helpers.concat_table({ ["another_string"] = "value2" })
result = a .. b
t.same(
    result,
    { string_key = "value1", another_string = "value2" },
    "works with string keys"
)

-- Error handling
a = helpers.concat_table({ foo = 1 })
t.boom(function()
    return a .. "hello"
end, {}, "throws error when concatenating with string")
t.boom(function()
    return a .. 42
end, {}, "throws error when concatenating with number")
t.boom(function()
    return a .. nil
end, {}, "throws error when concatenating with nil")

t.done()
