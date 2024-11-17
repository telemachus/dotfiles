---Seek root directory starting from |current-directory| of current buffer.
---@param targets table
local seek = function(targets)
    local root = vim.fs.root(0, targets)
    if root then
        local exit_status = vim.uv.chdir(root)
        if exit_status == 0 then
            vim.notify(root, vim.log.levels.INFO)
        end
    end
end

return {
    seek = seek,
}
