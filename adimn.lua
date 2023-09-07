local adminPlayers = {
    "Player1", -- Replace with the username of the first admin
    "Player2", -- Replace with the username of the second admin
    -- You can add more admins by following the same pattern
}

local function isAdmin(player)
    for _, admin in ipairs(adminPlayers) do
        if player.Name == admin then
            return true
        end
    end
    return false
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        if isAdmin(player) then
            local command = string.lower(message)
            local args = {}
            for arg in string.gmatch(command, "%S+") do
                table.insert(args, arg)
            end

            if args[1] == "!kick" then
                local targetPlayer = game.Players:FindFirstChild(args[2])
                if targetPlayer then
                    targetPlayer:Kick("Kicked by admin")
                end
            elseif args[1] == "!ban" then
                local targetPlayer = game.Players:FindFirstChild(args[2])
                if targetPlayer then
                    targetPlayer:Kick("Banned by admin")
                    -- You can add code here to save the banned player's data, such as their user ID or IP address, for future reference
                end
            elseif args[1] == "!shutdown" then
                game:Shutdown()
            elseif args[1] == "!tp" then
                local targetPlayer = game.Players:FindFirstChild(args[2])
                local targetPos = args[3] and tonumber(args[3])
                if targetPlayer and targetPos then
                    targetPlayer.Character:MoveTo(targetPos)
                end
            elseif args[1] == "!kill" then
                local targetPlayer = game.Players:FindFirstChild(args[2])
                if targetPlayer then
                    targetPlayer.Character:BreakJoints()
                end
            elseif args[1] == "!giveitem" then
                local targetPlayer = game.Players:FindFirstChild(args[2])
                local itemId = args[3] and tonumber(args[3])
                if targetPlayer and itemId then
                    local newItem = Instance.new("Tool")
                    newItem.Name = "AdminItem"
                    newItem.Parent = targetPlayer.Backpack
                    newItem.GripPos = Vector3.new(0, 0, -10)
                    newItem.ToolTip = "Admin Item"
                    newItem.TextureId = "rbxassetid://" .. itemId
                end
            end
        end
    end)
end)
