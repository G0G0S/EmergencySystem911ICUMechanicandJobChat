TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

RegisterServerEvent('esx_jobChat:chat')
AddEventHandler('esx_jobChat:chat', function(job, msg)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = xPlayer.getName(source)
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 8px; margin: 8px; background-color: rgba(77, 0, 153); border-radius: 25px;"><i class="far fa-building"style="font-size:15px"></i> [{0}] {1} : {2}</font></i></b></div>',
        args = {jobName, fal , msg,}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

RegisterServerEvent('esx_jobChat:112')
AddEventHandler('esx_jobChat:112', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = xPlayer.getName(source)
	local messageFull
	if emergency == '112' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(255, 51, 51); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [112]: {0} | Ubicacion : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg, ped}
		}
	end
	TriggerClientEvent('esx_jobChat:112Marker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:112EmergencySend', -1, messageFull)
end)

RegisterServerEvent('esx_jobChat:062')
AddEventHandler('esx_jobChat:062', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = xPlayer.getName(source)
	local messageFull
	if emergency == '062' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(0, 38, 153); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [062] : {0} | Ubicacion : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:062Marker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:062EmergencySend', -1, messageFull)
end)

RegisterServerEvent('esx_jobChat:mech')
AddEventHandler('esx_jobChat:mech', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = xPlayer.getName(source)
	local messageFull
	if emergency == 'mech' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(128, 64, 0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [MECH] : {0} | Ubicacion : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:mechMarker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:mechEmergencySend', -1, messageFull)
end)