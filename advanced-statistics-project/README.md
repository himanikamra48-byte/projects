
# Advanced Statistics: ANOVA & Principal Component Analysis

Statistical analysis project covering hypothesis testing (ANOVA) and dimensionality reduction (PCA), completed as part of the PGP-DSBA program (Great Lakes Executive Learning).

## Objective
Two independent business analytics problems:
1. **ANOVA** — Determine whether an employee's salary is influenced by education level, occupation, or the interaction between the two.
2. **PCA** — Reduce a 17-feature college admissions dataset (777 universities) into a smaller set of uncorrelated components for further analysis, while retaining most of the variance.

## Datasets
| Dataset | Rows | Columns | Description |
|---|---|---|---|
| `SalaryData.csv` | 40 | 3 | Salary, Education, Occupation for 40 individuals |
| `Education - Post 12th Standard.csv` | 777 | 18 | Admissions & financial data for US colleges |

## Methods
- **One-way ANOVA** — Salary ~ Education, Salary ~ Occupation
- **Interaction plot** — visualizing Education × Occupation effects
- **Two-way ANOVA** — Salary ~ Education + Occupation + Education:Occupation
- **Exploratory Data Analysis** — univariate distributions, correlation heatmaps
- **Feature scaling** — z-score standardization (required before PCA due to differing feature scales)
- **PCA** — eigenvalue/eigenvector extraction, scree plot, cumulative explained variance, component selection

## Key Findings
- Education has a statistically significant effect on salary (p < 0.05); occupation alone does not (p = 0.459), but the two factors have a significant **interaction effect** — salary depends on the *combination* of education and occupation.
- 17 correlated college features were reduced to **7 principal components** capturing ~85% of total variance, resolving multicollinearity for downstream modelling.

## Tools
Python · Pandas · NumPy · Matplotlib · Seaborn · Statsmodels · Scikit-learn (PCA) · SciPy

## Files
- `advanced_statistics_project.ipynb` — full annotated analysis
- `SalaryData.csv`, `Education - Post 12th Standard.csv` — datasets
- `Advanced_statistics_project.pdf` — formatted business report


