# Gem Price Prediction & Holiday Package Classification

Two predictive modelling problems: linear regression for gemstone pricing, and classification (Logistic Regression vs. LDA) for holiday package uptake prediction.

## Problem 1: Gem Price Prediction (Linear Regression)

**Objective:** Predict cubic zirconia (gemstone) price from physical attributes for a gemstone manufacturer, to distinguish higher-profit stones from lower-profit ones and identify the top 5 price-driving attributes.

**Dataset:** `cubic_zirconia.csv` — ~27,000 stones, 10 features (Carat, Cut, Color, Clarity, Depth, Table, X, Y, Z, Price)

**Approach:**
- Cleaned duplicates (34 rows) and imputed missing `depth` values (median)
- Combined categorical sub-levels (e.g. Cut: Good + Very Good → Good) to reduce dimensionality
- Ordinal-encoded Cut, Color, Clarity by their natural quality order
- Built and compared 3 linear regression models (with/without outlier treatment, with/without combined sub-levels)

**Result:** Best model (outliers removed, full categorical granularity) achieved **Adj. R² = 0.94** — 94% of price variance explained. **Carat** is the strongest price driver, followed by cut quality and stone width.

## Problem 2: Holiday Package Prediction (Logistic Regression & LDA)

**Objective:** Predict whether an employee will opt for a holiday package for a tour & travel agency, and identify which factors sales should focus on.

**Dataset:** `Holiday_Package.csv` — 872 employees, 7 features (Salary, age, education, number of young/older children, foreign national status)

**Approach:**
- No missing values or duplicates; label-encoded target and `foreign` variable (no scaling, per spec)
- 70:30 train-test split; class distribution nearly balanced (~53%/47%)
- Built and compared Logistic Regression vs. Linear Discriminant Analysis (LDA)

**Result:** **LDA outperformed Logistic Regression** on every metric — test accuracy 0.641 vs. 0.530, ROC-AUC 0.703 vs. 0.627, and critically, recall on package-takers 0.56 vs. 0.09. LDA selected as the final model.

## Business Recommendations
- **Gems:** Weight carat and cut quality most heavily in profit-margin pricing strategy
- **Holiday packages:** Prioritize recall (catching likely buyers) over raw accuracy; segment promotional offers by salary range, since salary is one of the stronger individual predictors

## Tools
Python · Pandas · NumPy · Matplotlib · Seaborn · Scikit-learn (Linear/Logistic Regression, LDA) · Statsmodels

## Files
- `predictive_modelling_project.ipynb` — full analysis (both problems)
- `cubic_zirconia.csv`, `Holiday_Package.csv` — datasets
- `Predictive_modelling_project.pdf` — formatted business report
