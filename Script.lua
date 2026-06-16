l--[[
    ================================================================
    [ SCRIPT INFORMATION ]
    Project: Custom Script
    Author: OYB
    YouTube: https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ
    
    [ TERMS AND CONDITIONS ]
    - You ARE allowed to use and modify this script for your own games.
    - You ARE NOT allowed to re-upload, redistribute, or claim 
      ownership of this script.
    - Removing or altering these credits is strictly prohibited.
    
    Copyright (c) 2026 OYB. All rights reserved.
    ================================================================
]]

-- âš ï¸ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) âš ï¸

local ProtectionConfig = {
    -- ðŸ”´ CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "FuckYouBitch",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "Chaos HUB"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\nðŸ›¡ï¸ Unauthorized Execution ðŸ›¡ï¸\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- ðŸ‘‡ YOUR MAIN SCRIPT CODE STARTS HERE ðŸ‘‡
-------------------------------------------------------------------------------

print(ProtectionConfig.HubName .. " Loaded Successfully!")
-- LocalScript - Pruebas de Anticheat con Interfaz Rayfield
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local miPlayer = Players.LocalPlayer
local FRECUENCIA_CONEXION = RunService.Heartbeat

-- Coordenadas de porterías
local COORDENADAS_AWAY = Vector3.new(86, -5, -370)
local COORDENADAS_HOME = Vector3.new(86, -4, -98)
local DISTANCIA_POSESION_SEGURO = 4

-- Variables de estado
local modoAuditoriaActivo = false
local modificarHitboxActivo = false
local tamanoHitboxPersonalizado = 5
local transparenciaHitboxPersonalizada = 0.5
local tamanoOriginalBalon = Vector3.new(2, 2, 2)

-- 1. CARGA DE LA INTERFAZ
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Chaos Hub",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "Soccer Simulator",
   Theme = "Default",
   ConfigurationSaving = { Enabled = false }
})

local TabAutomatizacion = Window:CreateTab("Automation", nil)
local TabVisuales = Window:CreateTab("Hitbox Settings", nil)

-- Advertencia
TabAutomatizacion:CreateSection("System Warnings")
TabAutomatizacion:CreateLabel("⚠️ WARNING: The 'autofarm' function is currently")
TabAutomatizacion:CreateLabel("bugged. Spam the kick button when you're in the goal, it will be fixed soon.")

-- 2. FUNCIONES LÓGICAS
local function obtenerCoordenadaObjetivo()
    local equipo = miPlayer.Team
    if equipo and string.find(string.lower(equipo.Name), "home") then return COORDENADAS_HOME end
    return COORDENADAS_AWAY
end

-- BUCLE PRINCIPAL
task.spawn(function()
    while true do
        task.wait(0.1)
        local root = miPlayer.Character and miPlayer.Character:FindFirstChild("HumanoidRootPart")
        local misc = Workspace:FindFirstChild("Misc")
        
        if root and misc then
            local balon = nil
            local objetoPosessionless = nil
            
            -- Escaneo dual en un solo bucle para eficiencia
            for _, obj in pairs(misc:GetChildren()) do
                if obj:IsA("BasePart") then
                    if string.match(obj.Name, "^Football") then balon = obj end
                    if string.find(string.lower(obj.Name), "possessionless") then objetoPosessionless = obj end
                end
            end
            
            -- Lógica Hitbox (basada en "possessionless")
            if modificarHitboxActivo and objetoPosessionless then
                objetoPosessionless.Size = Vector3.new(tamanoHitboxPersonalizado, tamanoHitboxPersonalizado, tamanoHitboxPersonalizado)
                objetoPosessionless.Transparency = transparenciaHitboxPersonalizada
                objetoPosessionless.CanCollide = false
            elseif balon then
                -- Si no está en estado "possessionless", restaurar el balón normal
                balon.Size = tamanoOriginalBalon
                balon.Transparency = 0
            end
            
            -- Lógica Autofarm AFK (basada en "Football")
            if modoAuditoriaActivo and balon then
                if (root.Position - balon.Position).Magnitude > DISTANCIA_POSESION_SEGURO then
                    root.CFrame = balon.CFrame
                else
                    root.CFrame = CFrame.new(obtenerCoordenadaObjetivo())
                end
            end
        end
    end
end)

-- 3. ELEMENTOS UI
TabAutomatizacion:CreateToggle({
   Name = "Autofarm AFK",
   Callback = function(Value) modoAuditoriaActivo = Value end,
})

TabAutomatizacion:CreateButton({
   Name = "Manual TP to Rival Goal",
   Callback = function()
       local root = miPlayer.Character and miPlayer.Character:FindFirstChild("HumanoidRootPart")
       if root then root.CFrame = CFrame.new(obtenerCoordenadaObjetivo()) end
   end,
})

TabVisuales:CreateToggle({
   Name = "Enable Hitbox Modification",
   Callback = function(Value) modificarHitboxActivo = Value end,
})

TabVisuales:CreateSlider({
   Name = "Hitbox Size (Studs)",
   Min = 5, Max = 30, CurrentValue = 5, Increment = 1,
   Callback = function(Value) tamanoHitboxPersonalizado = Value end,
})

TabVisuales:CreateSlider({
   Name = "Ball Transparency",
   Min = 1, Max = 10, CurrentValue = 5, Increment = 1,
   Callback = function(Value) transparenciaHitboxPersonalizada = Value / 10 end,
})
