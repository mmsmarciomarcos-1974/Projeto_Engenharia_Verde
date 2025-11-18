# ==============================================================================
# Projeto: Cálculo Estatisticos
# Script: 03_tamanho_amostra_desvio_padrao_anova.R
# Descrição: Este script realiza a análise estatística completa
#            (Tamanho de amostra, IC, Testes T, ANOVA) para
#            ambos os conjuntos de dados (Puro e Pandas).
#            Gera 3 gráficos combinados (10k, 100k, 500k).
#
# Aluno: Everton Cezar Gonçalves
#        Caio Henrique dos Santos
#        Marcio Marcos
#        João Pedro Guez de Oliveiras
# Disciplina: Software Verde (Green Software) - Mestrado UTFPR
# Professor: Michel Albonico
# ==============================================================================

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
if (!requireNamespace("car", quietly = TRUE)) {
  install.packages("car") # Para o Teste de Levene
}

if (!requireNamespace("cowplot", quietly = TRUE)) {
  install.packages("cowplot")
}


library(ggplot2)
library(car)
library(cowplot)

dir_graficos <- "graficos"

if (!dir.exists(dir_graficos)) {
  dir.create(dir_graficos)
  cat(sprintf("Diretório '%s' criado com sucesso.\n", dir_graficos))
} else {
  cat(sprintf("Diretório '%s' já existe.\n", dir_graficos))
}

tryCatch({
  source("00_setup_e_dados.R")
  print("Script '00_setup_e_dados.R' carregado com sucesso.")
}, error = function(e) {
  stop(paste("Erro ao carregar '00_setup_e_dados.R'. Verifique se o arquivo está no diretório:", e$message))
})

# -------------------------------------------------------------------
#  Atribuição de Variáveis (Python Puro)
# -------------------------------------------------------------------
data_10k <- energia_J_10k
data_100k <- energia_J_100k
data_500k <- energia_J_500k

# -------------------------------------------------------------------
#  Atribuição de Variáveis (Python com Pandas)
# -------------------------------------------------------------------
data_10k_pandas <- energia_J_10k_pandas
data_100k_pandas <- energia_J_100k_pandas
data_500k_pandas <- energia_J_500k_pandas


# Verificar se os dados foram carregados
if (length(data_10k) == 0 || length(data_100k) == 0 || length(data_500k) == 0 ||
    length(data_10k_pandas) == 0 || length(data_100k_pandas) == 0 || length(data_500k_pandas) == 0) {
  stop("Falha ao carregar ou converter os dados. Pelo menos um vetor de dados está vazio.")
}

# Função auxiliar para imprimir estatísticas
print_stats <- function(data, name) {
  if (length(data) > 0) {
    cat(sprintf("Grupo: %s\n", name))
    cat(sprintf("  Tamanho da Amostra (N): %d\n", length(data)))
    cat(sprintf("  Média de Energia (Joules): %.4f\n", mean(data, na.rm = TRUE)))
    cat(sprintf("  Desvio Padrão (Joules): %.4f\n\n", sd(data, na.rm = TRUE)))
  }
}


# ==============================================================================
#  INÍCIO DA ANÁLISE: PYTHON PURO
# ==============================================================================

cat("\n=================================================================\n")
cat("  INÍCIO DA ANÁLISE: PYTHON PURO\n")
cat("=================================================================\n")

# --- 1. Descrição dos Dados (Python Puro) ---
cat("--- 1. Descrição dos Dados (Python Puro) ---\n")
print_stats(data_10k, "10k (Puro)")
print_stats(data_100k, "100k (Puro)")
print_stats(data_500k, "500k (Puro)")


# --- 2. Cálculo do Tamanho da Amostra (Python Puro) ---
cat("--- 2. Cálculo do Tamanho da Amostra (Python Puro) ---\n")
tryCatch({
  # Usando o grupo '10k' como estudo piloto
  mean_pilot <- mean(data_10k, na.rm = TRUE)
  sd_pilot <- sd(data_10k, na.rm = TRUE)
  
  Z <- 1.96 # Nível de confiança de 95%
  E <- 0.05 * mean_pilot # Margem de Erro (E) definida como 5% da média piloto
  
  # Fórmula: n = (Z * std / E)^2
  n_required <- (Z * sd_pilot / E)^2
  n_required_ceil <- ceiling(n_required)
  
  cat("Cálculo baseado no estudo piloto (grupo '10k' Puro):\n")
  cat(sprintf("  Média Piloto: %.4f J\n", mean_pilot))
  cat(sprintf("  Desvio Padrão Piloto: %.4f J\n", sd_pilot))
  cat(sprintf("  Nível de Confiança (NC): 95%% (Z = %.2f)\n", Z))
  cat(sprintf("  Margem de Erro (E) definida (5%% da média piloto): %.4f J\n", E))
  cat(sprintf("  Tamanho Mínimo de Amostra (n) Calculado: %d\n\n", n_required_ceil))
  
  cat("Comparação com o tamanho disponível (Puro):\n")
  cat(sprintf("  Grupo '10k' (N=%d): %s\n", length(data_10k), ifelse(length(data_10k) >= n_required_ceil, "Suficiente", "Insuficiente")))
  cat(sprintf("  Grupo '100k' (N=%d): %s\n", length(data_100k), ifelse(length(data_100k) >= n_required_ceil, "Suficiente", "Insuficiente")))
  cat(sprintf("  Grupo '500k' (N=%d): %s\n\n", length(data_500k), ifelse(length(data_500k) >= n_required_ceil, "Suficiente", "Insuficiente")))
}, error = function(e) {
  cat(sprintf("Erro no cálculo do tamanho da amostra (Puro): %s\n\n", e$message))
})


# --- 3. Intervalo de Confiança (Uma Amostra - Python Puro) ---

# --- 3.1 GRUPO 10K (PURO) ---
cat("--- 3.1 Intervalo de Confiança (Amostra '10k' - Python Puro) ---\n")
tryCatch({
  data_ic <- data_10k
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '10k' (Puro) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_10k <- data.frame(
    Grupo = "Python Puro (10k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  ic_plot_10k <- ggplot(plot_data_10k, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "cyan", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python Puro (10k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Puro 10k): %s\n\n", e$message))
})


# --- 3.2 GRUPO 100K (PURO) ---
cat("--- 3.2 Intervalo de Confiança (Amostra '100k' - Python Puro) ---\n")
tryCatch({
  data_ic <- data_100k
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '100k' (Puro) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_100k <- data.frame(
    Grupo = "Python Puro (100k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  
  ic_plot_100k <- ggplot(plot_data_100k, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "cyan", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python Puro (100k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Puro 100k): %s\n\n", e$message))
})


# --- 3.3 GRUPO 500K (PURO) ---
cat("--- 3.3 Intervalo de Confiança (Amostra '500k' - Python Puro) ---\n")
tryCatch({
  data_ic <- data_500k
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '500k' (Puro) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_500k <- data.frame(
    Grupo = "Python Puro (500k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  
  ic_plot_500k <- ggplot(plot_data_500k, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "cyan", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python Puro (500k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Puro 500k): %s\n\n", e$message))
})


# --- 4. Teste de Hipótese (Uma Amostra - Python Puro) ---
cat("--- 4. Teste de Hipótese (Uma Amostra - Grupo '500k' - Python Puro) ---\n")
tryCatch({
  data_ttest <- data_500k
  mean_obs <- mean(data_ttest, na.rm = TRUE)
  mu_0 <- 175.0
  alpha <- 0.05
  
  cat(sprintf("Testando o Grupo: '500k' (Puro) (Média observada: %.4f J)\n", mean_obs))
  cat(sprintf("Hipótese Nula (H0): A média populacional de energia (µ) é %.1f Joules.\n", mu_0))
  cat(sprintf("Hipótese Alternativa (Ha): A média populacional (µ) é diferente de %.1f Joules.\n", mu_0))
  
  # Teste t de uma amostra
  test_result <- t.test(data_ttest, mu = mu_0, alternative = "two.sided")
  
  cat(sprintf("  Estatística t: %.4f\n", test_result$statistic))
  cat(sprintf("  Valor-p (bi-caudal): %.6f\n", test_result$p.value))
  
  if (test_result$p.value < alpha) {
    cat(sprintf("  Conclusão: Rejeitamos H0 (p < %.2f). A média de energia é significativamente diferente de %.1f J.\n\n", alpha, mu_0))
  } else {
    cat(sprintf("  Conclusão: Falhamos em rejeitar H0 (p >= %.2f). Não há evidência que a média seja diferente de %.1f J.\n\n", alpha, mu_0))
  }
}, error = function(e) {
  cat(sprintf("Erro no Teste de Hipótese (Uma Amostra - Puro): %s\n\n", e$message))
})


# --- 5. Teste de Hipótese (Duas Amostras - Python Puro) ---
cat("--- 5. Teste de Hipótese (Duas Amostras - '10k' vs '100k' - Python Puro) ---\n")
tryCatch({
  alpha <- 0.05
  data_g1 <- data_10k
  data_g2 <- data_100k
  
  # Parte A: Teste F para Variâncias
  cat("Parte A: Teste F para Variâncias (Puro)\n")
  cat("  H0: As variâncias são iguais (sigma2_10k = sigma2_100k)\n")
  cat("  Ha: As variâncias são diferentes (sigma2_10k != sigma2_100k)\n")
  
  f_test_result <- var.test(data_g1, data_g2)
  
  cat(sprintf("  Estatística F: %.4f\n", f_test_result$statistic))
  cat(sprintf("  Valor-p: %.6g\n", f_test_result$p.value)) 
  
  equal_var_bool <- TRUE
  if (f_test_result$p.value < alpha) {
    cat(sprintf("  Conclusão (Teste F): Rejeitamos H0 (p < %.2f). As variâncias são significativamente diferentes.\n", alpha))
    equal_var_bool <- FALSE
  } else {
    cat(sprintf("  Conclusão (Teste F): Falhamos em rejeitar H0 (p >= %.2f). Assumiremos variâncias iguais.\n", alpha))
  }
  
  # Parte B: Teste t para Médias
  cat("\nParte B: Teste t para Médias ('10k' vs '100k' - Puro)\n")
  cat("  H0: As médias são iguais (µ_10k = µ_100k)\n")
  cat("  Ha: As médias são diferentes (µ_10k != µ_100k)\n")
  
  t_test_2samp <- t.test(data_g1, data_g2, var.equal = equal_var_bool, alternative = "two.sided")
  
  cat(sprintf("  Usando var.equal=%s (baseado no Teste F)\n", as.character(equal_var_bool)))
  cat(sprintf("  Estatística t: %.4f\n", t_test_2samp$statistic))
  cat(sprintf("  Valor-p: %.6g\n", t_test_2samp$p.value))
  
  if (t_test_2samp$p.value < alpha) {
    cat(sprintf("  Conclusão (Teste t): Rejeitamos H0 (p < %.2f). As médias de energia são significativamente diferentes.\n\n", alpha))
  } else {
    cat(sprintf("  Conclusão (Teste t): Falhamos em rejeitar H0 (p >= %.2f). Não há diferença significativa entre as médias.\n\n", alpha))
  }
}, error = function(e) {
  cat(sprintf("Erro no Teste de Hipótese (Duas Amostras - Puro): %s\n\n", e$message))
})


# --- 6. Três ou mais amostras (ANOVA - Python Puro) ---
cat("--- 6. Teste de Hipótese (ANOVA - '10k' vs '100k' vs '500k' - Python Puro) ---\n")
tryCatch({
  alpha <- 0.05
  
  # Criar uma lista para os testes de premissa
  data_list <- list(`10k` = data_10k, `100k` = data_100k, `500k` = data_500k)
  
  cat("H0: As médias de energia de todos os grupos (Puro) são iguais.\n")
  cat("Ha: Pelo menos uma média de grupo (Puro) é diferente das demais.\n")
  
  cat("\nVerificação de Premissas (ANOVA - Puro):\n")
  
  # 1. Homogeneidade de Variâncias (Teste de Levene - mais robusto)
  stacked_data <- data.frame(
    Energia = c(data_10k, data_100k, data_500k),
    Grupo = factor(rep(c("10k", "100k", "500k"), 
                       times = c(length(data_10k), length(data_100k), length(data_500k)))))
  
  levene_test_result <- leveneTest(Energia ~ Grupo, data = stacked_data, center = mean) 
  levene_p <- levene_test_result$`Pr(>F)`[1]
  
  cat(sprintf("  Teste de Homogeneidade de Variâncias (Levene, center=mean): p = %.6g\n", levene_p))
  
  premises_violated <- FALSE
  if (levene_p < alpha) {
    cat(sprintf("    -> Premissa VIOLADA. As variâncias não são homogêneas (p < %.2f).\n", alpha))
    premises_violated <- TRUE
  } else {
    cat(sprintf("    -> Premissa ATENDIDA. As variâncias parecem homogêneas (p >= %.2f).\n", alpha))
  }
  
  # 2. Normalidade (Teste de Shapiro-Wilk)
  cat("  Teste de Normalidade (Shapiro-Wilk - Puro):\n")
  shapiro_results <- lapply(data_list, function(data) {
    if(length(data) > 3 && length(data) < 5000) shapiro.test(data) else list(p.value = NA)
  })
  
  for (group_name in names(shapiro_results)) {
    p_val <- shapiro_results[[group_name]]$p.value
    if (!is.na(p_val)) {
      if (p_val < alpha) {
        cat(sprintf("    - Grupo '%s': p = %.6g (NÃO normal)\n", group_name, p_val))
        premises_violated <- TRUE
      } else {
        cat(sprintf("    - Grupo '%s': p = %.6g (Normal)\n", group_name, p_val))
      }
    } else {
      cat(sprintf("    - Grupo '%s': Teste de Shapiro não aplicável (N=%d).\n", group_name, length(data_list[[group_name]])))
    }
  }
  
  # --- Execução do Teste ---
  if (premises_violated) {
    cat("\n-> Devido à violação de uma ou mais premissas (Puro),\n")
    cat("   o Teste de Kruskal-Wallis (não-paramétrico) é mais apropriado:\n")
    
    kruskal_result <- kruskal.test(data_list)
    
    cat(sprintf("  Estatística H (Kruskal-Wallis): %.4f\n", kruskal_result$statistic))
    cat(sprintf("  Valor-p (Kruskal-Wallis): %.6g\n", kruskal_result$p.value))
    
    if (kruskal_result$p.value < alpha) {
      cat(sprintf("  Conclusão (Kruskal-Wallis): Rejeitamos H0 (p < %.2f). Pelo menos um grupo possui uma distribuição de energia significativamente diferente.\n", alpha))
    } else {
      cat(sprintf("  Conclusão (Kruskal-Wallis): Falhamos em rejeitar H0 (p >= %.2f).\n", alpha))
    }
  }
  
  # Executando a ANOVA One-Way (paramétrico) para referência
  cat("\nExecutando ANOVA One-Way (paramétrico - Puro) para referência:\n")
  anova_model <- aov(Energia ~ Grupo, data = stacked_data)
  summary_anova <- summary(anova_model)
  
  f_stat_anova <- summary_anova[[1]]$`F value`[1]
  p_val_anova <- summary_anova[[1]]$`Pr(>F)`[1]
  
  cat(sprintf("  Estatística F (ANOVA): %.4f\n", f_stat_anova))
  cat(sprintf("  Valor-p (ANOVA): %.6g\n", p_val_anova))
  
  if (p_val_anova < alpha) {
    cat(sprintf("  Conclusão (ANOVA): Rejeitamos H0 (p < %.2f). Pelo menos uma média de grupo é significativamente diferente.\n\n", alpha))
  } else {
    cat(sprintf("  Conclusão (ANOVA): Falhamos em rejeitar H0 (p >= %.2f). Não há diferenças significativas entre as médias.\n\n", alpha))
  }
  
}, error = function(e) {
  cat(sprintf("Erro na ANOVA (Puro): %s\n\n", e$message))
})




# ==============================================================================
#  INÍCIO DA ANÁLISE: PYTHON COM PANDAS
# ==============================================================================

cat("\n=================================================================\n")
cat("  INÍCIO DA ANÁLISE: PYTHON COM PANDAS\n")
cat("=================================================================\n")

# --- 1. Descrição dos Dados (Python com Pandas) ---
cat("--- 1. Descrição dos Dados (Python com Pandas) ---\n")
print_stats(data_10k_pandas, "10k (Pandas)")
print_stats(data_100k_pandas, "100k (Pandas)")
print_stats(data_500k_pandas, "500k (Pandas)")


# --- 2. Cálculo do Tamanho da Amostra (Python com Pandas) ---
cat("--- 2. Cálculo do Tamanho da Amostra (Python com Pandas) ---\n")
tryCatch({
  # Usando o grupo '10k' (Pandas) como estudo piloto
  mean_pilot <- mean(data_10k_pandas, na.rm = TRUE)
  sd_pilot <- sd(data_10k_pandas, na.rm = TRUE)
  
  Z <- 1.96 # Nível de confiança de 95%
  E <- 0.05 * mean_pilot # Margem de Erro (E) definida como 5% da média piloto
  
  # Fórmula: n = (Z * std / E)^2
  n_required <- (Z * sd_pilot / E)^2
  n_required_ceil <- ceiling(n_required)
  
  cat("Cálculo baseado no estudo piloto (grupo '10k' Pandas):\n")
  cat(sprintf("  Média Piloto: %.4f J\n", mean_pilot))
  cat(sprintf("  Desvio Padrão Piloto: %.4f J\n", sd_pilot))
  cat(sprintf("  Nível de Confiança (NC): 95%% (Z = %.2f)\n", Z))
  cat(sprintf("  Margem de Erro (E) definida (5%% da média piloto): %.4f J\n", E))
  cat(sprintf("  Tamanho Mínimo de Amostra (n) Calculado: %d\n\n", n_required_ceil))
  
  cat("Comparação com o tamanho disponível (Pandas):\n")
  cat(sprintf("  Grupo '10k' (N=%d): %s\n", length(data_10k_pandas), ifelse(length(data_10k_pandas) >= n_required_ceil, "Suficiente", "Insuficiente")))
  cat(sprintf("  Grupo '100k' (N=%d): %s\n", length(data_100k_pandas), ifelse(length(data_100k_pandas) >= n_required_ceil, "Suficiente", "Insuficiente")))
  cat(sprintf("  Grupo '500k' (N=%d): %s\n\n", length(data_500k_pandas), ifelse(length(data_500k_pandas) >= n_required_ceil, "Suficiente", "Insuficiente")))
}, error = function(e) {
  cat(sprintf("Erro no cálculo do tamanho da amostra (Pandas): %s\n\n", e$message))
})


# --- 3. Intervalo de Confiança (Uma Amostra - Python com Pandas) ---

# --- 3.1 GRUPO 10K (PANDAS) ---
cat("--- 3.1 Intervalo de Confiança (Amostra '10k' - Python com Pandas) ---\n")
tryCatch({
  data_ic <- data_10k_pandas
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '10k' (Pandas) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_10k_pandas <- data.frame(
    Grupo = "Python com Pandas (10k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  
  ic_plot_10k_pandas <- ggplot(plot_data_10k_pandas, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "orange", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python com Pandas (10k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Pandas 10k): %s\n\n", e$message))
})

# --- 3.2 GRUPO 100K (PANDAS) ---
cat("--- 3.2 Intervalo de Confiança (Amostra '100k' - Python com Pandas) ---\n")
tryCatch({
  data_ic <- data_100k_pandas
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '100k' (Pandas) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_100k_pandas <- data.frame(
    Grupo = "Python com Pandas (100k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  
  ic_plot_100k_pandas <- ggplot(plot_data_100k_pandas, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "orange", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python com Pandas (100k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Pandas 100k): %s\n\n", e$message))
})

# --- 3.3 GRUPO 500K (PANDAS) ---
cat("--- 3.3 Intervalo de Confiança (Amostra '500k' - Python com Pandas) ---\n")
tryCatch({
  data_ic <- data_500k_pandas
  mean_ic <- mean(data_ic, na.rm = TRUE)
  sd_ic <- sd(data_ic, na.rm = TRUE)
  n_ic <- length(na.omit(data_ic))
  alpha <- 0.05
  t_score <- qt(1 - (alpha / 2), df = n_ic - 1)
  se <- sd_ic / sqrt(n_ic)
  margin_of_error_abs <- t_score * se
  ci_lower <- mean_ic - margin_of_error_abs
  ci_upper <- mean_ic + margin_of_error_abs
  
  cat(sprintf("Análise do Grupo: '500k' (Pandas) (N=%d)\n", n_ic))
  cat(sprintf("  Média (Joules): %.4f\n", mean_ic))
  cat(sprintf("  Intervalo de Confiança (95%%): [%.4f J, %.4f J]\n\n", ci_lower, ci_upper))
  
  plot_data_500k_pandas <- data.frame(
    Grupo = "Python com Pandas (500k)",
    Media = mean_ic,
    Lower_CI = ci_lower,
    Upper_CI = ci_upper
  )
  
  ic_plot_500k_pandas <- ggplot(plot_data_500k_pandas, aes(x = Grupo, y = Media)) +
    geom_bar(stat = "identity", fill = "orange", color = "black", width = 0.5) +
    geom_errorbar(aes(ymin = Lower_CI, ymax = Upper_CI), width = 0.2, linewidth = 0.7) +
    geom_text(aes(label = sprintf("%.2f J", Media)), vjust = -0.5, size = 4, color = "black") +
    labs(
      title = "Python com Pandas (500k)",
      y = "Energia Média (Joules)", x = ""
    ) +
    theme_minimal() +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)), limits = c(0, NA)) +
    theme(plot.title = element_text(hjust = 0.5))
  
}, error = function(e) {
  cat(sprintf("Erro ao calcular o Intervalo de Confiança (Pandas 500k): %s\n\n", e$message))
})


# --- 4. Teste de Hipótese (Uma Amostra - Python com Pandas) ---
cat("--- 4. Teste de Hipótese (Uma Amostra - Grupo '500k' - Python com Pandas) ---\n")
tryCatch({
  # Escolhendo o grupo '500k' (Pandas)
  data_ttest <- data_500k_pandas
  mean_obs <- mean(data_ttest, na.rm = TRUE)
  mu_0 <- 175.0
  alpha <- 0.05
  
  cat(sprintf("Testando o Grupo: '500k' (Pandas) (Média observada: %.4f J)\n", mean_obs))
  cat(sprintf("Hipótese Nula (H0): A média populacional de energia (µ) é %.1f Joules.\n", mu_0))
  cat(sprintf("Hipótese Alternativa (Ha): A média populacional (µ) é diferente de %.1f Joules.\n", mu_0))
  
  # Teste t de uma amostra
  test_result <- t.test(data_ttest, mu = mu_0, alternative = "two.sided")
  
  cat(sprintf("  Estatística t: %.4f\n", test_result$statistic))
  cat(sprintf("  Valor-p (bi-caudal): %.6f\n", test_result$p.value))
  
  if (test_result$p.value < alpha) {
    cat(sprintf("  Conclusão: Rejeitamos H0 (p < %.2f). A média de energia é significativamente diferente de %.1f J.\n\n", alpha, mu_0))
  } else {
    cat(sprintf("  Conclusão: Falhamos em rejeitar H0 (p >= %.2f). Não há evidência que a média seja diferente de %.1f J.\n\n", alpha, mu_0))
  }
}, error = function(e) {
  cat(sprintf("Erro no Teste de Hipótese (Uma Amostra - Pandas): %s\n\n", e$message))
})


# --- 5. Teste de Hipótese (Duas Amostras - Python com Pandas) ---
cat("--- 5. Teste de Hipótese (Duas Amostras - '10k' vs '100k' - Python com Pandas) ---\n")
tryCatch({
  alpha <- 0.05
  data_g1 <- data_10k_pandas
  data_g2 <- data_100k_pandas
  
  # Parte A: Teste F para Variâncias
  cat("Parte A: Teste F para Variâncias (Pandas)\n")
  cat("  H0: As variâncias são iguais (sigma2_10k = sigma2_100k)\n")
  cat("  Ha: As variâncias são diferentes (sigma2_10k != sigma2_100k)\n")
  
  f_test_result <- var.test(data_g1, data_g2)
  
  cat(sprintf("  Estatística F: %.4f\n", f_test_result$statistic))
  cat(sprintf("  Valor-p: %.6g\n", f_test_result$p.value)) 
  
  equal_var_bool <- TRUE
  if (f_test_result$p.value < alpha) {
    cat(sprintf("  Conclusão (Teste F): Rejeitamos H0 (p < %.2f). As variâncias são significativamente diferentes.\n", alpha))
    equal_var_bool <- FALSE
  } else {
    cat(sprintf("  Conclusão (Teste F): Falhamos em rejeitar H0 (p >= %.2f). Assumiremos variâncias iguais.\n", alpha))
  }
  
  # Parte B: Teste t para Médias
  cat("\nParte B: Teste t para Médias ('10k' vs '100k' - Pandas)\n")
  cat("  H0: As médias são iguais (µ_10k = µ_100k)\n")
  cat("  Ha: As médias são diferentes (µ_10k != µ_100k)\n")
  
  t_test_2samp <- t.test(data_g1, data_g2, var.equal = equal_var_bool, alternative = "two.sided")
  
  cat(sprintf("  Usando var.equal=%s (baseado no Teste F)\n", as.character(equal_var_bool)))
  cat(sprintf("  Estatística t: %.4f\n", t_test_2samp$statistic))
  cat(sprintf("  Valor-p: %.6g\n", t_test_2samp$p.value))
  
  if (t_test_2samp$p.value < alpha) {
    cat(sprintf("  Conclusão (Teste t): Rejeitamos H0 (p < %.2f). As médias de energia são significativamente diferentes.\n\n", alpha))
  } else {
    cat(sprintf("  Conclusão (Teste t): Falhamos em rejeitar H0 (p >= %.2f). Não há diferença significativa entre as médias.\n\n", alpha))
  }
}, error = function(e) {
  cat(sprintf("Erro no Teste de Hipótese (Duas Amostras - Pandas): %s\n\n", e$message))
})


# --- 6. Três ou mais amostras (ANOVA - Python com Pandas) ---
cat("--- 6. Teste de Hipótese (ANOVA - '10k' vs '100k' vs '500k' - Python com Pandas) ---\n")
tryCatch({
  alpha <- 0.05
  
  data_list_pandas <- list(`10k` = data_10k_pandas, `100k` = data_100k_pandas, `500k` = data_500k_pandas)
  
  cat("H0: As médias de energia de todos os grupos (Pandas) são iguais.\n")
  cat("Ha: Pelo menos uma média de grupo (Pandas) é diferente das demais.\n")
  
  cat("\nVerificação de Premissas (ANOVA - Pandas):\n")
  
  # 1. Homogeneidade de Variâncias (Teste de Levene - mais robusto)
  stacked_data_pandas <- data.frame(
    Energia = c(data_10k_pandas, data_100k_pandas, data_500k_pandas),
    Grupo = factor(rep(c("10k", "100k", "500k"), 
                       times = c(length(data_10k_pandas), length(data_100k_pandas), length(data_500k_pandas)))))
  
  levene_test_result <- leveneTest(Energia ~ Grupo, data = stacked_data_pandas, center = mean) 
  levene_p <- levene_test_result$`Pr(>F)`[1]
  
  cat(sprintf("  Teste de Homogeneidade de Variâncias (Levene, center=mean): p = %.6g\n", levene_p))
  
  premises_violated <- FALSE
  if (levene_p < alpha) {
    cat(sprintf("    -> Premissa VIOLADA. As variâncias não são homogêneas (p < %.2f).\n", alpha))
    premises_violated <- TRUE
  } else {
    cat(sprintf("    -> Premissa ATENDIDA. As variâncias parecem homogêneas (p >= %.2f).\n", alpha))
  }
  
  # 2. Normalidade (Teste de Shapiro-Wilk)
  cat("  Teste de Normalidade (Shapiro-Wilk - Pandas):\n")
  shapiro_results <- lapply(data_list_pandas, function(data) {
    if(length(data) > 3 && length(data) < 5000) shapiro.test(data) else list(p.value = NA)
  })
  
  for (group_name in names(shapiro_results)) {
    p_val <- shapiro_results[[group_name]]$p.value
    if (!is.na(p_val)) {
      if (p_val < alpha) {
        cat(sprintf("    - Grupo '%s': p = %.6g (NÃO normal)\n", group_name, p_val))
        premises_violated <- TRUE
      } else {
        cat(sprintf("    - Grupo '%s': p = %.6g (Normal)\n", group_name, p_val))
      }
    } else {
      cat(sprintf("    - Grupo '%s': Teste de Shapiro não aplicável (N=%d).\n", group_name, length(data_list_pandas[[group_name]])))
    }
  }
  
  # --- Execução do Teste ---
  if (premises_violated) {
    cat("\n-> Devido à violação de uma ou mais premissas (Pandas),\n")
    cat("   o Teste de Kruskal-Wallis (não-paramétrico) é mais apropriado:\n")
    
    kruskal_result <- kruskal.test(data_list_pandas)
    
    cat(sprintf("  Estatística H (Kruskal-Wallis): %.4f\n", kruskal_result$statistic))
    cat(sprintf("  Valor-p (Kruskal-Wallis): %.6g\n", kruskal_result$p.value))
    
    if (kruskal_result$p.value < alpha) {
      cat(sprintf("  Conclusão (Kruskal-Wallis): Rejeitamos H0 (p < %.2f). Pelo menos um grupo possui uma distribuição de energia significativamente diferente.\n", alpha))
    } else {
      cat(sprintf("  Conclusão (Kruskal-Wallis): Falhamos em rejeitar H0 (p >= %.2f).\n", alpha))
    }
  }
  
  # Executando a ANOVA One-Way (paramétrico) para referência
  cat("\nExecutando ANOVA One-Way (paramétrico - Pandas) para referência:\n")
  anova_model <- aov(Energia ~ Grupo, data = stacked_data_pandas)
  summary_anova <- summary(anova_model)
  
  f_stat_anova <- summary_anova[[1]]$`F value`[1]
  p_val_anova <- summary_anova[[1]]$`Pr(>F)`[1]
  
  cat(sprintf("  Estatística F (ANOVA): %.4f\n", f_stat_anova))
  cat(sprintf("  Valor-p (ANOVA): %.6g\n", p_val_anova))
  
  if (p_val_anova < alpha) {
    cat(sprintf("  Conclusão (ANOVA): Rejeitamos H0 (p < %.2f). Pelo menos uma média de grupo é significativamente diferente.\n\n", alpha))
  } else {
    cat(sprintf("  Conclusão (ANOVA): Falhamos em rejeitar H0 (p >= %.2f). Não há diferenças significativas entre as médias.\n\n", alpha))
  }
  
}, error = function(e) {
  cat(sprintf("Erro na ANOVA (Pandas): %s\n\n", e$message))
})


# --- 7. GERAÇÃO DE GRÁFICOS COMBINADOS ---
cat("\n--- 7. Geração de Gráficos Combinados Lado a Lado ---\n")

# Combinar 10k
tryCatch({
  ylim_10k <- c(0, max(plot_data_10k$Upper_CI, plot_data_10k_pandas$Upper_CI) * 1.1)
  
  ic_plot_10k_final <- ic_plot_10k + coord_cartesian(ylim = ylim_10k)
  ic_plot_10k_pandas_final <- ic_plot_10k_pandas + coord_cartesian(ylim = ylim_10k)
  
  combined_plot_10k <- plot_grid(ic_plot_10k_pandas_final, ic_plot_10k_final, ncol = 2)

  title_10k <- ggdraw() + draw_label("Comparação de Média de Energia (IC 95%) - Carga 10k", fontface = 'bold')
  plot_with_title_10k <- plot_grid(title_10k, combined_plot_10k, ncol = 1, rel_heights = c(0.1, 1))
  
  ggsave(file.path(dir_graficos, "03_grafico_combinado_10k.png"), plot = plot_with_title_10k, width = 10, height = 6)
  cat(sprintf("Gráfico combinado '03_grafico_combinado_10k.png' salvo em '%s'\n", dir_graficos))
  
}, error = function(e) {
  cat(sprintf("Erro ao combinar gráficos de 10k: %s\n\n", e$message))
})

# Combinar 100k
tryCatch({
  ylim_100k <- c(0, max(plot_data_100k$Upper_CI, plot_data_100k_pandas$Upper_CI) * 1.1)
  
  ic_plot_100k_final <- ic_plot_100k + coord_cartesian(ylim = ylim_100k)
  ic_plot_100k_pandas_final <- ic_plot_100k_pandas + coord_cartesian(ylim = ylim_100k)
  
  combined_plot_100k <- plot_grid(ic_plot_100k_pandas_final, ic_plot_100k_final, ncol = 2)
  
  title_100k <- ggdraw() + draw_label("Comparação de Média de Energia (IC 95%) - Carga 100k", fontface = 'bold')
  plot_with_title_100k <- plot_grid(title_100k, combined_plot_100k, ncol = 1, rel_heights = c(0.1, 1))
  
  ggsave(file.path(dir_graficos, "03_grafico_combinado_100k.png"), plot = plot_with_title_100k, width = 10, height = 6)
  cat(sprintf("Gráfico combinado '03_grafico_combinado_100k.png' salvo em '%s'\n", dir_graficos))
  
}, error = function(e) {
  cat(sprintf("Erro ao combinar gráficos de 100k: %s\n\n", e$message))
})

# Combinar 500k
tryCatch({
  ylim_500k <- c(0, max(plot_data_500k$Upper_CI, plot_data_500k_pandas$Upper_CI) * 1.1)
  
  ic_plot_500k_final <- ic_plot_500k + coord_cartesian(ylim = ylim_500k)
  ic_plot_500k_pandas_final <- ic_plot_500k_pandas + coord_cartesian(ylim = ylim_500k)
  
  combined_plot_500k <- plot_grid(ic_plot_500k_pandas_final, ic_plot_500k_final, ncol = 2)
  
  title_500k <- ggdraw() + draw_label("Comparação de Média de Energia (IC 95%) - Carga 500k", fontface = 'bold')
  plot_with_title_500k <- plot_grid(title_500k, combined_plot_500k, ncol = 1, rel_heights = c(0.1, 1))
  
  ggsave(file.path(dir_graficos, "03_grafico_combinado_500k.png"), plot = plot_with_title_500k, width = 10, height = 6)
  cat(sprintf("Gráfico combinado '03_grafico_combinado_500k.png' salvo em '%s'\n", dir_graficos))
  
}, error = function(e) {
  cat(sprintf("Erro ao combinar gráficos de 500k: %s\n\n", e$message))
})


cat("\n--- Análise Estatística Completa (Puro e Pandas) Concluída ---\n")