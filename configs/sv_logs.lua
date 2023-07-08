webhooks = {
    ['drop'] = '',
    ['pickup'] = '',
    ['give'] = '',
    ['stash'] = '',
} hooks = {
    ['drop'] = {
        from = 'player',
        to = 'drop',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('drop', {
                {
                    title = 'Drop',
                    description = (
                        '**[Name]:** **%s** **[ID]:** %s, ||**%s**|| **Dropped** %s **%s** (metadata: %s) on the coordinates:`` %s.``')
                        :format(
                            playerName,
                            payload.source,
                            playerIdentifier,
                            payload.fromSlot.count,
                            payload.fromSlot.name,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['pickup'] = {
        from = 'drop',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('pickup', {
                {
                    title = 'Pickup',
                    description = (
                        '**[Name]:** **%s** **[ID]:** %s, ||**%s**|| **Picked Up** %s **%s** (metadata: %s) on the coordinates:`` %s.``')
                        :format(
                            playerName,
                            payload.source,
                            playerIdentifier,
                            payload.fromSlot.count,
                            payload.fromSlot.name,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['give'] = {
        from = 'player',
        to = 'player',
        callback = function(payload)
            if payload.fromInventory == payload.toInventory then return end
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            local targetSource = payload.toInventory
            local targetName = GetPlayerName(targetSource)
            local targetIdentifier = GetPlayerIdentifiers(targetSource)[1]
            local targetCoords = GetEntityCoords(GetPlayerPed(targetSource))
            sendWebhook('give', {
                {
                    title = 'Transfer of items between players',
                    description = ('**[Name]:** **%s** **ID [%s] **|| **%s**||   **GAVE**  ** PLAYER: **%s** **[%s] %s %s ||%s|| metadata:|| %s||) at ||%s||')
                     :format(
                            playerName,
                            payload.source,
                            playerIdentifier,
                            targetName,
                            targetSource,
                            payload.fromSlot.count,
                            payload.fromSlot.name,
                            targetIdentifier,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                         ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['stash_pick'] = {
        from = 'player',
        to = 'stash',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'Stash',
                    description = ('**[Name]:** **%s** (%s, %s) **stashed** item **%s** x%s (metadata: %s) **in stash %s** at %s coordinates.')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.toInventory,
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['stash'] = {
        from = 'stash',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'Stash',
                    description = ('**[Name]:** **%s** (%s, %s) **Removed** item **%s** x%s (metadata: %s) **From stash %s** at %s coordinates.')
                    :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.fromInventory,
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
}
