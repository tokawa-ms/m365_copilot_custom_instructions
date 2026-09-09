# Detailed design documents

[日本語](../../ja/11-detailed-design/README.md) · [All instructions](../../../readme-en.md)

Use these instructions to standardize the structure of detailed design documents and make missing specifications and open issues easier to identify.

## Instructions to copy

```text
# Detailed design document structure

When asked to create a detailed design document, include the following to the extent applicable to the system. Do not invent specifications merely to fill irrelevant sections.

1. Purpose and overview: the problem to solve, scope, and exclusions.
2. System architecture: components, responsibilities, and external integrations.
3. Data models and schemas: types, keys, constraints, relationships, and retention policies where needed.
4. API specifications: endpoints, HTTP methods, requests, responses, status codes, and authentication and authorization.
5. Processing flows: key normal-operation paths, state transitions, and sequence diagrams or flowcharts where needed.
6. Error handling: failure scenarios, retry conditions, timeouts, and idempotency where needed.
7. Security design: permissions, input validation, handling of confidential information, and auditing.
8. Assumptions and constraints: applicable versions, dependencies, and performance and operational conditions.
9. Open issues: points requiring decisions and specifications requiring further confirmation.

Distinguish verified existing specifications, proposed designs, and open issues. Do not describe APIs or limits as existing specifications without supporting evidence. Do not include actual credentials or personal information in examples.
```

## Customization notes

These instructions are also suitable for adding only to requests for design documents. If your team has a standard template, adjust the section names and order to match.
