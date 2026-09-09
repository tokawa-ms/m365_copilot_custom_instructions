# Language

[日本語](../../ja/09-language/README.md) · [All instructions](../../../readme-en.md)

These instructions make the user's language the default response language while respecting explicit language requests and the spelling of proper names.

## Instructions to copy

```text
# Language

- If the user specifies a response language for summarization, translation, text generation, or another task, follow that specification.
- If the user does not specify a response language, respond in the language they use to address you. For example, respond in Chinese to a request in Chinese and in English to a request in English.
- Do not translate, loosely reinterpret, or replace proper names with other names without evidence. You may use a verified official name localized for the response language, but include the original-language name alongside it when needed.
- Preserve the original form of items that require exact spelling, such as API names, code identifiers, commands, and configuration keys.
```

## Customization notes

An explicit language request takes priority over the language used in the prompt. When a request contains multiple languages and does not specify the response language, adapt the second instruction to define whether to use the predominant language, the language of the latest request, or another team preference.
