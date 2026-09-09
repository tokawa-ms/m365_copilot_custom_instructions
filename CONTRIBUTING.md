# 指示の追加・修正

[日本語](#指示の追加修正) · [English](#english) · [ホーム](readme.md)

この指示集は、利用者が目的に合う項目だけを選べる形を維持します。組織固有の規程や機密情報ではなく、一般に共有できる応答方針を対象にしてください。

## ファイル構成

1項目につき `instructions/ja` と `instructions/en` に同名のフォルダを作り、それぞれの `README.md` に次の内容を記載します。

- 項目名と、どのような場面で役立つか。
- 「コピー用の指示」：見出し付きの本文を、1つの `text` コードブロックにまとめる。
- 「調整のポイント」：任意の変更点や、利用上の注意。コピー用本文の外に記載する。

フォルダ名は2桁の番号と英語のケバブケースにします。既存項目の番号やパスは、リンクを維持するため不用意に変更しないでください。追加や統合を行ったら、`readme.md` と `readme-en.md` の一覧と組み合わせ例も更新します。収録数が変わった場合は、バッジと `assets/banner.svg` の件数も揃えます。

英語版では「Instructions to copy」「Customization notes」を使い、条件、例外、安全上の注意を省略せずに翻訳します。対象読者に応じて既定値を変える場合は、09の回答言語のように各言語版での動作差を明記してください。言語切り替えとホームへのリンクもコードブロックの外に置きます。

## 本文の書き方

`00-all`は個別項目ではなく、全項目の生成済み一括版です。各言語の番号付きフォルダ（`00-all`を除く）のコピー用本文を番号順に連結し、`00-all/custom-instructions.md`と`00-all/README.md`を生成します。一括版は直接編集せず、個別項目を修正した後、リポジトリのルートで次を実行して生成物も変更に含めてください。PowerShell 7以降を使用します。

```powershell
pwsh -File .\scripts\Update-AllInstructions.ps1
pwsh -File .\scripts\Update-AllInstructions.ps1 -Check
```

`-Check`はファイルを変更せず、個別項目との不一致や生成物の欠落がある場合にエラーを返します。01〜21の21項目を収録し、00の一括版はモジュール数に加算しません。16は社内文脈の共通項目、17〜21は職種別の5項目です。

各言語の `presets/` にある職種別5セットも同じスクリプトで生成・検査します。新規モジュールには数えません。組み合わせは `scripts/Update-AllInstructions.ps1` の `$baseModules` と `$presets` で定義し、変更時は日英のトップページのおすすめ表も更新してください。セットの本文は個別項目から生成し、直接編集しないでください。

他の項目の選択を前提にせず、単独で意味が通る文章にしてください。「別のルールを参照」とだけ書くのではなく、その項目に必要な条件や例外を短く記載します。特に合成データと実在の事実、設計案と既存仕様を区別してください。

「必ず検索できる」「この設定で誤りを防げる」といった機能や効果の保証は避けます。必要な機能が使えない場合は、その制約を示す方針にします。製品の制約や組織ポリシーを上書きする指示も含めません。

形式を整えることより、正確性と読み手の目的を優先します。長い免責文や同じ注意書きを増やすのではなく、判断に必要な条件を具体的に書いてください。

## 変更時の確認

- コードブロックだけをコピーして、用途と適用条件が読み取れる。
- 単独利用と、関連する項目との併用の両方で矛盾しない。
- 未確認の情報を事実として補完するよう求めていない。
- 企業名、人物名、数値、画面例、ファイルのメタデータに非公開情報が含まれていない。
- 他者の文章や資料を使う場合、公開・再配布の権利と必要な出典表示を確認している。
- 項目へのリンクが正しく、説明とコピー用本文が分離されている。
- 日英で同じ項目が揃い、適用条件と例外が一致している。

回答例を添える場合は、公開可能な情報か合成データを使ってください。実際の顧客との会話や社内資料を、そのままIssueやPull Requestに貼り付けないでください。

公開前にはファイルだけでなく、Gitの履歴や添付物にも非公開情報が残っていないか確認します。このプロジェクトは [MIT License](LICENSE) で提供されています。貢献する内容がこのライセンスで配布可能であることを確認してください。

## English

[日本語](#指示の追加修正) · [Home](readme-en.md)

Keep this collection modular so readers can choose only what they need. Contributions should describe broadly reusable response preferences, not internal policies or confidential information.

### File structure

Create a matching topic directory under both `instructions/ja` and `instructions/en`. Each `README.md` contains:

- A title and a short explanation of when the module is useful.
- “Instructions to copy”: one `text` code block containing the complete instruction and its heading.
- “Customization notes”: optional adjustments and usage notes outside the copyable block.

Use a two-digit number and an English kebab-case slug for each directory. Keep existing paths stable. Update both root READMEs when adding or combining topics, and update module counts in the badges and `assets/banner.svg` when needed. Keep language-switch and home links outside instruction blocks.

### Writing and translation

`00-all` is a generated combined edition, not an additional module. The generator joins the copyable blocks from each language's numbered topic directories, excluding `00-all`, in numerical order. It writes both `00-all/custom-instructions.md` and `00-all/README.md`. Edit the individual modules instead of the generated files, then run these commands from the repository root using PowerShell 7 or later and include the regenerated files in your change:

```powershell
pwsh -File .\scripts\Update-AllInstructions.ps1
pwsh -File .\scripts\Update-AllInstructions.ps1 -Check
```

`-Check` does not modify files and fails if generated files are missing or out of sync. The collection contains 21 individual modules, 01–21; the combined edition does not count as an extra module. Module 16 provides shared work-context guidance, and 17–21 are the five role-specific modules.

The same script generates and checks the five role sets in each language's `presets/` directory. They do not count as new modules. Define combinations in `$baseModules` and `$presets` in `scripts/Update-AllInstructions.ps1`, and update the recommended-set tables in both root READMEs when changing them. Edit source modules rather than generated set content.

Each module must work on its own. Include the conditions and exceptions it needs instead of relying on another module being selected. In particular, distinguish synthetic data from real-world facts and proposed designs from existing specifications.

Translate the complete meaning, including limitations and safety provisions. If a default is intentionally localized for its audience, document the behavioral difference between editions. Module 09, for example, defaults summaries to Japanese in the Japanese edition, while the English edition follows the language of the user's request unless explicitly directed otherwise.

Do not promise capabilities or outcomes such as guaranteed search access or error prevention. State how to handle unavailable information or features. Instructions must not claim to override product constraints or organizational policies.

Prioritize accuracy and reader goals over elaborate formatting. Use specific conditions rather than accumulating repetitive disclaimers.

### Before submitting

- Check that the copyable block makes sense without the surrounding explanation or other modules.
- Keep the Japanese and English topic sets, conditions, and exceptions aligned.
- Avoid encouraging unverified claims or contradictory behavior when modules are combined.
- Check relative links and keep explanations separate from instructions.
- Use only public information or synthetic data in examples; never paste real customer conversations or internal documents into issues or pull requests.
- Check names, numbers, screenshots, metadata, attachments, and Git history for nonpublic information before publishing.
- Confirm that you have permission to redistribute any contributed material under the project's [MIT License](LICENSE), and preserve required attribution.
