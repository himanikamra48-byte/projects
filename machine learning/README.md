# Election Outcome Prediction & Presidential Speech Text Analysis

A two-part machine learning project completed as part of the Post Graduate Program in Data Science & Business Analytics (Great Lakes Executive Learning). Part 1 builds and compares classification models to predict voter behavior; Part 2 applies core NLP preprocessing techniques to analyze presidential inaugural speeches.

## Part 1 — Election Data: Voter Party Prediction

**Problem statement:** A news channel (CNBE) wants to predict which party a voter will vote for — Conservative or Labour — based on survey responses from 1,525 voters, in order to build an exit poll model.

**Dataset:** 1,525 rows × 9 features, including age, assessment of national/household economic conditions, leader approval ratings (Blair, Hague), attitude toward European integration, political knowledge, and gender.

### Workflow

1. **Data cleaning & EDA**
   - Checked for null values (none found) and duplicate records (8 duplicates dropped → 1,517 rows)
   - Descriptive statistics, univariate and bivariate analysis (histograms, KDE plots, countplots, pairplot, correlation heatmap, boxplots)
   - Outlier check via boxplots

2. **Preprocessing**
   - Label-encoded the target variable (`vote`) and one-hot encoded `gender`
   - Applied z-score scaling where required (LDA, KNN)
   - 70:30 train-test split

3. **Modeling — six algorithms compared**
   - Logistic Regression
   - Linear Discriminant Analysis (LDA)
   - Naive Bayes
   - K-Nearest Neighbors (KNN), tuned via GridSearchCV (`n_neighbors=17`, `weights='distance'`)
   - Bagging (Random Forest as base estimator, `n_estimators=50`)
   - AdaBoost and Gradient Boosting

4. **Evaluation**
   - Accuracy, confusion matrix, ROC curve, and ROC-AUC score for every model, on both train and test sets
   - Compared precision/recall across all models for the Labour class

### Key Results

| Model | Precision (test) | Recall (test) |
|---|---|---|
| Logistic Regression | 0.86 | 0.88 |
| LDA | 0.86 | 0.89 |
| Naive Bayes | 0.87 | 0.87 |
| KNN (tuned) | 0.85 | 0.89 |
| Bagging (Random Forest) | 0.85 | 0.91 |
| AdaBoost | 0.86 | 0.87 |
| Gradient Boosting | 0.85 | 0.91 |

**Conclusion:** Logistic Regression, LDA, Naive Bayes, and the boosting models all generalize well between train and test sets with no significant overfitting. Bagging showed the strongest recall but slight overfitting (train precision 0.96 vs. test 0.85). Gradient Boosting offered the best balance of performance and generalization.

**Business insight:** Voter economic sentiment and leader approval ratings are the strongest behavioral signals; older voters lean more Conservative, and no strong multicollinearity exists among predictors.

## Part 2 — NLP: Presidential Inaugural Speech Analysis

**Dataset:** Inaugural addresses of three U.S. presidents (via NLTK's inaugural corpus):
- Franklin D. Roosevelt (1941)
- John F. Kennedy (1961)
- Richard Nixon (1973)

### Workflow

1. **Text statistics** — computed total character, word, and sentence counts across all three speeches using NLTK tokenizers
2. **Stopword removal** — cleaned all three speeches using NLTK's English stopword list and punctuation filtering
3. **Word frequency analysis** — identified the top 3 most frequent words in each speech after cleaning

### Results — Top words per speech (post stopword removal)

| President | Top 3 tokens |
|---|---|
| Roosevelt (1941) | "the", "of", "," |
| Kennedy (1961) | ",", "the", "of" |
| Nixon (1973) | ",", "the", "." |

*(Punctuation tokens indicate an opportunity to extend the cleaning pipeline with punctuation stripping before frequency ranking — noted as a future improvement.)*

## Tools & Libraries

`Python` · `Pandas` · `NumPy` · `Matplotlib` / `Seaborn` · `scikit-learn` (Logistic Regression, LDA, Naive Bayes, KNN, Bagging, AdaBoost, GradientBoosting, GridSearchCV, metrics) · `NLTK` (inaugural corpus, stopwords, tokenization)

## Files

- `Machine_Learning_Project.ipynb` — full notebook (both problems)
- `Machine_Learning_Project_Report.pdf` — formatted write-up with all figures and tables
- `Election_Data.xlsx` — source dataset for Part 1

- Address class imbalance in the election dataset (Labour is over-represented) using SMOTE or class-weighting
- Strip punctuation before word-frequency ranking in Part 2 for more meaningful top-word results
- Extend Part 2 with sentiment analysis or TF-IDF-based comparison across the three speeches
