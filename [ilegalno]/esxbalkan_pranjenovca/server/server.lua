ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esxbalkan_pranjenovca:pranjePara')
AddEventHandler('esxbalkan_pranjenovca:pranjePara', function(amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  local tax = 0.80
  local distanca = #(GetEntityCoords(GetPlayerPed(source)) - PranjeKonfig.Zones.laundryMat.Pos)
  amount = ESX.Math.Round(tonumber(amount))
  washedCash = amount * tax
  washedTotal = ESX.Math.Round(tonumber(washedCash))

  if distanca < 30 then 
  
  if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
    xPlayer.removeAccountMoney('black_money', amount)
    TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Oprali ste " .. ESX.Math.GroupDigits(amount) .. " prljavog novca i dobili ste " .. ESX.Math.GroupDigits(washedTotal), type = "success", queue = "success", timeout = 2000, layout = "center"})
        xPlayer.addMoney(washedTotal)
        opranePare("Pranje Para", '(' .. GetPlayerName(source) .. ')' .. xPlayer.name ..  " je oprao " .. washedTotal .. "$ prljavog kesa")

  elseif amount > 20000 and xPlayer.getAccount('black_money').money >= amount then
      citizen.wait(20000)
      TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Oprali ste " .. ESX.Math.GroupDigits(amount) .. " prljavog novca i dobili ste " .. ESX.Math.GroupDigits(washedTotal), type = "success", queue = "success", timeout = 2000, layout = "center"}) 
        xPlayer.addMoney(washedTotal)  
        opranePare("Pranje Para", '(' .. GetPlayerName(source) .. ')' .. xPlayer.name ..  " je oprao " .. washedTotal .. "$ prljavog kesa")
  else
    TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Nevažeća količina!", type = "success", queue = "success", timeout = 2000, layout = "center"})
  end
else
  --opranePare('Citer', GetPlayerName(source), 'citer pranje novca')
  DropPlayer(source, 'Zasto pokusavas da citujes. Nije lepo to :) Protected by ESX-BALKAN')
end
end)

function opranePare(name, message)
  local vreme = os.date('*t')
  local poruka = {
      {
          ["color"] = 16711680,
          ["title"] = "**".. name .."**",
          ["description"] = message,
          ["footer"] = {
          ["text"] = "Logovi\nVreme: " .. vreme.hour .. ":" .. vreme.min .. ":" .. vreme.sec,
          },
      }
    }
  PerformHttpRequest("https://discord.com/api/webhooks/909155860704550964/IfXrdTiTazHmCafCNSxlpdETo1QNzTm43nE5bvhgX1i6lbEuLWGmWuAqffBiL_g5j1wV", function(err, text, headers) end, 'POST', json.encode({username = "Logovi", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end