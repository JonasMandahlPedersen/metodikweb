# SEO/teknisk sundhedstjek for alle HTML-sider på metodik.dk.
#
# Tjekker: GTM til stede, præcis én H1, title til stede, beskrivelse 120-160
# tegn, canonical, og:image, favicon, gyldig JSON-LD, ingen href="#".
#
# Kør: powershell -File tools/check-seo.ps1

$root = Resolve-Path (Join-Path $PSScriptRoot "..")

$files = @(
  "index.html", "om.html", "kontakt.html", "kommuner.html", "virksomheder.html",
  "losninger/index.html", "losninger/ai-automatisering.html", "losninger/saas-udvikling.html", "losninger/legacy-modernisering.html",
  "cases/index.html", "cases/ai-til-support-og-backoffice.html", "cases/fra-excel-til-websystem.html", "cases/kundeportal-og-booking.html",
  "artikler/index.html", "artikler/7-tegn-paa-at-excel-er-blevet-for-lille.html", "artikler/ai-i-smaa-og-mellemstore-virksomheder.html",
  "artikler/azure-vs-aws-til-saas.html", "artikler/hvad-koster-det-at-udvikle-en-saas-platform.html", "artikler/hvornaar-boer-man-bygge-sit-eget-system.html",
  "artikler/teknologi-loefter-borgeroplevelsen-i-kommunen.html", "artikler/teknologi-loefter-kundeoplevelsen-i-virksomheden.html"
)

$results = @()

foreach ($rel in $files) {
  $path = Join-Path $root $rel
  $content = Get-Content -Raw -Encoding UTF8 $path

  $gtm = $content -match 'GTM-P94CBZ86' -and $content -match '<noscript>'

  $h1Matches = [regex]::Matches($content, '<h1[\s>]')
  $h1Count = $h1Matches.Count

  $titleMatch = [regex]::Match($content, '<title>(.*?)</title>')
  $hasTitle = $titleMatch.Success -and $titleMatch.Groups[1].Value.Trim().Length -gt 0

  $descMatch = [regex]::Match($content, 'name="description"\s+content="([^"]*)"')
  $descLen = 0
  if ($descMatch.Success) { $descLen = $descMatch.Groups[1].Value.Length }
  $descOk = ($descLen -ge 120 -and $descLen -le 160)

  $hasCanonical = $content -match 'rel="canonical"'
  $hasOgImage = $content -match 'property="og:image"'
  $hasFavicon = $content -match 'rel="icon"'

  $jsonBlocks = [regex]::Matches($content, '<script type="application/ld\+json">\s*(\{.*?\})\s*</script>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
  $jsonValid = $true
  if ($jsonBlocks.Count -eq 0) {
    $jsonValid = $false
  } else {
    foreach ($m in $jsonBlocks) {
      try { $null = $m.Groups[1].Value | ConvertFrom-Json } catch { $jsonValid = $false }
    }
  }

  $hasHashHref = $content -match 'href="#"'

  $results += [PSCustomObject]@{
    Side           = $rel
    GTM            = if ($gtm) { "OK" } else { "FEJL" }
    "H1 (skal=1)"  = $h1Count
    Title          = if ($hasTitle) { "OK" } else { "FEJL" }
    "Desc-tegn"    = $descLen
    "Desc 120-160" = if ($descOk) { "OK" } else { "FEJL" }
    Canonical      = if ($hasCanonical) { "OK" } else { "FEJL" }
    "OG:image"     = if ($hasOgImage) { "OK" } else { "FEJL" }
    Favicon        = if ($hasFavicon) { "OK" } else { "FEJL" }
    "JSON-LD"      = if ($jsonValid) { "OK" } else { "FEJL" }
    'href="#"'     = if ($hasHashHref) { "FEJL" } else { "OK" }
  }
}

$results | Format-Table -AutoSize

$failCount = ($results | ForEach-Object {
  $row = $_
  $fails = 0
  foreach ($prop in @('GTM','Title','Desc 120-160','Canonical','OG:image','Favicon','JSON-LD','href="#"')) {
    if ($row.$prop -eq "FEJL") { $fails++ }
  }
  if ($row.'H1 (skal=1)' -ne 1) { $fails++ }
  $fails
} | Measure-Object -Sum).Sum

Write-Output ""
Write-Output "Samlet antal fejl på tværs af alle sider: $failCount"
