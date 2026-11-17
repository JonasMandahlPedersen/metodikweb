# Genererer /assets/og-image.jpg (1200x630) til Open Graph / Twitter Card.
#
# NOTE: Opgaven bad om et Python/Pillow-script, men hverken Python, pip
# eller Node er installeret i dette miljø. Dette PowerShell-script bruger
# .NET's indbyggede System.Drawing (GDI+) i stedet, som er tilgængeligt på
# alle Windows-maskiner uden yderligere installation, og producerer det
# samme resultat (1200x630 JPEG, mørkegrøn baggrund, "Metodik" + tagline).
#
# Kør: powershell -File tools/generate-og-image.ps1

Add-Type -AssemblyName System.Drawing

$width = 1200
$height = 630
$bgColor = [System.Drawing.ColorTranslator]::FromHtml("#07241c")
$accentColor = [System.Drawing.ColorTranslator]::FromHtml("#2ecf8f")
$textColor = [System.Drawing.Color]::White

$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# Baggrund
$g.Clear($bgColor)

# Diskret accent-linje i venstre margin
$accentBrush = New-Object System.Drawing.SolidBrush($accentColor)
$g.FillRectangle($accentBrush, 0, 0, 10, $height)

# "Metodik" wordmark
$titleFont = New-Object System.Drawing.Font("Georgia", 72, [System.Drawing.FontStyle]::Regular)
$titleBrush = New-Object System.Drawing.SolidBrush($textColor)
$g.DrawString("Metodik", $titleFont, $titleBrush, 90, 230)

# Tagline
$tagFont = New-Object System.Drawing.Font("Segoe UI", 30, [System.Drawing.FontStyle]::Regular)
$tagBrush = New-Object System.Drawing.SolidBrush($accentColor)
$g.DrawString("Systemer der faktisk fjerner arbejde", $tagFont, $tagBrush, 90, 340)

$g.Flush()

$outPath = Join-Path $PSScriptRoot "..\assets\og-image.jpg"
$jpegEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 85L)
$bmp.Save($outPath, $jpegEncoder, $encParams)

$g.Dispose()
$bmp.Dispose()

Write-Output "Saved: $outPath"
