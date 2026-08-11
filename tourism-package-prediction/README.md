# Tourism Package Prediction (Capstone Project)

Predictive modelling project for an aviation company aiming to shift from generic tele-calling to a targeted digital marketing approach — predicting which customers are most likely to purchase a tourism package based on their social media behaviour.

## Objective
Predict `Taken_product` (whether a customer purchases a tourism package) using customer digital/social engagement data, so ads can be targeted at customers with the highest purchase propensity — rather than reaching out to every customer equally.

## Dataset
`Social Media Data for DSBA.csv` — 11,760 customers, 17 original features covering:
- Digital engagement (page views, likes, comments, minutes spent on travel-related pages)
- Travel behaviour (outstation check-ins, preferred location type, travel network rating)
- Demographics (family size, adult flag, working status)
- Platform preference (device used to log in)

Target class is imbalanced: ~16% of customers took the product, ~84% did not.

## Approach
1. **Data cleaning** — dropped high-missing-value columns, fixed data-entry anomalies (e.g. `"Three"` in a numeric field), standardized inconsistent categorical labels
2. **Missing value imputation** — median imputation for numeric columns
3. **EDA** — univariate and bivariate analysis to understand distributions and purchase drivers
4. **Feature encoding** — nominal encoding for categorical variables
5. **Model building** — trained and compared 5 classifiers: Naive Bayes, Naive Bayes + SMOTE, Bagging, Gradient Boosting, Random Forest
6. **Model selection** — Random Forest selected as best performer based on precision (the key metric, given class imbalance and the cost of false-positive ad targeting)

## Key Results
| Model | Precision (Class 1, Test) | Accuracy (Test) |
|---|---|---|
| Naive Bayes | 0.40 | 0.82 |
| Bagging | 0.98 | 0.97 |
| Gradient Boosting | 0.85 | 0.88 |
| **Random Forest (selected)** | **0.99** | **0.95** |
| Naive Bayes + SMOTE | 0.23 | 0.55 |

**Top predictor across all tree-based models:** `working_flag` — whether the customer is currently employed.

## Business Recommendations
- Bundle top travel preferences (Beach + Financial) into combined packages
- Use richer ad formats for laptop users, who show higher conversion
- Target working professionals with loyalty offers, given their higher travel frequency
- Prioritize the company's own page (followers convert more) for offers and UX improvements

## Tools
Python · Pandas · NumPy · Matplotlib · Seaborn · Scikit-learn (Naive Bayes, Bagging, Gradient Boosting, Random Forest) · imbalanced-learn (SMOTE)

## Files
- `capstone_project.ipynb` — full analysis
- `Social Media Data for DSBA.csv` — dataset
- `Final_report_capstone_project.pdf` — formatted business report
