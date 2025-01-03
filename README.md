# Forest Plot

### Overview
This repository provides an example of a forest plot inspired by Katherine Hoffman's work (reference). The plot visualizes the **Incidence Rate Ratios (IRR)** and their corresponding **95% Confidence Intervals (CI)** for three acute lymphoblastic leukemia (ALL) risk groups:
1. **Neutral**
2. **Favorable**
3. **Unfavorable**

### Features
- **Visual Representation:** Clearly shows the IRR and CI for each risk group, allowing easy comparison.
- **Customizations:** Demonstrates how to fine-tune plot aesthetics, such as axis labels, annotations, and error bar styles.
- **Reproducible Code:** Includes script for plot generation using R.

### Prerequisites
Ensure you have R installed. Required R packages:
- `ggplot2`
- `dplyr`
- `readr`

Install these packages using:
```R
install.packages(c("ggplot2", "dplyr", "readr"))
