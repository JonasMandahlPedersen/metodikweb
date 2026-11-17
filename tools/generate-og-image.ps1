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

# "Metodik" wordmark — skal fylde ca. 40% af billedbredden (480px af 1200px)
$marginX = 90
$targetTitleWidth = $width * 0.40
$titleText = "Metodik"
$titleSizePx = 60.0
$titleFont = $null
for ($i = 0; $i -lt 40; $i++) {
  if ($titleFont) { $titleFont.Dispose() }
  $titleFont = New-Object System.Drawing.Font("Georgia", $titleSizePx, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
  $measured = $g.MeasureString($titleText, $titleFont, [System.Drawing.PointF]::new(0,0), [System.Drawing.StringFormat]::GenericTypographic)
  if ([Math]::Abs($measured.Width - $targetTitleWidth) -lt 1) { break }
  $titleSizePx = $titleSizePx * ($targetTitleWidth / $measured.Width)
}
$titleBrush = New-Object System.Drawing.SolidBrush($textColor)
$titleHeight = $g.MeasureString($titleText, $titleFont, [System.Drawing.PointF]::new(0,0), [System.Drawing.StringFormat]::GenericTypographic).Height
$titleY = 230
$g.DrawString($titleText, $titleFont, $titleBrush, (New-Object System.Drawing.PointF($marginX, $titleY)), [System.Drawing.StringFormat]::GenericTypographic)

# Tagline — mindst 48px
$tagFont = New-Object System.Drawing.Font("Segoe UI", 48, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$tagBrush = New-Object System.Drawing.SolidBrush($accentColor)
$tagY = $titleY + $titleHeight + 28
$g.DrawString("Systemer der faktisk fjerner arbejde", $tagFont, $tagBrush, (New-Object System.Drawing.PointF($marginX, $tagY)), [System.Drawing.StringFormat]::GenericTypographic)

Write-Output ("Metodik-bredde: {0:N0}px (maal: {1:N0}px) ved fontstoerrelse {2:N1}px" -f $measured.Width, $targetTitleWidth, $titleSizePx)

$g.Flush()

$outPath = Join-Path $PSScriptRoot "..\assets\og-image.jpg"
$jpegEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 85L)
$bmp.Save($outPath, $jpegEncoder, $encParams)

$g.Dispose()
$bmp.Dispose()

Write-Output "Saved: $outPath"
