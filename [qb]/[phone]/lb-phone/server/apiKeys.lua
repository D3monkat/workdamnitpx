-- Webhook for instapic posts, recommended to be a public channel
INSTAPIC_WEBHOOK = "false"
-- Webhook for birdy posts, recommended to be a public channel
BIRDY_WEBHOOK = "false"

-- Discord webhook for server logs
LOGS = {
    Calls = "false", -- set to false to disable
    Messages = "false",
    InstaPic = "false",
    Birdy = "false",
    YellowPages = "false",
    Marketplace = "false",
    Mail = "false",
    Wallet = "false",
    DarkChat = "false",
    Services = "false",
    Crypto = "false",
    Trendy = "false",
    Uploads = "false" -- all camera uploads will go here
}

-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default upload method is Fivemanage
-- We STRONGLY discourage using Discord as an upload method, as uploaded files may become inaccessible after a while.
-- You can get your API keys from https://fivemanage.com/
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = "gx3dSW5w0ChvXXQTzEE6hPP4q437m6A3",
    Image = "gx3dSW5w0ChvXXQTzEE6hPP4q437m6A3",
    Audio = "gx3dSW5w0ChvXXQTzEE6hPP4q437m6A3",
}
