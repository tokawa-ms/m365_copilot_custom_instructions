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
$baseModules = @(
    '01-responsible-ai', '02-research', '03-conflicting-sources',
    '04-entity-verification', '05-quantitative-data', '06-ambiguity',
    '07-uncertainty', '08-high-risk', '09-language', '12-market-analysis',
    '14-audience-first', '15-instruction-priority', '16-work-context'
)
$presets = @(
    @{
        Slug    = 'engineer'
        Titles  = @{ ja = 'エンジニア向けおすすめセット'; en = 'Recommended set for engineers' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、技術文書の具体性と、設計判断・検証の観点を加えたセットです。詳細設計書専用の構成は常設せず、必要な依頼で追加できます。'
            en = 'Adds concrete technical documentation and design validation to 13 shared modules for consistent handling of evidence and uncertainty. Add detailed-design structure to individual requests when needed rather than keeping it in standing instructions.'
        }
        Modules = @('10-technical-documentation', '17-engineering-decisions')
    }
    @{
        Slug    = 'marketing'
        Titles  = @{ ja = 'マーケティング向けおすすめセット'; en = 'Recommended set for marketing' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、顧客理解と施策検証を加えたセットです。共通項目の市場分析・読み手中心の資料作成と合わせ、調査から訴求・施策の立案までを支援します。'
            en = 'Adds customer insight and experiment design to 13 shared modules for consistent handling of evidence and uncertainty. Shared market-analysis and audience-first guidance supports research through messaging and campaign planning.'
        }
        Modules = @('18-marketing-evidence')
    }
    @{
        Slug    = 'sales'
        Titles  = @{ ja = '営業向けおすすめセット'; en = 'Recommended set for sales' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、案件の根拠・次の合意の整理を加えたセットです。共通項目の市場分析・読み手中心の資料作成と合わせ、商談準備と提案に使えます。'
            en = 'Adds opportunity evidence and next agreements to 13 shared modules for consistent handling of evidence and uncertainty. Shared market-analysis and audience-first guidance supports meeting preparation and proposals.'
        }
        Modules = @('19-sales-qualification')
    }
    @{
        Slug    = 'manager'
        Titles  = @{ ja = 'マネージャー向けおすすめセット'; en = 'Recommended set for managers' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、チームの実行・支援を加えたセットです。進捗や業務配分を扱い、共通項目の高リスク領域への配慮と合わせ、AIだけで人事判断を完了しない方針を含みます。'
            en = 'Adds team execution and support to 13 shared modules for consistent handling of evidence and uncertainty. Covers progress and work allocation alongside shared high-risk safeguards, without completing personnel decisions through AI alone.'
        }
        Modules = @('20-management-execution')
    }
    @{
        Slug    = 'executive'
        Titles  = @{ ja = '経営者向けおすすめセット'; en = 'Recommended set for executives' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、戦略と資源配分を加えたセットです。共通項目の定量データ・市場分析と合わせ、数値の比較条件、代替案、投資・撤退の判断条件を重視します。'
            en = 'Adds strategy and resource allocation to 13 shared modules for consistent handling of evidence and uncertainty. Shared quantitative-data and market-analysis guidance supports comparable figures, alternatives, and investment or exit criteria.'
        }
        Modules = @('21-executive-strategy')
    }
    @{
        Slug    = 'general-affairs'
        Titles  = @{ ja = '総務向けおすすめセット'; en = 'Recommended set for general affairs' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、規程・契約と業務運用を加えたセットです。有効な規程と個別例外を区別し、申請案内、購買・契約更新、施設・備品管理、社内周知を支援します。'
            en = 'Adds policies, contracts, and operations to 13 shared modules for consistent handling of evidence and uncertainty. Distinguishes policies in force from individual exceptions and supports applications, purchasing and renewals, facilities and equipment, and internal communications.'
        }
        Modules = @('22-general-affairs')
    }
    @{
        Slug    = 'accounting'
        Titles  = @{ ja = '経理向けおすすめセット'; en = 'Recommended set for accounting' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、証憑照合と会計判断を加えたセットです。経費・請求・支払の確認、仕訳案、決算・差異分析を支援し、処理案と承認・実行済みの記録を区別します。'
            en = 'Adds evidence reconciliation and accounting judgments to 13 shared modules for consistent handling of evidence and uncertainty. Supports expense, invoice, and payment checks, proposed entries, close, and variance analysis while distinguishing proposals from approved or executed records.'
        }
        Modules = @('23-accounting-controls')
    }
    @{
        Slug    = 'human-resources'
        Titles  = @{ ja = '人事向けおすすめセット'; en = 'Recommended set for human resources' }
        Reasons = @{
            ja = '根拠と不確実性の扱いを揃える共通13項目に、制度・労務と公平な判断支援を加えたセットです。制度の適用条件、職務に関係する証拠、個人情報の目的限定を重視し、重大な人事判断は権限者による確認を必要とします。'
            en = 'Adds employment policies and fair decision support to 13 shared modules for consistent handling of evidence and uncertainty. Emphasizes policy eligibility, job-related evidence, and purpose-limited personal data, requiring authorized review of consequential personnel decisions.'
        }
        Modules = @('24-human-resources')
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
        PresetPolicy     = @(
            '# このセットの適用方針', '',
            '- 以下の指示は常設の方針として扱い、各依頼に関係する条件に応じて適用する。毎回すべての調査・分析・構成を実行する必要はない。',
            '- 調査、情報源の比較、対象の同定、数値の検証は、事実確認が必要な場合に行う。単純な整形・翻訳では、依頼の達成に不要な検索や確認質問を増やさない。',
            '- 高リスク領域の点検は、誤りの影響が大きい文脈に適用する。通常の回答に長い定型免責文を付けることを目的にしない。',
            '- 市場・企業・製品分析は、関連する分析・比較の依頼に適用する。無関係な依頼に3CやSWOTなどの分析枠組みを持ち込まない。',
            '- 読み手・聴衆中心の構成は、資料作成、説明、提案に適用する。短い事実確認や指定形式の変換に、不要な導入や次の行動を付け足さない。',
            '- 社内文脈と決定履歴は、依頼の結論に関係する場合に確認する。社内文脈が不要な依頼では社内検索を要求しない。',
            '- 厳密さは回答の長さではなく、必要な確認、根拠と推論の区別、未確認事項の明示で確保する。実行していない確認を実行済みとしない。'
        ) -join "`n"
        PresetNotes      = 'このページはセット共通の適用方針に続けて、個別項目の本文を番号順に省略せず連結して自動生成しています。直接編集せず、元の項目または生成スクリプト内の適用方針・組み合わせを変更して再生成してください。手順は[コントリビューションガイド](../../../CONTRIBUTING.md)を参照してください。'
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
        PresetPolicy     = @(
            '# How to apply this set', '',
            '- Treat the following instructions as standing guidance, applying them when their conditions are relevant to the request. Not every request requires every research step, analysis, or document structure.',
            '- Research, source comparison, entity verification, and quantitative checks apply when factual verification is needed. Do not add searches or clarification questions unnecessary to completing simple formatting or translation requests.',
            '- Apply high-risk checks where errors could have serious consequences. Their purpose is not to append long boilerplate disclaimers to ordinary responses.',
            '- Apply market, company, and product analysis to relevant analytical or comparison requests. Do not impose frameworks such as 3C or SWOT on unrelated tasks.',
            '- Apply audience-first structure to documents, explanations, and proposals. Do not append unnecessary introductions or next steps to short factual answers or requested format conversions.',
            '- Check work context and decision history when they affect the conclusion. Do not require internal searches for requests that do not need work context.',
            '- Achieve rigor through necessary verification, separation of evidence from inference, and disclosure of unknowns, not through response length. Never describe checks that were not performed as completed.'
        ) -join "`n"
        PresetNotes      = 'This page is generated by placing shared application guidance before the complete source instructions in numerical order. Do not edit it directly; update the source modules or the application guidance and combinations in the generator and regenerate. See the [contribution guide](../../../CONTRIBUTING.md#english).'
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
                "## $($label.Heading)", '', '```text', $label.PresetPolicy, '', $presetBody, '```', '',
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
