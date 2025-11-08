# 🧬 rwe-survival  
### Survival Analysis with SUS Data — Brazilian Real-World Evidence 

[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?logo=rstudio)](https://rstudio.com/)

> **Real-world evidence for public health policy in Brazil**  
> An open-source project for survival analysis using simulated data (ready to be replaced by real DATASUS data), focusing on regional and demographic disparities.**.

---

## 🎯 Objective

To develop a comprehensive survival analysis featuring:

- ✅ Kaplan-Meier models by geographic region**  
- ✅ Stratification by age group (Young / Adult / Elderly)  
- ✅ Professional 2D visualizations (ggsurvplot) + interactive 3D surfaces (plotly)  
- ✅ Modular, reproducible, and well-documented code

👉 **Differential factor**: While most projects rely on idealized clinical data, this one explores realistic scenarios — with censoring, demographic variation, and the SUS structure — paving the way for future integration with real-world data.

---

## 📊 Main Results

| Analysis | Plot | Insight |
|--------|---------|---------|
| **Survival by region** | ![KM Região](img1.png) | Overlapping curves (p = 0.97) → no significant difference among regions (as expected in the simulation)* |
| **Survival by age group** | ![KM Idade](img2.png) | **Elderly individuals show lower survival** — a critical factor for public health policy |
| **3D Surface: age × time × survival** | ![Superfície 3D](img3.png) | Steep decline within the first 250 days, especially among elderly participants |

> 💡 *All plots are interactive via plotly or ready for high-resolution export.*

---

## 🧪 Technologies Used

| Category | Packages |
|---------|---------|
| **Modeling** | `survival`, `broom` |
| **Data Manipulation** | `dplyr`, `lubridate` |
| **2D Visualization** | `ggplot2`, `survminer` |
| **3D Visualization** | `plotly` |
| **Reporting** | `rmarkdown` (pronto para integração) |
