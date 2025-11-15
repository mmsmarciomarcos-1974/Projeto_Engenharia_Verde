# Projeto_Engenharia_Verde
Projeto acadêmico na UTFPR (Universidade Federal do Paraná) para medir e comparar o consumo de energia de algoritmos em Python (puro vs. Pandas), aplicando conceitos de Engenharia Verde.

### 👥 Autores

* **Caio Henrique dos Santos**
* **Everton Cezar Gonçalves**
* **João Pedro Guez de Oliveira**
* **Marcio Marcos**
* *Novembro de 2025*
  
## 🔬 Metodologia e Definição do Experimento

Este projeto realiza um estudo empírico para comparar a eficiência energética de duas abordagens populares de processamento de dados em Python:

1.  **Python Puro:** Utilizando o módulo nativo `csv`.
2.  **Biblioteca Pandas:** Uma biblioteca de alto desempenho para análise de dados.

O objetivo é responder à pergunta: **A abordagem com Pandas é mais eficiente energeticamente do que a abordagem com Python puro?** 
---

  
### A Tarefa
Ambas as implementações executaram uma tarefa idêntica para permitir uma comparação justa:
* Ler um arquivo CSV de dados 
* Armazenar os dados em memória 
* Iterar sobre todos os registros 
* Imprimir os registros no console 

A métrica principal é o **Consumo de Energia (em Joules)**, medido com a ferramenta `PyrAPL`.

### Documento de Definição
A metodologia completa, incluindo as hipóteses formais (Nula e Alternativa), as Perguntas de Pesquisa (RQs) e o fluxo detalhado da execução, está detalhada no documento acadêmico abaixo:

➡️ **[Clique aqui para ler a Definição completa do Experimento (PDF)](./documentos/Definicao_do_experimento.pdf)**

## 🚀 Como Executar o Experimento

Para replicar os resultados deste estudo, siga os passos abaixo.

### 1. Pré-requisitos

1.  Clone este repositório:
    ```bash
    git clone [URL-DO-SEU-REPOSITORIO]
    cd [NOME-DO-SEU-REPOSITORIO]
    ```

2.  Crie e ative um ambiente virtual (Python virtual environment):
    ```bash
    python -m venv .venv
    source .venv/bin/activate  # Para Linux/macOS
    # ou
    .\.venv\Scripts\activate   # Para Windows
    ```

3.  Instale as dependências (Pandas, pyRAPL, etc.):
    ```bash
    pip install -r requirements.txt
    ```

### 2. Executando os Testes

Os scripts devem ser executados com privilégios de administrador (via `sudo`) para permitir que a biblioteca `pyRAPL` acesse os sensores de energia do sistema.

**Atenção:** Os comandos abaixo irão executar o benchmark completo e salvar os resultados.

**Para executar o teste com Python Puro:**
```bash
sudo -E .venv/bin/python leitor_csv_python_puro/main_monitor_python_puro.py
## 💾 Código-Fonte

O experimento é composto por dois scripts principais, cada um representando uma das abordagens avaliadas.

### 1. Implementação com Python Puro

**Arquivo:** `leitor_csv_python_puro/main_monitor_python_puro.py`

Este script representa a abordagem "Python Puro" e utiliza a biblioteca nativa `csv` para realizar a tarefa. Ele é responsável por orquestrar o experimento completo para esta implementação.

* **Função `ler_csv()`**: Executa a tarefa principal definida na metodologia:
    * Abre o arquivo `dados/cadastro_pf_100_000.csv`.
    * Lê o CSV usando `csv.reader`.
    * Armazena todos os registros em uma lista na memória (`linhas = list(leitor)`).
    * Imprime a lista completa no console (`print(linhas)`).

* **Função `monitorar_leitura()`**: Gerencia o loop do experimento:
    * Executa a função `ler_csv()` em um loop por **40 vezes**.
    * Utiliza `pyRAPL` para medir o consumo de energia do pacote da CPU (`PKG`) em microjoules (µJ))`, `energia_pkg = medicao.result.pkg`].
    * Utiliza `time.perf_counter` para medir o tempo de execução em segundos.
    * Salva os resultados de cada execução no arquivo `resultados/resultados_python_puro_cadastro_pf_100_000.csv`.

### 2. Implementação com Biblioteca Pandas

**Arquivo:** `leitor_csv_pandas/main_monitor_pandas.py`

Este script representa a abordagem "Biblioteca Pandas" e utiliza a biblioteca `pandas` para realizar a tarefa. A estrutura de medição é idêntica à versão pura para garantir uma comparação justa.

* **Função `get_dados_csv()`**: Executa a tarefa principal usando as funções otimizadas do Pandas:
    * Abre e lê o arquivo `dados/cadastro_pf_100_000.csv`, carregando-o diretamente em um DataFrame com o comando `pd.read_csv()`.
    * Imprime o DataFrame completo no console (`print(df)`) para equivaler à tarefa da versão pura.

* **Bloco `if __name__ == '__main__':`**: Gerencia o loop do experimento:
    * Executa a função `get_dados_csv()` em um loop por **40 vezes**.
    * Utiliza `pyRAPL` para medir o consumo de energia do pacote da CPU (`PKG`) em microjoules (µJ).
    * Utiliza `time.time()` para medir o tempo de execução em segundos.
    * Salva os resultados de cada execução no arquivo `resultados/resultados_medicoes_cadastro_pf_100_000.csv`.

    ## 📈 Resultados

Os dados brutos de todas as 40 execuções para cada cenário estão disponíveis na pasta `/resultados`.

Uma análise estatística foi conduzida para comparar as duas abordagens. A mediana foi usada como principal indicador de tendência central para reduzir o impacto de outliers (picos momentâneos de energia ou tempo do sistema).

### Cenário 1: Carga de 10.000 Registros

#### 1.1. Python Puro (10k)

Os resultados completos estão no arquivo `resultados/resultados_python_puro_cadastro_pf_10_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 0.0916 | 0.0892 | 0.0524 | 0.1515 |
| **Energia (µJ)** | 4,665,287 | 3,784,994 | 2,841,362 | 10,700,962 |

### Cenário 2: Carga de 500.000 Registros

Para testar a escalabilidade das soluções, um segundo experimento foi conduzido com um conjunto de dados 50 vezes maior.

#### 2.1. Python Puro (500k)

Os resultados completos estão no arquivo `resultados/resultados_python_puro_cadastro_pf_500_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 3.9648 | 3.8809 | 3.6665 | 5.0233 |
| **Energia (µJ)** | 185,046,027 | 175,839,821 | 157,504,357 | 260,642,521 |
### Cenário 2: Carga de 100.000 Registros (Cenário Base)

Este é o cenário de referência descrito nos scripts de medição.

#### 2.1. Python Puro (100k)

Os resultados completos estão no arquivo `resultados/resultados_python_puro_cadastro_pf_100_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 0.8267 | 0.8236 | 0.7681 | 0.9497 |
| **Energia (µJ)** | 35,463,710 | 33,695,431 | 30,517,736 | 45,961,847 |

#### 1.2. Pandas (10k)

Os resultados completos estão no arquivo `resultados/resultados_python_pandas_cadastro_pf_10_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 0.0890 | 0.0863 | 0.0762 | 0.1290 |
| **Energia (µJ)** | 4,289,355 | 3,365,357 | 2,756,920 | 8,973,814 |

### Cenário 2: Carga de 100.000 Registros (Cenário Base)

Este é o cenário de teste principal, conforme definido nos scripts.

#### 2.1. Python Puro (100k)
Os resultados completos estão no arquivo `resultados/resultados_python_puro_cadastro_pf_100_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 0.6739 | 0.6455 | 0.5790 | 1.2809 |
| **Energia (µJ)** | 34,815,307 | 33,631,445 | 26,886,711 | 73,009,518 |

#### 2.2. Pandas (100k)
Os resultados completos estão no arquivo `resultados/resultados_python_pandas_cadastro_pf_100_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 2.3024 | 2.2965 | 2.2670 | 2.3870 |
| **Energia (µJ)** | 101,875,376 | 101,040,422 | 97,631,342 | 109,594,202 |

##### Conclusão Intermediária (Cenário 2)
Neste cenário crucial, a **Implementação em Python Puro** se mostrou superior tanto em desempenho quanto em eficiência energética, apresentando uma Mediana de Tempo $3.5\times$ menor e uma Mediana de Consumo de Energia $3\times$ menor do que a Implementação em Pandas.

### Cenário 3: Carga de 500.000 Registros (Escalabilidade)

Este cenário avalia a eficiência das implementações sob uma carga massiva de dados, sendo 50 vezes maior que a carga inicial de 10k.

#### 3.1. Python Puro (500k)
Os resultados completos estão no arquivo `resultados/resultados_python_puro_cadastro_pf_500_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 3.9648 | 3.8809 | 3.6665 | 5.0233 |
| **Energia (µJ)** | 185,046,027 | 175,839,821 | 157,504,357 | 260,642,521 |

#### 3.2. Pandas (500k)
Os resultados completos estão no arquivo `resultados/resultados_python_pandas_cadastro_pf_500_000.csv`.

| Métrica | Média | Mediana | Mínimo | Máximo |
| :--- | :--- | :--- | :--- | :--- |
| **Tempo (s)** | 16.2778 | 16.2715 | 16.0870 | 16.6870 |
| **Energia (µJ)** | 694,191,425 | 689,596,135 | 663,480,296 | 756,832,474 |

##### Conclusão Intermediária (Cenário 3)
A tendência observada no cenário de 100k se intensificou. Para a carga de 500k, a **Implementação em Python Puro** se manteve significativamente mais eficiente, apresentando uma Mediana de Tempo $4.2\times$ menor ($3.88$s vs $16.27$s) e uma Mediana de Consumo de Energia $3.9\times$ menor ($175.8$ milhões de µJ vs $689.5$ milhões de µJ) do que a Implementação em Pandas.

---

##  निष्कर्षes Finais (Para o Documento e Apresentação)

A análise empírica refuta a Hipótese Alternativa ($H_1$) de que a biblioteca Pandas seria mais eficiente energeticamente para a tarefa definida. A **Implementação em Python Puro** (utilizando o módulo nativo `csv`) demonstrou ser consistentemente superior em todos os cenários de teste, tanto em termos de **Tempo de Execução (Desempenho)** quanto de **Consumo de Energia (Eficiência Verde)**.

1.  **Eficiência Energética:** O Python Puro consumiu entre **$3$ a $4$ vezes menos energia** que a abordagem com Pandas para processar e iterar sobre o CSV.
2.  **Desempenho:** O Python Puro também foi **$3$ a $4$ vezes mais rápido**.
3.  **Implicação para Engenharia Verde:** A escolha de uma ferramenta com maior nível de abstração (Pandas) não resultou em ganhos de eficiência para a tarefa específica de **leitura, armazenamento e iteração simples**[cite: 228]. Pelo contrário, o _overhead_ introduzido pelo Pandas (devido à sua complexidade interna, otimizada para manipulações e não apenas para leitura) gerou um custo energético significativamente maior, reforçando a importância da seleção de ferramentas adequadas para **software verde**.
