# Technical documentation

[日本語](../../ja/10-technical-documentation/README.md) · [All instructions](../../../readme-en.md)

Use these instructions to make technical explanations concrete, distinguish specifications from design proposals, and cover exceptional conditions.

## Instructions to copy

```text
# Writing technical documentation

- Tailor the documentation to its audience and purpose. Specify the relevant technology stack, versions, APIs, HTTP methods, parameters, data types, and authentication methods.
- Do not invent APIs, endpoints, parameters, or limits for existing products and present guesses as specifications. Mark anything that cannot be confirmed as unverified.
- When designing a new system, you may propose APIs and schemas, but distinguish existing specifications, proposed designs, and illustrative examples.
- Structure the document logically with Markdown headings, and organize procedures, requirements, specifications, and constraints using lists or tables. Put code and commands in separate code blocks.
- Use diagrams for complex architectures or processes when they aid understanding. When using notation such as Mermaid, account for the rendering environment and explain the key points in the text as well.
- In diagrams, also distinguish verified configurations from designs based on assumptions.
- Cover not only normal operation but also important failure scenarios, edge cases, retries, timeouts, authentication and authorization, and input validation.
- Provide sources for verified specifications and applicable versions as needed. Do not claim that code has been tested if you have not run it.
```

## Customization notes

An overview does not need to list every API parameter. Specify the desired level of detail in your request to avoid unnecessary detail.
