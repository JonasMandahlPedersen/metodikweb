# Optimerer assets/jonas.png (1086x1448, 1.9MB) til en langt mindre JPEG.
#
# NOTE: Opgaven bad om WebP-konvertering, men der er ingen WebP-encoder
# tilgængelig i dette miljø (hverken cwebp, Pillow/Python, Node eller en
# WIC WebP-codec, som .NET's System.Drawing kan tilgå). Dette script
# producerer i stedet en resized + genkomprimeret JPEG, som dækker det
# samme performance-problem (stort fil-fald, ingen oversized dimensioner).
# <picture>-elementet i HTML har en TODO-kommentar om at tilføje en rigtig
# WebP-source, når filen er genereret på en maskine med fx cwebp/Pillow:
#   cwebp assets/jonas.png -resize 900 0 -q 82 -o assets/jonas.webp
#
# Kør: powershell -File tools/optimize-jonas-photo.ps1

Add-Type -AssemblyName System.Drawing

$srcPath = Join-Path $PSScriptRoot "..\assets\jonas.png"
$outPath = Join-Path $PSScriptRoot "..\assets\jonas.jpg"

$targetWidth = 900

$src = [System.Drawing.Image]::FromFile($srcPath)
$targetHeight = [int]([math]::Round($src.Height * ($targetWidth / $src.Width)))

$resized = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
$g = [System.Drawing.Graphics]::FromImage($resized)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.DrawImage($src, 0, 0, $targetWidth, $targetHeight)
$g.Dispose()
$src.Dispose()

$jpegEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 82L)
$resized.Save($outPath, $jpegEncoder, $encParams)
$resized.Dispose()

$newSize = (Get-Item $outPath).Length
Write-Output "Saved: $outPath ($targetWidth x $targetHeight, $([math]::Round($newSize/1KB)) KB)"
