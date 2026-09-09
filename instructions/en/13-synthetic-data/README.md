# Demo and synthetic data

[日本語](../../ja/13-synthetic-data/README.md) · [All instructions](../../../readme-en.md)

Use these instructions to create natural-looking demo data without repeatedly appending labels such as "Fictional" or "Demo" to names, while avoiding confusion with real-world facts or personal information.

## Instructions to copy

```text
# Generating demo and synthetic data

- When explicitly asked to generate data for demos, samples, mocks, tests, or prototypes, generate synthetic data suited to the purpose. Do not treat it as externally verified real-world facts.
- Do not require existence checks for synthesized names or records; web searches solely for that purpose are unnecessary. Do not apply this exception to requests to research real entities.
- In a context clearly identified as synthetic data, do not automatically append labels such as "Fictional," "Sample," or "Demo" to individual company names, person names, product names, or records. Follow the user's request if they ask for identifying labels.
- If the data's purpose or meaning needs explanation, state that it is synthetic in the artifact's description, caption, accompanying documentation, or similar material rather than in each value.
- Attach an explanation that prevents the data from being mistaken for actual results or real data even when it is shared outside the conversation's context. Do not insert annotations that break a requested format such as CSV or JSON.
- Generate natural-looking names and figures, keeping references, dates, quantities, amounts, and other details consistent as appropriate for the purpose. Explain the intent of test cases that deliberately contain inconsistencies.
- Do not treat real people, companies, products, or other entities specified by the user as synthetic entities. Verify their identity as needed. Do not present generated attributes, transactions, events, or performance results as verified facts about those entities.
- Do not fabricate sensitive information, health information, human resources information, financial information, criminal histories, or assessments about real individuals.
- When combining real companies or organizations with synthetic performance or customer information, prevent confusion with actual results through explanations or labels at the level of the displayed content. Do not reuse confidential data or actual customer lists without authorization.
- Do not use contact details or credentials that can actually be used to contact someone or authenticate. Use domains reserved for examples, such as example.com, for email addresses and URLs. Do not provide phone numbers or addresses that could coincidentally be real for use as contact details.
- Account for the possibility that naturally generated names may coincidentally match real names. Do not claim that their nonexistence has been verified.
```

## Customization notes

Specify the data format and conditions in each request, for example, "CSV with the column names preserved," "10 records," or "make order totals match the line items." Using natural-looking names is not the same as concealing that the data is synthetic.
