# ==============================================================================
# Projeto: Cálculo Estatisticos da aplicação Leitor CSV utilizando Python Puro
# Script: 02_medidas_de_dispersao.R (Adaptado para Joules)
# Descrição: Calcula as medidas de dispersão 
#            para a variável de consumo de energia (em Joules).
#
# Aluno: Everton Cezar Gonçalves
#        Caio Henrique dos Santos
#        Marcio Marcos
#        João Pedro Guez de Oliveira
# Disciplina: Software Verde (Green Software) - Mestrado UTFPR
# Professor: Michel Albonico
# =============================================================================

source("00_setup_e_dados.R") 
source("01_medidas_de_posicao.R")

# -------------------------------------------------------------------
#  Cálculos Python Puro
# -------------------------------------------------------------------

# Calcular Medidas de Dispersão (em Joules)

# --- Grupo 10k ---
amplitude_cadastro_pf_10_000 <- max(energia_J_10k, na.rm = TRUE) - min(energia_J_10k, na.rm = TRUE)
desvio_padrao_cadastro_pf_10_000 <- sd(energia_J_10k, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_10_000 <- (desvio_padrao_cadastro_pf_10_000 / media_energia_joules_cadastro_pf_10_000) * 100

# --- Grupo 100k ---
amplitude_cadastro_pf_100_000 <- max(energia_J_100k, na.rm = TRUE) - min(energia_J_100k, na.rm = TRUE)
desvio_padrao_cadastro_pf_100_000 <- sd(energia_J_100k, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_100_000 <- (desvio_padrao_cadastro_pf_100_000 / media_energia_joules_cadastro_pf_100_000) * 100

# --- Grupo 500k ---
amplitude_cadastro_pf_500_000 <- max(energia_J_500k, na.rm = TRUE) - min(energia_J_500k, na.rm = TRUE)
desvio_padrao_cadastro_pf_500_000 <- sd(energia_J_500k, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_500_000 <- (desvio_padrao_cadastro_pf_500_000 / media_energia_joules_cadastro_pf_500_000) * 100


# --- Impressão dos Resultados ---
cat("--- Cálculos Python com Pandas ---\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 10k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_10_000, "J\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 100k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_100_000, "J\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 500k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_500_000, "J\n")

# -------------------------------------------------------------------
#  Cálculos Python com Pandas
# -------------------------------------------------------------------

# Calcular Medidas de Dispersão (em Joules)

# --- Grupo 10k ---
amplitude_cadastro_pf_10_000_pandas <- max(energia_J_10k_pandas, na.rm = TRUE) - min(energia_J_10k_pandas, na.rm = TRUE)
desvio_padrao_cadastro_pf_10_000_pandas <- sd(energia_J_10k_pandas, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_10_000_pandas <- (desvio_padrao_cadastro_pf_10_000_pandas / media_energia_joules_cadastro_pf_10_000_pandas) * 100

# --- Grupo 100k ---
amplitude_cadastro_pf_100_000_pandas <- max(energia_J_100k_pandas, na.rm = TRUE) - min(energia_J_100k_pandas, na.rm = TRUE)
desvio_padrao_cadastro_pf_100_000_pandas <- sd(energia_J_100k_pandas, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_100_000_pandas <- (desvio_padrao_cadastro_pf_100_000_pandas / media_energia_joules_cadastro_pf_100_000_pandas) * 100

# --- Grupo 500k ---
amplitude_cadastro_pf_500_000_pandas <- max(energia_J_500k_pandas, na.rm = TRUE) - min(energia_J_500k_pandas, na.rm = TRUE)
desvio_padrao_cadastro_pf_500_000_pandas <- sd(energia_J_500k_pandas, na.rm = TRUE)
coeficiente_variacao_cadastro_pf_500_000_pandas <- (desvio_padrao_cadastro_pf_500_000_pandas / media_energia_joules_cadastro_pf_500_000_pandas) * 100


# --- Impressão dos Resultados ---
cat("--- Cálculos Python com Pandas ---\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 10k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_10_000_pandas, "J\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 100k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_100_000_pandas, "J\n")
cat("--- Medidas de Dispersão (Joules) - Grupo 500k ---\n")
cat("Amplitude:", amplitude_cadastro_pf_500_000_pandas, "J\n")
