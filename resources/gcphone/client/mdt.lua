--====================================================================================
-- #Author: Olle Strand | Cünter#1634
-- #Version 0.1
--====================================================================================

RegisterNetEvent("gcPhone:mdt_login")
AddEventHandler("gcPhone:mdt_login", function(username, password, work, id, adminlevel)
  print("Reached client Stuff")
  SendNUIMessage({
    event = 'mdt_login',
      username = username,
      password = password,
      work = work,
      id = id,
      adminlevel = adminlevel
  })
end)

RegisterNetEvent("gcPhone:mdt_updateCitizen")
AddEventHandler("gcPhone:mdt_updateCitizen", function(firstname, lastname, dateofbirth, sex, height, identifier, license)
  print("Reached client Stuff: " .. license)
  SendNUIMessage({
    event = 'mdt_updateCitizen',
      firstname = firstname,
      lastname = lastname,
      dateofbirth = dateofbirth,
      sex = sex,
      height = height,
      identifier = identifier,
      license = license
  })
end)

RegisterNetEvent("gcPhone:mdt_updateVehicle")
AddEventHandler("gcPhone:mdt_updateVehicle", function(firstname, lastname, plate, vehicle)
  print("Reached Client Stuff")
  local hashVehicule = vehicle.model
	local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
  SendNUIMessage({
    event = 'mdt_updateVehicle',
      firstname = firstname,
      lastname = lastname,
      plate = plate,
      model = aheadVehName
  })

end)

RegisterNetEvent("gcPhone:mdt_addJob")
AddEventHandler("gcPhone:mdt_addJob", function (message, department)
  print(message)

  local pos = GetEntityCoords(PlayerPedId())
  message = message .. " | Sent from GPS Coordinates: " .. pos.x .. ", " .. pos.y

  TriggerServerEvent('gcPhone:addJobToDB', message, department, pos.x, pos.y, pos.z)

  --[[SendNUIMessage({
    event = 'mdt_addJob',
      message = message,
      department = department,
      isAssigned = false,
      coordX = pos.x,
      coordY = pos.y,
      coordZ = pos.z,
  })]]
end)

--====================================================================================
-- #NUI Callbacks
--====================================================================================

RegisterNUICallback('mdt_loginRequest', function(data, cb)
  TriggerServerEvent('gcPhone:mdt_loginRequest', data.username, data.password)
end)

RegisterNUICallback('mdt_citizenRequest', function(data, cb)
  TriggerServerEvent('gcPhone:mdt_citizenRequest', data.firstname, data.lastname)
end)

RegisterNUICallback('mdt_vehicleRequest', function(data, cb)
  TriggerServerEvent('gcPhone:mdt_vehicleRequest', data.plate)
end)
