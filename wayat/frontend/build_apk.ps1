Write-Output '
__          __               _     ____  _    _ _____ _      _____  
\ \        / /              | |   |  _ \| |  | |_   _| |    |  __ \ 
 \ \  /\  / /_ _ _   _  __ _| |_  | |_) | |  | | | | | |    | |  | |
  \ \/  \/ / _` | | | |/ _` | __| |  _ <| |  | | | | | |    | |  | |
   \  /\  / (_| | |_| | (_| | |_  | |_) | |__| |_| |_| |____| |__| |
    \/  \/ \__,_|\__, |\__,_|\__| |____/ \____/|_____|______|_____/ 
                  __/ |                                             
                 |___/                                              
'
flutter pub get
$GM_KEY = Read-Host "`nPlease enter the Google Maps KEY " -AsSecureString
$env:GOOGLE_MAPS_KEY=$GM_KEY
Write-Output "`nGenerating apk, this might take a while..."
flutter build apk
Write-Output "`nGenerated apk:"
Get-ChildItem -Path "build\app\outputs\flutter-apk\app-release.apk"
