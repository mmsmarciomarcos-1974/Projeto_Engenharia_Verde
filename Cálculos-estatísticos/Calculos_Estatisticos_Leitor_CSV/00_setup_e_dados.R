# ==============================================================================
# Projeto: Cálculo Estatisticos da aplicação Leitor CSV utilizando Python Puro
# Script: 00_setup_e_dados.R
# Descrição: Carrega os dados de consumo de energia.
#
# Aluno: Everton Cezar Gonçalves
#        Caio Henrique dos Santos
#        Marcio Marcos
#        João Pedro Guez de Oliveira
# Disciplina: Software Verde (Green Software) - Mestrado UTFPR
# Professor: Michel Albonico
# =============================================================================


# -------------------------------------------------------------------
#  Carregando dados do CSV cadastro pf Python Puro
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# ETAPA 1: Carregando dados do CSV cadastro pf 10_000 Python Puro
# -------------------------------------------------------------------
dados_cadastro_pf_10_000 <- readr::read_csv("Dados/resultados_python_puro_cadastro_pf_10_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_10_000_str <- dados_cadastro_pf_10_000$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_10_000 <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_10_000_str)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_10_000_numericos <- as.numeric(valores_limpos_cadastro_pf_10_000)

tempo_segundos_cadastro_pf_10_000 <- dados_cadastro_pf_10_000$`Tempo (s)`


# -------------------------------------------------------------------
# ETAPA 2: Carregando dados do CSV cadastro pf 100_000 Python Puro
# -------------------------------------------------------------------

dados_cadastro_pf_100_000 <- readr::read_csv("Dados/resultados_python_puro_cadastro_pf_100_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_100_000_str <- dados_cadastro_pf_100_000$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_100_000 <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_100_000_str)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_100_000_numericos <- as.numeric(valores_limpos_cadastro_pf_100_000)

tempo_segundos_cadastro_pf_100_000 <- dados_cadastro_pf_100_000$`Tempo (s)`


# -------------------------------------------------------------------
# ETAPA 3: Carregando dados do CSV cadastro pf 500_000 Python Puro
# -------------------------------------------------------------------
dados_cadastro_pf_500_000 <- readr::read_csv("Dados/resultados_python_puro_cadastro_pf_500_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_500_000_str <- dados_cadastro_pf_500_000$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_500_000 <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_500_000_str)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_500_000_numericos <- as.numeric(valores_limpos_cadastro_pf_500_000)

tempo_segundos_cadastro_pf_500_000 <- dados_cadastro_pf_500_000$`Tempo (s)`


# Converter os dados de Microjoules (µJ) para Joules (J)
# 1 Joule = 1,000,000 Microjoules
energia_J_10k <- energia_micro_joules_cadastro_pf_10_000_numericos / 1000000
energia_J_100k <- energia_micro_joules_cadastro_pf_100_000_numericos / 1000000
energia_J_500k <- energia_micro_joules_cadastro_pf_500_000_numericos / 1000000

print(energia_J_10k)
print(energia_J_100k)
print(energia_J_500k)

# -------------------------------------------------------------------
#  Carregando dados do CSV cadastro pf Python com Pandas
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# ETAPA 1: Carregando dados do CSV cadastro pf 10_000 Python com Pandas
# -------------------------------------------------------------------
dados_cadastro_pf_10_000_pandas <- readr::read_csv("Dados/resultados_python_pandas_cadastro_pf_10_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_10_000_str_pandas <- dados_cadastro_pf_10_000_pandas$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_10_000_pandas <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_10_000_str_pandas)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_10_000_numericos_pandas <- as.numeric(valores_limpos_cadastro_pf_10_000_pandas)

tempo_segundos_cadastro_pf_10_000_pandas <- dados_cadastro_pf_10_000_pandas$`Tempo (s)`

# -------------------------------------------------------------------
# ETAPA 2: Carregando dados do CSV cadastro pf 100_000 Python com Pandas
# -------------------------------------------------------------------

dados_cadastro_pf_100_000_pandas <- readr::read_csv("Dados/resultados_python_pandas_cadastro_pf_100_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_100_000_str_pandas <- dados_cadastro_pf_100_000_pandas$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_100_000_pandas <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_100_000_str_pandas)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_100_000_numericos_pandas <- as.numeric(valores_limpos_cadastro_pf_100_000_pandas)

tempo_segundos_cadastro_pf_100_000_pandas <- dados_cadastro_pf_100_000_pandas$`Tempo (s)`


# -------------------------------------------------------------------
# ETAPA 3: Carregando dados do CSV cadastro pf 500_000 Python com Pandas
# -------------------------------------------------------------------
dados_cadastro_pf_500_000_pandas <- readr::read_csv("Dados/resultados_python_pandas_cadastro_pf_500_000.csv")
# 1 Resgatou os valores de energia em strings"
energia_joules_cadastro_pf_500_000_str_pandas <- dados_cadastro_pf_500_000_pandas$`Energia (µJ)`
# 2 Remover os colchetes "[" e "]"
valores_limpos_cadastro_pf_500_000_pandas <- gsub("\\[|\\]", "", energia_joules_cadastro_pf_500_000_str_pandas)
# 3 Converter o vetor de texto para numérico
energia_micro_joules_cadastro_pf_500_000_numericos_pandas <- as.numeric(valores_limpos_cadastro_pf_500_000_pandas)

tempo_segundos_cadastro_pf_500_000_pandas <- dados_cadastro_pf_500_000_pandas$`Tempo (s)`

# Converter os dados de Microjoules (µJ) para Joules (J)
# 1 Joule = 1,000,000 Microjoules
energia_J_10k_pandas <- energia_micro_joules_cadastro_pf_10_000_numericos_pandas / 1000000
energia_J_100k_pandas <- energia_micro_joules_cadastro_pf_100_000_numericos_pandas / 1000000
energia_J_500k_pandas <- energia_micro_joules_cadastro_pf_500_000_numericos_pandas / 1000000

print(energia_J_10k_pandas)
print(energia_J_100k_pandas)
print(energia_J_500k_pandas)

print("Ambiente configurado e dados de energia carregados com sucesso.")