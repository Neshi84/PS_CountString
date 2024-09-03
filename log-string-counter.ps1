param(
    [Parameter(Mandatory=$true)]
    [string]$FolderPath,

    [Parameter(Mandatory=$true)]
    [string]$SearchString
)

# Check if the folder exists
if (-not (Test-Path -Path $FolderPath -PathType Container)) {
    Write-Error "The specified folder does not exist: $FolderPath"
    exit 1
}

# Initialize a counter for total occurrences
$totalOccurrences = 0

# Get all .log files in the specified folder
$logFiles = Get-ChildItem -Path $FolderPath -Filter *.log -File

# Loop through each log file
foreach ($file in $logFiles) {
    $fileContent = Get-Content -Path $file.FullName
    $occurrences = ($fileContent | Select-String -Pattern $SearchString -AllMatches).Matches.Count
    $totalOccurrences += $occurrences
    
    Write-Host "File: $($file.Name) - Occurrences: $occurrences"
}

Write-Host "`nTotal occurrences of '$SearchString' across all log files: $totalOccurrences"
