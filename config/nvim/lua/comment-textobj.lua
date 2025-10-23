-- Comment text object: the `ic` version selects comment text but not comment
-- marker, and `ac` selects comment text and comment marker.
--
-- (Comments with start and end markers are not supported.)
local bo = vim.bo
local trim = vim.trim
local get_current_line = vim.api.nvim_get_current_line
local pattern_escape = vim.pesc
local win_get_cursor = vim.api.nvim_win_get_cursor
local line_count = vim.api.nvim_buf_line_count
local get_lines = vim.api.nvim_buf_get_lines
local set_mark = vim.api.nvim_buf_set_mark
local win_set_cursor = vim.api.nvim_win_set_cursor

local function get_comment_marker()
    local cs = bo.commentstring
    if cs == "" then
        return nil
    end

    local parts = vim.split(cs, "%s", { plain = true })
    if #parts ~= 2 then
        return nil
    end

    local start_marker = trim(parts[1])
    local end_marker = trim(parts[2])

    return (end_marker == "") and start_marker or nil
end

local function is_in_comment(marker)
    if not marker then
        return false
    end

    local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
    if ok then
        local node = ts_utils.get_node_at_cursor()
        if node then
            local current = node
            while current do
                if current:type():match("comment") then
                    return true
                end
                current = current:parent()
            end
        end
    end

    local line = get_current_line()
    local trimmed = trim(line)
    return trimmed:sub(1, #marker) == marker
end

local function find_comment_boundaries(marker)
    local marker_pattern = "^%s*" .. pattern_escape(marker)

    local cursor_row = win_get_cursor(0)[1]
    local total_lines = line_count(0)

    local start_row = cursor_row
    while start_row > 1 do
        local prev_line = get_lines(0, start_row - 2, start_row - 1, false)[1]
            or ""
        if not prev_line:match(marker_pattern) then
            break
        end
        start_row = start_row - 1
    end

    local end_row = cursor_row
    while end_row < total_lines do
        local next_line = get_lines(0, end_row, end_row + 1, false)[1] or ""
        if not next_line:match(marker_pattern) then
            break
        end
        end_row = end_row + 1
    end

    return start_row, end_row
end

local function get_comment_selection(marker, include_markers)
    local start_row, end_row = find_comment_boundaries(marker)

    local first_line = get_lines(0, start_row - 1, start_row, false)[1] or ""
    local last_line = get_lines(0, end_row - 1, end_row, false)[1] or ""

    local marker_pos = first_line:find(marker, 1, true)
    if not marker_pos then
        return nil
    end

    local start_col
    if include_markers then
        -- Include marker for `ac`.
        start_col = marker_pos - 1 -- 0-indexed
    else
        -- Do not include marker for `ic`.
        start_col = marker_pos + #marker - 1 -- 0-indexed
        -- Skip whitespace after marker.
        while
            start_col < #first_line
            and first_line:sub(start_col + 1, start_col + 1):match("%s")
        do
            start_col = start_col + 1
        end
    end

    return start_row - 1, start_col, end_row - 1, #last_line - 1
end

local inner_comment = function()
    local marker = get_comment_marker()
    if not marker or not is_in_comment(marker) then
        return "<Ignore>"
    end

    local bounds = { get_comment_selection(marker, false) }
    if #bounds < 4 then
        return "<Ignore>"
    end

    local start_row, start_col, end_row, end_col = unpack(bounds)

    set_mark(0, "<", start_row + 1, start_col, {})
    set_mark(0, ">", end_row + 1, end_col, {})

    win_set_cursor(0, { start_row + 1, start_col })
    return "gv"
end

local around_comment = function()
    local marker = get_comment_marker()
    if not marker or not is_in_comment(marker) then
        return "<Ignore>"
    end

    local bounds = { get_comment_selection(marker, true) }
    if #bounds < 4 then
        return "<Ignore>"
    end

    local start_row, start_col, end_row, end_col =
        bounds[1], bounds[2], bounds[3], bounds[4]

    set_mark(0, "<", start_row + 1, start_col, {})
    set_mark(0, ">", end_row + 1, end_col, {})

    win_set_cursor(0, { start_row + 1, start_col })
    return "gv"
end

return {
    inner_comment = inner_comment,
    around_comment = around_comment,
}
