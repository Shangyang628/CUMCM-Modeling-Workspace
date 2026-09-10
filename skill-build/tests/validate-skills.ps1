param(
    [Parameter(Mandatory = $true)]
    [string]$OptimizedRoot,
    [Parameter(Mandatory = $true)]
    [string]$TestsRoot
)

$ErrorActionPreference = 'Stop'
$findings = [System.Collections.Generic.List[object]]::new()

function Add-Finding {
    param([string]$Status, [string]$Check, [string]$Detail)
    $findings.Add([pscustomobject]@{status=$Status; check=$Check; detail=$Detail})
}

$expected = @(
    'math-modeling-orchestrator',
    'math-modeling-problem-decomposer',
    'math-modeling-strategy-designer',
    'math-modeling-code-experiment',
    'math-modeling-model-validator',
    'math-modeling-methodology-writer',
    'math-modeling-solution-writer',
    'math-modeling-consistency-auditor',
    'nature-writing',
    'humanizer-zh'
)

$dirs = @(Get-ChildItem -LiteralPath $OptimizedRoot -Directory | Sort-Object Name)
if (@($dirs.Name) -join '|' -eq @($expected | Sort-Object) -join '|') {
    Add-Finding PASS 'skill-set' 'Expected 10 skill folders are present.'
} else {
    Add-Finding FAIL 'skill-set' ("Expected: {0}; actual: {1}" -f ($expected -join ', '), ($dirs.Name -join ', '))
}

$names = @()
foreach ($dir in $dirs) {
    $skillPath = Join-Path $dir.FullName 'SKILL.md'
    $agentPath = Join-Path $dir.FullName 'agents\openai.yaml'
    if (-not (Test-Path -LiteralPath $skillPath)) {
        Add-Finding FAIL 'skill-entrypoint' "$($dir.Name) lacks SKILL.md"
        continue
    }
    $content = Get-Content -Raw -LiteralPath $skillPath
    $front = [regex]::Match($content, '(?ms)^---\s*\r?\n(?<yaml>.*?)\r?\n---\s*\r?\n')
    if (-not $front.Success) {
        Add-Finding FAIL 'frontmatter' "$($dir.Name) has invalid frontmatter delimiters"
        continue
    }
    $name = [regex]::Match($front.Groups['yaml'].Value, '(?m)^name:\s*["'']?(?<v>[^\r\n"'']+)').Groups['v'].Value.Trim()
    $description = [regex]::Match($front.Groups['yaml'].Value, '(?m)^description:\s*["'']?(?<v>[^\r\n]+)').Groups['v'].Value.Trim().Trim('"', "'")
    $names += $name
    if ($name -ne $dir.Name) { Add-Finding FAIL 'name-folder-match' "$($dir.Name) declares name $name" }
    if ([string]::IsNullOrWhiteSpace($description)) { Add-Finding FAIL 'description' "$($dir.Name) lacks a description" }
    if (-not (Test-Path -LiteralPath $agentPath)) {
        Add-Finding FAIL 'openai-yaml' "$($dir.Name) lacks agents/openai.yaml"
    } else {
        $agent = Get-Content -Raw -LiteralPath $agentPath
        if ($agent -notmatch [regex]::Escape("`$$name")) { Add-Finding FAIL 'explicit-invocation' "$($dir.Name) default_prompt does not mention `$$name" }
    }
}

if (@($names | Sort-Object -Unique).Count -eq $names.Count) {
    Add-Finding PASS 'unique-names' "All $($names.Count) skill names are unique."
} else {
    Add-Finding FAIL 'unique-names' 'Duplicate skill names found.'
}

$broken = @()
foreach ($file in Get-ChildItem -LiteralPath $OptimizedRoot -Recurse -Filter *.md -File) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    foreach ($match in [regex]::Matches($content, '\[[^\]]*\]\((?<target>[^)]+)\)')) {
        $target = $match.Groups['target'].Value.Trim()
        if ($target -match '^(https?://|mailto:|#)') { continue }
        $pathPart = ($target -split '#')[0]
        if (-not $pathPart) { continue }
        $resolved = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $pathPart))
        if (-not (Test-Path -LiteralPath $resolved)) { $broken += "$($file.FullName) -> $target" }
    }
}
if ($broken.Count -eq 0) { Add-Finding PASS 'local-references' 'All local Markdown references resolve.' } else { Add-Finding FAIL 'local-references' ($broken -join '; ') }

$forbiddenFiles = @(Get-ChildItem -LiteralPath $OptimizedRoot -Recurse -File | Where-Object { $_.Extension -match '(?i)^\.(exe|msi|bat|cmd|ps1|py|sh|js|vbs|dll|scr)$' })
if ($forbiddenFiles.Count -eq 0) { Add-Finding PASS 'runtime-files' 'No executable or script files are installed.' } else { Add-Finding FAIL 'runtime-files' ($forbiddenFiles.FullName -join '; ') }

$allText = (Get-ChildItem -LiteralPath $OptimizedRoot -Recurse -File | Where-Object { $_.Extension -in @('.md','.yaml','.yml') } | ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join "`n"
if ($allText -notmatch '(?i)bundled_dependencies') { Add-Finding PASS 'dependency-dedup' 'No bundled_dependencies remain in optimized skills.' } else { Add-Finding FAIL 'dependency-dedup' 'bundled_dependencies reference remains.' }
if ($allText -notmatch "(?i)matplotlib\.use\s*\(\s*['`"]TkAgg['`"]\s*\)") { Add-Finding PASS 'backend' 'No executable TkAgg hard-coding remains.' } else { Add-Finding FAIL 'backend' 'Executable TkAgg hard-coding remains.' }
if ($allText -notmatch '(?i)[A-Z]:\\') { Add-Finding PASS 'absolute-paths' 'No Windows absolute path is embedded in optimized skills.' } else { Add-Finding FAIL 'absolute-paths' 'Windows absolute path found.' }

$required = [ordered]@{
    'math-modeling-strategy-designer' = @('Problem Fit','Homogenization Risk','Originality != obscure algorithm','Simplicity Gate','AWAITING ROUTE DECISION')
    'math-modeling-code-experiment' = @('baseline','split protocol','ablation','sensitivity','robustness','Reproducibility')
    'math-modeling-model-validator' = @('target','temporal','normalization','cross-validation','PASS','WARNING','FAIL','NOT VERIFIED')
    'math-modeling-methodology-writer' = @('Do not include observed RMSE','final code','final configuration')
    'math-modeling-solution-writer' = @('Every number must come from a named final artifact','negative R-squared','evidence ledger')
    'math-modeling-consistency-auditor' = @('paper equations','paper parameters','paper tables','figure','conclusions')
}
foreach ($skill in $required.Keys) {
    $content = Get-Content -Raw -LiteralPath (Join-Path $OptimizedRoot "$skill\SKILL.md")
    $missing = @($required[$skill] | Where-Object { $content -notmatch [regex]::Escape($_) })
    if ($missing.Count -eq 0) { Add-Finding PASS "behavior-$skill" 'Required behavioral clauses are present.' } else { Add-Finding FAIL "behavior-$skill" ("Missing: {0}" -f ($missing -join ', ')) }
}

$triggerPath = Join-Path $TestsRoot 'trigger-cases.yaml'
$triggerText = Get-Content -Raw -LiteralPath $triggerPath
$caseCount = ([regex]::Matches($triggerText, '(?m)^\s*- id:')).Count
if ($caseCount -ge 30) { Add-Finding PASS 'trigger-case-count' "$caseCount trigger cases found." } else { Add-Finding FAIL 'trigger-case-count' "Only $caseCount trigger cases found." }
$casePrefixes = [ordered]@{
    'math-modeling-orchestrator' = 'orchestrator'
    'math-modeling-problem-decomposer' = 'decomposer'
    'math-modeling-strategy-designer' = 'strategy'
    'math-modeling-code-experiment' = 'experiment'
    'math-modeling-model-validator' = 'validator'
    'math-modeling-methodology-writer' = 'methodology'
    'math-modeling-solution-writer' = 'solution'
    'math-modeling-consistency-auditor' = 'consistency'
    'nature-writing' = 'nature'
    'humanizer-zh' = 'humanizer'
}
foreach ($name in $expected) {
    $prefix = $casePrefixes[$name]
    $ids = @("$prefix-positive", "$prefix-negative", "$prefix-boundary")
    $missingIds = @($ids | Where-Object { $triggerText -notmatch "(?m)^\s*- id:\s+$([regex]::Escape($_))\s*$" })
    if ($missingIds.Count -eq 0) { Add-Finding PASS 'trigger-coverage' "$name has positive, negative, and boundary cases." }
    else { Add-Finding FAIL 'trigger-coverage' "$name is missing: $($missingIds -join ', ')" }
}

$routeText = Get-Content -Raw -LiteralPath (Join-Path $TestsRoot 'modeling-route-cases.md')
$routeHeadings = ([regex]::Matches($routeText, '(?m)^## (Evaluation|Cross-sectional prediction|Optimization|Time series|Mechanism modeling)$')).Count
if ($routeHeadings -eq 5) { Add-Finding PASS 'anti-template-cases' 'All five modeling categories are present.' } else { Add-Finding FAIL 'anti-template-cases' "$routeHeadings of 5 modeling categories found." }

$summary = [pscustomobject]@{
    overall = if (@($findings | Where-Object status -eq 'FAIL').Count -eq 0) { 'PASS' } else { 'FAIL' }
    pass = @($findings | Where-Object status -eq 'PASS').Count
    fail = @($findings | Where-Object status -eq 'FAIL').Count
    findings = $findings
}
$summary | ConvertTo-Json -Depth 6
if ($summary.overall -ne 'PASS') { exit 1 }
