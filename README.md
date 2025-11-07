# 🧬 rwe-survival  
### Análise de Sobrevivência com Dados Reais do SUS (Sistema Único de Saúde)  

[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?logo=rstudio)](https://rstudio.com/)

> **Real-World Evidence (RWE) aplicada à saúde pública brasileira**:  
> Um projeto *open-source* para análise de sobrevida usando dados públicos do **DATASUS**, com visualizações 3D interativas, modelos de risco e foco em disparidades regionais.

---

## 🎯 Objetivo

Desenvolver uma **análise robusta de sobrevivência** com dados reais do SUS, combinando:
- Modelagem estatística (Kaplan-Meier, Cox PH)
- Visualizações 3D (mapas geográficos, superfícies de risco)
- Foco em **diferenciação local**: disparidades por região, idade e perfil demográfico.

👉 **Diferencial**: Enquanto muitos estudos usam dados clínicos controlados, este projeto explora **evidência do mundo real brasileiro** — com dados reais, limitações reais e insights aplicáveis à política pública.

---

## 📊 Principais Recursos

| Funcionalidade | Tecnologia | Exemplo |
|----------------|------------|---------|
| ✅ Curvas de sobrevivência por região | `survival`, `survminer` | ![KM](docs/curvas_km.png) |
| 🌍 Mapa 3D do Brasil com mortalidade | `rgl` | ![Mapa](docs/mapa_3d.png) |
| 📈 Superfície 3D: sobrevivência × idade × tempo | `plotly`, `rgl` | ![Superfície](docs/superficie_3d.png) |
| 📋 Tabelas de risco e p-valores | `broom`, `dplyr` | — |
| 📤 Exportação para relatórios (PNG, HTML, PDF) | `knitr`, `rmarkdown` | — |

---

## 🧪 Dados Utilizados

- **Fonte**: [DATASUS — Ministério da Saúde](https://datasus.saude.gov.br/)
- **Bancos sugeridos**:
  - **SIH-RD**: Autorizações de internação hospitalar
  - **SIM**: Sistema de Informação de Mortalidade
  - **SINASC**: Nascidos vivos (para estudos de coorte)
- ⚠️ *Este repositório inclui dados simulados para demonstração. Substitua por dados reais para análise oficial.*

---

## 🚀 Como Usar

### Pré-requisitos
```r
install.packages(c("survival", "survminer", "dplyr", "rgl", "plotly", "lubridate", "broom"))
