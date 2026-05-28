# clean.ps1

Write-Host "Cleaning files..."
Write-Host ""

# Caminho protegido
$ignorePath = "\src\modules\"

# Extensões para remover
$extensions = @(
    "*.~*",
    "*.local",
    "*.identcache",
    "*.dcu",
    "*.dres",
    "*.skincfg",
    "*.stat",
    "*.rc",
    "*.res",
    "*.tvsconfig",
    "*.rsm",
    "*.bpl"
)

# Remove arquivos
Get-ChildItem -Path . -Recurse -File -Include $extensions |
Where-Object {
    $_.FullName -notlike "*$ignorePath*"
} |
ForEach-Object {
    Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
}

Write-Host "Removing build folders..."
Write-Host ""

# Pastas para remover
$folders = @(
    "Library",
    "__history",
    "__recovery",
    "Debug",
    "Release",
    "Win32",
    "Win64"
)

# Remove diretórios
Get-ChildItem -Path . -Recurse -Directory |
Where-Object {
    $_.Name -in $folders -and
    $_.FullName -notlike "*$ignorePath*"
} |
ForEach-Object {
    Write-Host "Removing folder $($_.FullName)"
    Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Done!"