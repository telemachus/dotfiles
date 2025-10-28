-- Add config/nvim/lua and test directory to the Lua path.
package.path = "./config/nvim/lua/?.lua;" .. "test/?.lua;" .. package.path

local unnamed = require("unnamed")
local fivemat = require("unnamed.fivemat")
local helpers = require("helpers")

unnamed.load_tests({
    test_basic_concatenation = function(t)
        local a = helpers.concat_table({ foo = 1, bar = 2 })
        local b = helpers.concat_table({ baz = 3, qux = 4 })
        local result = a .. b
        t:deep_equal(
            result,
            { foo = 1, bar = 2, baz = 3, qux = 4 },
            "merges two non-empty tables"
        )
    end,

    test_key_conflicts = function(t)
        local a = helpers.concat_table({ foo = 1, bar = 2 })
        local b = helpers.concat_table({ bar = "overridden", baz = 3 })
        local result = a .. b
        t:deep_equal(
            result,
            { foo = 1, bar = "overridden", baz = 3 },
            "handles key conflicts with last key winning"
        )
    end,

    test_edge_cases = function(t)
        local a = helpers.concat_table()
        local b = helpers.concat_table({ foo = 1, bar = 2 })
        local result = a .. b
        t:deep_equal(a, {}, "no arguments returns empty table")
        t:deep_equal(
            result,
            { foo = 1, bar = 2 },
            "empty table concatenation works"
        )

        a = helpers.concat_table({})
        b = helpers.concat_table({ foo = 1, bar = 2 })
        result = a .. b
        t:deep_equal(result, { foo = 1, bar = 2 }, "handles empty first table")

        a = helpers.concat_table({ foo = 1, bar = 2 })
        b = helpers.concat_table({})
        result = a .. b
        t:deep_equal(result, { foo = 1, bar = 2 }, "handles empty second table")

        a = helpers.concat_table({})
        b = helpers.concat_table({})
        result = a .. b
        t:deep_equal(result, {}, "handles both tables empty")
    end,

    test_nil_values = function(t)
        local a = helpers.concat_table({ foo = 1, bar = nil })
        local b = helpers.concat_table({ bar = 2, baz = nil })
        local result = a .. b
        t:is(result.foo, 1, "nil values: foo preserved")
        t:is(result.bar, 2, "nil values: bar overridden")
        t:is(result.baz, nil, "nil values: baz is nil")
    end,

    test_concatenation_is_non_destuctive = function(t)
        local a = helpers.concat_table({ foo = 1, bar = 2 })
        local b = helpers.concat_table({ baz = 3, qux = 4 })
        local original_a = { foo = 1, bar = 2 }
        local original_b = { baz = 3, qux = 4 }
        local _ = a .. b
        t:deep_equal(a, original_a, "does not modify first table")
        t:deep_equal(b, original_b, "does not modify second table")
    end,

    test_chaining_concatenation = function(t)
        local a = helpers.concat_table({ a = 1 })
        local b = helpers.concat_table({ b = 2 })
        local c = helpers.concat_table({ c = 3 })
        local result = a .. b .. c
        t:deep_equal(
            result,
            { a = 1, b = 2, c = 3 },
            "supports multiple concatenations"
        )

        a = helpers.concat_table({ key = "first" })
        b = helpers.concat_table({ key = "second" })
        c = helpers.concat_table({ key = "third" })
        result = a .. b .. c
        t:is(
            result.key,
            "third",
            "handles conflicts in chain with rightmost winning"
        )
    end,

    test_string_keys = function(t)
        local a = helpers.concat_table({ ["string_key"] = "value1" })
        local b = helpers.concat_table({ ["another_string"] = "value2" })
        local result = a .. b
        t:deep_equal(
            result,
            { string_key = "value1", another_string = "value2" },
            "works with string keys"
        )
    end,

    test_error_handling = function(t)
        local a = helpers.concat_table({ foo = 1 })

        t:throws(function()
            return a .. "hello"
        end, "throws error when concatenating with string")

        t:throws(function()
            return a .. 42
        end, "throws error when concatenating with number")

        t:throws(function()
            return a .. nil
        end, "throws error when concatenating with nil")
    end,
})
unnamed.run(fivemat.new())
