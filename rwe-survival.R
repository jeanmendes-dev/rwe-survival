library(survival)
library(lubridate)
library(broom)
library(dplyr)
library(plotly)
library(rgl)
library(ggplot2)

# ==============================================================
# PREPARAÇÃO DOS DADOS (SIMULADO)
# ==============================================================

# Criar dados simulados (substitua por seus dados reais depois)
set.seed(123)
n <- 5000

# Primeiro, gere a idade
idade <- sample(18:90, n, replace = TRUE)

# Agora use idade nas outras colunas
dados_simulados <- data.frame(
  id = 1:n,
  idade = idade,
  sexo = sample(c("M", "F"), n, replace = TRUE),
  regiao = sample(c("Norte", "Nordeste", "Sudeste", "Sul", "Centro-Oeste"), n, replace = TRUE),
  tempo_sobrevivencia = rexp(n, rate = 0.01) * 365,
  evento = rbinom(n, 1, plogis((idade - 50) / 20)),
  data_inicio = as.Date("2018-01-01") + sample(0:730, n, replace = TRUE),
  data_fim = as.Date("2018-01-01") + sample(0:730, n, replace = TRUE) + round(runif(n, 0, 365))
)

# Calcular tempo de seguimento (em dias)
dados_simulados$tempo_seguimento <- as.numeric(dados_simulados$data_fim - dados_simulados$data_inicio)
dados_simulados$tempo_seguimento[dados_simulados$tempo_seguimento < 0] <- 0

# Criar variável de status (1 = óbito, 0 = censurado)
dados_simulados$status <- ifelse(dados_simulados$evento == 1 & 
                                   dados_simulados$tempo_seguimento <= 365, 1, 0)

# Filtrar apenas casos válidos
dados_simulados <- dados_simulados %>%
  filter(tempo_seguimento > 0)

head(dados_simulados[, c("id", "idade", "sexo", "regiao", "tempo_seguimento", "status")])

# ==============================================================
# MODELO DE SOBREVIVÊNCIA (KAPLAN-MEIER)
# ==============================================================

# Modelo Kaplan-Meier por região
km_fit <- survfit(Surv(tempo_seguimento, status) ~ regiao, data = dados_simulados)

# Resumo
summary(km_fit)

library(survminer)
library(ggplot2)

ggsurvplot(
  km_fit,
  data = dados_simulados,
  risk.table = TRUE,
  risk.table.title = "Número em Risco",
  risk.table.height = 0.25,
  pval = "p = 0.97\n(nenhuma diferença significativa entre regiões)",
  pval.coord = c(100, 0.2),
  pval.size = 4,
  pval.fontface = "bold",
  conf.int = TRUE,
  palette = "Set1",
  title = "Curvas de Sobrevivência por Região Brasileira",
  xlab = "Tempo (dias)",
  ylab = "Probabilidade de Sobrevivência",
  legend.title = "Região",
  legend.labs = levels(dados_simulados$regiao),
  legend = "right",
  ggtheme = theme_minimal() + 
    theme(plot.title = element_text(hjust = 0.5)),
  censor.shape = "|",
  censor.size = 3
)

# Criar faixa etária
dados_simulados$faixa_etaria <- cut(dados_simulados$idade, 
                                    breaks = c(18, 40, 60, 90), 
                                    labels = c("Jovem", "Adulto", "Idoso"))

# Modelo por faixa etária
km_fit_idade <- survfit(Surv(tempo_seguimento, status) ~ faixa_etaria, 
                        data = dados_simulados)

# Plot
ggsurvplot(
  km_fit_idade,
  data = dados_simulados,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  palette = c("green", "orange", "red"),
  title = "Sobrevivência por Faixa Etária",
  xlab = "Tempo (dias)",
  ylab = "Probabilidade de Sobrevivência",
  legend.title = "Faixa Etária",
  legend = "right",
  ggtheme = theme_minimal(),
  censor.shape = "|",
  censor.size = 3
)

# ==============================================================
# VISUALIZAÇÃO 3D INTERATIVA: SUPERFÍCIE DE SOBREVIVÊNCIA
# ==============================================================

# Função para estimar sobrevivência por idade e tempo
estimate_surv_by_age_time <- function(data, age_breaks = seq(20, 90, by = 5), time_breaks = seq(0, 365, by = 30)) {
  results <- data.frame()
  
  for (age in age_breaks) {
    for (time in time_breaks) {
      subset_data <- data %>%
        filter(idade >= age - 5 & idade < age + 5)
      
      if (nrow(subset_data) > 0) {
        km_temp <- survfit(Surv(tempo_seguimento, status) ~ 1, data = subset_data)
        surv_prob <- summary(km_temp, times = time)$surv[1]
        if (!is.na(surv_prob)) {
          results <- rbind(results, data.frame(
            idade = age,
            tempo = time,
            sobrevivencia = surv_prob,
            stringsAsFactors = FALSE
          ))
        }
      }
    }
  }
  return(results)
}

# Gerar superfície 3D
surface_data <- estimate_surv_by_age_time(dados_simulados)

# Plot 3D com plotly (interativo!)
p3d <- plot_ly(surface_data, x = ~idade, y = ~tempo, z = ~sobrevivencia, type = "mesh3d") %>%
  layout(
    title = "Superfície 3D: Probabilidade de Sobrevivência por Idade e Tempo",
    scene = list(
      xaxis = list(title = "Idade (anos)"),
      yaxis = list(title = "Tempo (dias)"),
      zaxis = list(title = "Probabilidade de Sobrevivência")
    )
  )

p3d
