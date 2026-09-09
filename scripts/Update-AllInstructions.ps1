#Requires -Version 7.0
[CmdletBinding()]
param(
    [switch]$Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$instructions = Join-Path $root 'instructions'
$languages = @('ja', 'en')
$topics = @{}
$baseModules = @('01-responsible-ai', '07-uncertainty', '09-language', '16-work-context')
$presets = @(
    @{
        Slug    = 'engineer'
        Titles  = @{ ja = 'エンジニア向けおすすめセット'; en = 'Recommended set for engineers' }
        Reasons = @{
            ja = '基本の応答方針と社内文脈に、技術文書の具体性と、設計判断・検証の観点を加えたセットです。詳細設計書専用の構成は常設せず、必要な依頼で追加できます。'
            en = 'Combines response fundamentals and work context with concrete technical documentation and design validation. Add detailed-design structure to individual requests when needed rather than keeping it in standing instructions.'
        }
        Modules = @('10-technical-documentation', '17-engineering-decisions')
    }
    @{
        Slug    = 'marketing'
        Titles  = @{ ja = 'マーケティング向けおすすめセット'; en = 'Recommended set for marketing' }
        Reasons = @{
            ja = '基本の応答方針と社内文脈に、市場分析、読み手中心の資料作成、顧客理解と施策検証を加えたセットです。調査から訴求・施策の立案までを支援します。'
            en = 'Combines response fundamentals and work context with market analysis, audience-first materials, customer insight, and campaign evaluation, supporting research through messaging and campaign planning.'
        }
        Modules = @('12-market-analysis', '14-audience-first', '18-marketing-evidence')
    }
    @{
        Slug    = 'sales'
        Titles  = @{ ja = '営業向けおすすめセット'; en = 'Recommended set for sales' }
        Reasons = @{
            ja = '基本の応答方針と社内文脈に、顧客中心の資料作成と、案件の根拠・次の合意の整理を加えたセットです。商談準備と提案に使えます。'
            en = 'Combines response fundamentals and work context with customer-centered materials, opportunity evidence, and next agreements for meeting preparation and proposals.'
        }
        Modules = @('14-audience-first', '19-sales-qualification')
    }
    @{
        Slug    = 'manager'
        Titles  = @{ ja = 'マネージャー向けおすすめセット'; en = 'Recommended set for managers' }
        Reasons = @{
            ja = '基本の応答方針と社内文脈に、高リスクな判断への配慮と、チームの実行・支援を加えたセットです。進捗や業務配分を扱い、AIだけで人事判断を完了しない方針を含みます。'
            en = 'Combines response fundamentals and work context with high-risk safeguards and team execution support. Covers progress and work allocation without completing personnel decisions through AI alone.'
        }
        Modules = @('08-high-risk', '20-management-execution')
    }
    @{
        Slug    = 'executive'
        Titles  = @{ ja = '経営者向けおすすめセット'; en = 'Recommended set for executives' }
        Reasons = @{
            ja = '基本の応答方針と社内文脈に、定量データ、市場分析、戦略と資源配分を加えたセットです。数値の比較条件、代替案、投資・撤退の判断条件を重視します。'
            en = 'Combines response fundamentals and work context with quantitative data, market analysis, strategy, and resource allocation. Emphasizes comparable figures, alternatives, and investment or exit criteria.'
        }
        Modules = @('05-quantitative-data', '12-market-analysis', '21-executive-strategy')
    }
)

foreach ($language in $languages) {
    $topics[$language] = @(Get-ChildItem -LiteralPath (Join-Path $instructions $language) -Directory |
        Where-Object Name -Match '^(?!00-)\d{2}-' |
        Sort-Object Name)
    if ($topics[$language].Count -eq 0) {
        throw "No source modules found for $language."
    }
}
if (Compare-Object $topics['ja'].Name $topics['en'].Name -CaseSensitive) {
    throw 'Japanese and English source modules must have matching directory names.'
}

$labels = @{
    ja = @{
        Title            = '全てのカスタム指示'
        Navigation       = '[English](../../en/00-all/README.md) · [指示一覧](../../../readme.md)'
        Intro            = '同じ言語の全{0}項目を、番号順に省略せずまとめた一括コピー用の指示です。'
        File             = '本文だけのファイル：[custom-instructions.md](custom-instructions.md)。GitHubのRaw表示から全文をコピーできます。'
        Warning          = '> 入力上限に収まるかは利用環境で確認してください。入りきらない場合は個別項目を選んで利用してください。一括版と個別版を重複して貼り付ける必要はありません。'
        Heading          = 'コピー用の指示'
        NotesHeading     = '更新について'
        Notes            = 'このページと指示ファイルは個別項目から自動生成しています。直接編集せず、元の項目を修正して再生成してください。手順は[コントリビューションガイド](../../../CONTRIBUTING.md)を参照してください。'
        PresetNavigation = '[English](../../en/presets/{0}.md) · [指示一覧](../../../readme.md)'
        PresetModules    = '含まれる項目'
        PresetUsage      = '下のコードブロックの中身をまとめてコピーし、Microsoft 365 Copilot のカスタム指示欄に貼り付けて利用できます。参照資料や案件名の事前入力は不要です。具体的な対象・期間・資料は個々の依頼で指定してください。'
        PresetWarning    = '> まずはこのセット1つを選んでください。一括版・他のセット・含まれる個別項目との重複貼り付けは不要です。入力上限と適用範囲は利用環境で確認し、入りきらない場合は項目単位で減らしてください。検索機能やアクセス権は追加されず、回答の品質も保証されません。'
        PresetNotes      = 'このページは個別項目の本文を番号順に省略せず連結して自動生成しています。直接編集せず、元の項目または生成スクリプト内の組み合わせを変更して再生成してください。手順は[コントリビューションガイド](../../../CONTRIBUTING.md)を参照してください。'
    }
    en = @{
        Title            = 'All custom instructions'
        Navigation       = '[日本語](../../ja/00-all/README.md) · [Instruction catalog](../../../readme-en.md)'
        Intro            = 'All {0} modules in this language, combined in numerical order without abridgment for copying in one step.'
        File             = 'Instructions-only file: [custom-instructions.md](custom-instructions.md). Use GitHub''s Raw view to copy the full text.'
        Warning          = '> Check the input limit in your environment. If the combined instructions do not fit, select individual modules instead. Do not paste both the combined edition and its individual modules. In the English edition, module 09 follows the language of the user''s request unless a response language is explicitly specified.'
        Heading          = 'Instructions to copy'
        NotesHeading     = 'Updating this edition'
        Notes            = 'This page and the instructions-only file are generated from the individual modules. Edit the source modules and regenerate rather than editing these files directly. See the [contribution guide](../../../CONTRIBUTING.md#english).'
        PresetNavigation = '[日本語](../../ja/presets/{0}.md) · [Instruction catalog](../../../readme-en.md)'
        PresetModules    = 'Included modules'
        PresetUsage      = 'Copy the entire contents of the code block below into your Microsoft 365 Copilot custom instructions. No project names or reference materials need to be filled in beforehand. Specify the subject, period, and materials in each individual request.'
        PresetWarning    = '> Start with one set. Do not also paste the all-instructions edition, other sets, or included individual modules. Check input limits and scope in your environment; remove whole modules if necessary. Instructions do not grant search capabilities or access, or guarantee response quality. In the English edition, module 09 follows the language of the user''s request unless a response language is explicitly specified.'
        PresetNotes      = 'This page is generated by joining the complete source instructions in numerical order. Do not edit it directly; update the source modules or the combinations in the generator and regenerate. See the [contribution guide](../../../CONTRIBUTING.md#english).'
    }
}

$outputs = [System.Collections.Generic.List[object]]::new()
foreach ($language in $languages) {
    $blocks = [ordered]@{}
    foreach ($topic in $topics[$language]) {
        $source = Join-Path $topic.FullName 'README.md'
        $text = [System.IO.File]::ReadAllText($source).Replace("`r`n", "`n")
        $instructionBlocks = [regex]::Matches($text, '(?ms)^```text\n(?<body>.*?)\n```[ \t]*(?:\n|$)')
        if ($instructionBlocks.Count -ne 1 -or $instructionBlocks[0].Groups['body'].Value -notmatch '^# ') {
            throw "Expected exactly one nonempty, headed text instruction block: $source"
        }
        $blocks[$topic.Name] = $instructionBlocks[0].Groups['body'].Value.TrimEnd("`n")
    }
    $combined = ($blocks.Values -join "`n`n") + "`n"
    $label = $labels[$language]
    $readme = (@(
            "# $($label.Title)", '', $label.Navigation, '',
            ($label.Intro -f $topics[$language].Count), '', $label.File, '',
            $label.Warning, '', "## $($label.Heading)", '', '```text',
            $combined.TrimEnd("`n"), '```', '',
            "## $($label.NotesHeading)", '', $label.Notes, ''
        ) -join "`n")
    $destination = Join-Path (Join-Path $instructions $language) '00-all'
    $outputs.Add(@{ Path = (Join-Path $destination 'custom-instructions.md'); Content = $combined })
    $outputs.Add(@{ Path = (Join-Path $destination 'README.md'); Content = $readme })
    foreach ($preset in $presets) {
        $moduleNames = @($baseModules + $preset.Modules | Sort-Object -Unique)
        foreach ($moduleName in $moduleNames) {
            if (-not $blocks.Contains($moduleName)) {
                throw "Missing module '$moduleName' for preset '$($preset.Slug)' ($language)."
            }
        }
        $moduleLinks = foreach ($moduleName in $moduleNames) {
            $title = ($blocks[$moduleName] -split "`n", 2)[0].Substring(2)
            '- [{0} {1}](../{2}/README.md)' -f $moduleName.Substring(0, 2), $title, $moduleName
        }
        $presetBody = ($moduleNames | ForEach-Object { $blocks[$_] }) -join "`n`n"
        $presetReadme = (@(
                "# $($preset.Titles[$language])", '', ($label.PresetNavigation -f $preset.Slug), '',
                $preset.Reasons[$language], '', $label.PresetUsage, '', $label.PresetWarning, '',
                "## $($label.PresetModules)", '', ($moduleLinks -join "`n"), '',
                "## $($label.Heading)", '', '```text', $presetBody, '```', '',
                "## $($label.NotesHeading)", '', $label.PresetNotes, ''
            ) -join "`n")
        $presetPath = Join-Path (Join-Path (Join-Path $instructions $language) 'presets') "$($preset.Slug).md"
        $outputs.Add(@{ Path = $presetPath; Content = $presetReadme })
    }
}

if ($Check) {
    $stale = @($outputs | Where-Object {
            -not (Test-Path -LiteralPath $_.Path) -or
            [System.IO.File]::ReadAllText($_.Path).Replace("`r`n", "`n") -cne $_.Content
        })
    if ($stale.Count -gt 0) {
        throw "Combined instructions or role presets are missing or outdated. Run scripts\Update-AllInstructions.ps1.`n$($stale.Path -join "`n")"
    }
    Write-Output 'Both combined editions and all role presets match their source modules.'
}
else {
    foreach ($output in $outputs) {
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $output.Path)) | Out-Null
        [System.IO.File]::WriteAllText($output.Path, $output.Content, [System.Text.UTF8Encoding]::new($false))
    }
    Write-Output "Generated $($outputs.Count) files for the Japanese and English combined editions."
}
