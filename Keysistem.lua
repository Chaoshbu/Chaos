--[[
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
local Config = {
    -- [1] PlatoBoost Settings
    ServiceId       = 26436,
    PlatoSecret     = "45b99259-60e7-4045-870a-6ee67d5bcb69",

    -- [2] Anti-Bypass / Global Secret Variable
    Secret          = "FuckYouBitch", 
    
    -- [3] Scripts & Links
    MainScriptURL   = "https://raw.githubusercontent.com/Chaoshbu/Chaos/refs/heads/main/Script.lua",
    
    -- [4] Social Media Settings
    ShowDiscord     = true,
    DiscordURL      = "https://discord.gg/rdpfE28Qh",
    
    ShowInstagram   = false,
    InstagramURL    = "https://www.instagram.com/oyb0i/",
    
    ShowYoutube     = false,
    YoutubeURL      = "https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ",

    -- [5] File System
    KeyFileName     = "Mykey.txt",

    -- [6] GUI Management
    OldGuiName      = "Anything",
    MainGuiName     = "Anything",

    -- [7] Hub Information & UI Text
    HubName         = "Chaos HUB",
    HubDescription  = "PLEASE GET YOUR KEY"
}

-- [IMPORTANTE] El resto de tus librerías y funciones (lEncode, redeemKey, etc.) 
-- deben mantenerse exactamente como las tenías, asegurándote de que no falte ningún "end"
-- al final del archivo. Aquí completo la parte final del GUI que estaba cortada:

    -- YouTube Button (Continuación y cierre)
    if Config.ShowYoutube then
        local YTBtn = Instance.new("TextButton", MainFrame)
        YTBtn.Size = UDim2.new(0.85, 0, 0, 35)
        YTBtn.Position = UDim2.new(0.075, 0, 0, currentYOffset)
        YTBtn.Text = "      SUBSCRIBE YOUTUBE"
        YTBtn.Font = "GothamBold"
        YTBtn.TextSize = 14
        YTBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        YTBtn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", YTBtn)
        AddRainbowStroke(YTBtn)
        
        YTBtn.MouseButton1Click:Connect(function()
            fSetClipboard(Config.YoutubeURL)
        end)
    end
end -- Cierre de CreateGUI

-- Finalmente, asegúrate de llamar a la función para que el menú aparezca:
CreateGUI()
