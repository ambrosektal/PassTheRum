$indexClient = new-object system.net.webclient 
$jsonIndex=$indexClient.DownloadString("https://api.nuget.org/v3/catalog0/index.json") | ConvertFrom-Json 
for ($h=0; $h -lt $jsonIndex.items.Length; $h++) { 
    $web_client = new-object system.net.webclient 
    $jsonObj=$web_client.DownloadString($jsonIndex.items[$h].'@id') | ConvertFrom-Json
    for ($i=0; $i -lt $jsonObj.items.Length; $i++) { 
        $package = $jsonObj.items[$i]."nuget:id" + "/" + $jsonObj.items[$i]."nuget:version" 
        $web_client.DownloadFile("https://www.nuget.org/api/v2/package/" + $package, ("C:\Nuget\" + $jsonObj.items[$i]."nuget:id" + "." + $jsonObj.items[$i]."nuget:version" + ".nupkg")) 
        "Processing: " + ($h + 1) + " of " + $jsonIndex.count + " ---- " + ($i + 1) + " of " + $jsonObj.count + " - " + $jsonObj.items[$i]."nuget:id" + "." + $jsonObj.items[$i]."nuget:version" 
    }
}