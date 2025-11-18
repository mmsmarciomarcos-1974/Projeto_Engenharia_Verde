# ==============================================================================
# Projeto: Cálculo Estatisticos da aplicação Leitor CSV utilizando Python Puro
# Script: 01_medidas_de_posicao.R (Adaptado para Joules)
# Descrição: Calcula as medidas de posição (tendência central) 
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

# -------------------------------------------------------------------
#  Cálculos Python Puro
# -------------------------------------------------------------------

# --- Grupo 10k ---
media_energia_joules_cadastro_pf_10_000 <- mean(energia_J_10k, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_10_000 <- median(energia_J_10k, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_10_000 <- quantile(energia_J_10k, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_10_000 <- quartis_energia_joules_cadastro_pf_10_000[1]
quartis2_energia_joules_cadastro_pf_10_000 <- quartis_energia_joules_cadastro_pf_10_000[2]
quartis3_energia_joules_cadastro_pf_10_000 <- quartis_energia_joules_cadastro_pf_10_000[3]

# --- Grupo 100k ---
media_energia_joules_cadastro_pf_100_000 <- mean(energia_J_100k, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_100_000 <- median(energia_J_100k, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_100_000 <- quantile(energia_J_100k, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_100_000 <- quartis_energia_joules_cadastro_pf_100_000[1]
quartis2_energia_joules_cadastro_pf_100_000 <- quartis_energia_joules_cadastro_pf_100_000[2]
quartis3_energia_joules_cadastro_pf_100_000 <- quartis_energia_joules_cadastro_pf_100_000[3]

# --- Grupo 500k ---
media_energia_joules_cadastro_pf_500_000 <- mean(energia_J_500k, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_500_000 <- median(energia_J_500k, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_500_000 <- quantile(energia_J_500k, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_500_000 <- quartis_energia_joules_cadastro_pf_500_000[1]
quartis2_energia_joules_cadastro_pf_500_000 <- quartis_energia_joules_cadastro_pf_500_000[2]
quartis3_energia_joules_cadastro_pf_500_000 <- quartis_energia_joules_cadastro_pf_500_000[3]


# -------------------------------------------------------------------
#  Cálculos Python com Pandas
# -------------------------------------------------------------------

# --- Grupo 10k ---
media_energia_joules_cadastro_pf_10_000_pandas <- mean(energia_J_10k_pandas, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_10_000_pandas <- median(energia_J_10k_pandas, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_10_000_pandas <- quantile(energia_J_10k_pandas, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_10_000_pandas <- quartis_energia_joules_cadastro_pf_10_000_pandas[1]
quartis2_energia_joules_cadastro_pf_10_000_pandas <- quartis_energia_joules_cadastro_pf_10_000_pandas[2]
quartis3_energia_joules_cadastro_pf_10_000_pandas <- quartis_energia_joules_cadastro_pf_10_000_pandas[3]

# --- Grupo 100k ---
media_energia_joules_cadastro_pf_100_000_pandas <- mean(energia_J_100k_pandas, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_100_000_pandas <- median(energia_J_100k_pandas, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_100_000_pandas <- quantile(energia_J_100k_pandas, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_100_000_pandas <- quartis_energia_joules_cadastro_pf_100_000_pandas[1]
quartis2_energia_joules_cadastro_pf_100_000_pandas <- quartis_energia_joules_cadastro_pf_100_000_pandas[2]
quartis3_energia_joules_cadastro_pf_100_000_pandas <- quartis_energia_joules_cadastro_pf_100_000_pandas[3]

# --- Grupo 500k ---
media_energia_joules_cadastro_pf_500_000_pandas <- mean(energia_J_500k_pandas, na.rm = TRUE)
mediana_energia_joules_cadastro_pf_500_000_pandas <- median(energia_J_500k_pandas, na.rm = TRUE)

quartis_energia_joules_cadastro_pf_500_000_pandas <- quantile(energia_J_500k_pandas, probs = c(0.25, 0.50, 0.75), type = 6, na.rm = TRUE)
quartis1_energia_joules_cadastro_pf_500_000_pandas <- quartis_energia_joules_cadastro_pf_500_000_pandas[1]
quartis2_energia_joules_cadastro_pf_500_000_pandas <- quartis_energia_joules_cadastro_pf_500_000_pandas[2]
quartis3_energia_joules_cadastro_pf_500_000_pandas <- quartis_energia_joules_cadastro_pf_500_000_pandas[3]

print("Cálculos de medidas de posição (em Joules) concluídos.")