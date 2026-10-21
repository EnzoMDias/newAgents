# Instala o Squad no Claude Code.
#   .\install.ps1                      -> nível de usuário (~/.claude), vale para todos os projetos
#   .\install.ps1 -Projeto C:\meu\app  -> só naquele projeto (<projeto>\.claude)
param([string]$Projeto)

$ErrorActionPreference = 'Stop'
$origem = $PSScriptRoot
$destino = if ($Projeto) { Join-Path (Resolve-Path $Projeto) '.claude' } else { Join-Path $HOME '.claude' }
$utf8 = New-Object System.Text.UTF8Encoding($false)  # sem BOM: o frontmatter precisa começar em '---'

$protocolo = [System.IO.File]::ReadAllText((Join-Path $origem 'shared\protocolo.md'), $utf8)

$dirAgentes = Join-Path $destino 'agents'
New-Item -ItemType Directory -Force $dirAgentes | Out-Null
$agentes = Get-ChildItem (Join-Path $origem 'agents') -Filter *.md
foreach ($a in $agentes) {
    $texto = [System.IO.File]::ReadAllText($a.FullName, $utf8).Replace('{{PROTOCOLO}}', $protocolo)
    [System.IO.File]::WriteAllText((Join-Path $dirAgentes $a.Name), $texto, $utf8)
}

$dirSkills = Join-Path $destino 'skills'
New-Item -ItemType Directory -Force $dirSkills | Out-Null
$skills = Get-ChildItem (Join-Path $origem 'skills') -Directory
foreach ($s in $skills) {
    $alvo = Join-Path $dirSkills $s.Name
    if (Test-Path $alvo) { Remove-Item -Recurse -Force $alvo }
    Copy-Item -Recurse $s.FullName $alvo
}

Write-Host "Squad instalado em $destino"
Write-Host ("  {0} agentes: {1}" -f $agentes.Count, (($agentes | ForEach-Object BaseName) -join ', '))
Write-Host ("  {0} skills: {1}" -f $skills.Count, (($skills | ForEach-Object { '/' + $_.Name }) -join ', '))
Write-Host 'Reinicie o Claude Code (ou abra uma nova sessão) para carregar.'
