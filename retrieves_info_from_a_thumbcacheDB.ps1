$thumbcachePath = "C:\Users\Username\AppData\Local\Microsoft\Windows\Explorer\thumbcache_xxx.db"

# Open the thumbcache database file and retrieve information about the database
$thumbcache = New-Object System.Data.SQLite.SQLiteConnection("Data Source=$thumbcachePath;Version=3;")
$thumbcache.Open()
$thumbcacheCmd = $thumbcache.CreateCommand()
$thumbcacheCmd.CommandText = "PRAGMA table_info(thumbnail)"
$thumbcacheTable = $thumbcacheCmd.ExecuteReader()

# Retrieve the filenames and timestamps of all thumbnails in the database
$thumbcacheCmd.CommandText = "SELECT filename, last_access_time FROM thumbnail"
$thumbcacheResults = $thumbcacheCmd.ExecuteReader()

# Output the results
while ($thumbcacheResults.Read())
{
    Write-Host "Filename: " $thumbcacheResults.GetValue(0) "Last Access Time: " $thumbcacheResults.GetValue(1)
}

# Close the thumbcache database file
$thumbcache.Close()

$results | Export-Csv -Path C:\output.csv -NoTypeInformation


