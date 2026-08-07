# Insurance Claims Dashboard (Tableau)

Interactive Tableau dashboards analyzing auto insurance claims data, built to deliver leadership-level insights for policy and risk decisions.

🔗 **[View the live Tableau Public story](https://public.tableau.com/app/profile/himani.kamra/viz/projectDVT_16640957884900/Story1?publish=yes)**

## Objective
Analyze driver, vehicle, and claims data to surface patterns in claim frequency and claim amount — supporting data-driven underwriting and policy decisions.

## Dataset
`Car_claims_for_insurance.xlsx` — 7,647 records, 21 fields (see the `Dictionary` sheet in the file for full field definitions):

| Category | Fields |
|---|---|
| Driver demographics | Birth date, Gender, Education, Occupation, Marital status (`MSTATUS`), Single parent (`PARENT1`), Kids at home/driving age |
| Financial | Income, Home value, Years on job |
| Vehicle | Car type, Bluebook value, Car age, Car use (Private/Commercial) |
| Claims history | Claim frequency (`CLM_FREQ`), Claim amount (`CLM_AMT`), Prior claims (`OLDCLAIM`) |
| Other | Commute time (`TRAVTIME`), Urbanicity |

## What the dashboard covers
Interactive Tableau visualizations exploring how claim frequency and claim amount vary by driver and vehicle attributes — built as a multi-view Tableau "Story" for leadership-facing presentation.

## Tools
Tableau Public (dashboard design, storytelling) · Excel (source data)

## Files
- `Car_claims_for_insurance.xlsx` — dataset + data dictionary
- Tableau workbook — published on Tableau Public (see link above); embed or download from there
