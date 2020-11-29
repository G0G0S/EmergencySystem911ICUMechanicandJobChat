ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterCommand('trabajo', function(source, args, rawCommand)
	local msg = rawCommand:sub(8)
	local job = PlayerData.job.name
    TriggerServerEvent('esx_jobChat:chat', job, msg)
end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/062', '¡Enviar un aviso a la policia con el /062!', {
    { name="Problema", help="Escribe tu problema aquí!" }
})
end)

msg = nil
RegisterCommand('062', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [062] " , {26, 83, 255},   "Se ha enviado un aviso a la policia." )
		
	msg = table.concat(args, " ")
	
	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '062'
    TriggerServerEvent('esx_jobChat:062',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
    }, msg, streetName, emergency)
end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/112', 'Enviar un aviso a los EMS con el /112!', {
    { name="Problema", help="Escribe tu problema aquí!" }
})
end)

msg = nil
RegisterCommand('112', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [112] ", {255,0,0},   "Se ha enviado un aviso a los EMS" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '112'
    TriggerServerEvent('esx_jobChat:112',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/mech', 'Enviar un aviso al mecanico con /mech!', {
    { name="Problema", help="Escribe tu problema aquí!" }
})
end)

msg = nil
RegisterCommand('mech', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [MECH] ", {230, 115, 0},   "Se ha enviado un aviso al mecanico" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(5)
	local emergency = 'mech'
    TriggerServerEvent('esx_jobChat:mech',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)

RegisterNetEvent('esx_jobChat:Send')
AddEventHandler('esx_jobChat:Send', function(messageFull, job)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == job then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
    	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CARSITE3", "CHAR_CARSITE3", true, 8, "~y~Aviso Mecanico~s~", "Localizacion enviada!");
		DrawNotification(false, true);
	end
end)

RegisterNetEvent('esx_jobChat:062EmergencySend')
AddEventHandler('esx_jobChat:062EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

RegisterNetEvent('esx_jobChat:062EmergencySend')
AddEventHandler('esx_jobChat:062EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CALL062", "CHAR_CALL062", true, 8, "~y~Aviso 062~s~", "Localizacion enviada!");
		DrawNotification(false, true);
	end
end)

RegisterNetEvent('esx_jobChat:112EmergencySend')
AddEventHandler('esx_jobChat:112EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'ambulance' then
		TriggerEvent('chat:addMessage', messageFull)
	end
end)

RegisterNetEvent('esx_jobChat:112EmergencySend')
AddEventHandler('esx_jobChat:112EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'ambulance' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CHAT_CALL", "CHAR_CHAT_CALL", true, 8, "~y~Aviso 112~s~", "Localizacion enviada!");
		DrawNotification(false, true);
	end
end)

RegisterNetEvent('esx_jobChat:062Marker')
AddEventHandler('esx_jobChat:062Marker', function(targetCoords, type)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
        local alpha = 250
        local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 0.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '062' then
			SetBlipColour (call, 38)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Ayuda policia')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_jobChat:112Marker')
AddEventHandler('esx_jobChat:112Marker', function(targetCoords, type)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'ambulance' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 0.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '112' then
			SetBlipColour (call, 1)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Ayuda medico')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_jobChat:mechMarker')
AddEventHandler('esx_jobChat:mechMarker', function(targetCoords, type)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'mechanic' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 0.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == 'mech' then
			SetBlipColour (call, 64)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Ayuda mecanico')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)