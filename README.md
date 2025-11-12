# Projeto_Engenharia_Verde
Projeto acadêmico na UTFPR (Universidade Federal do Paraná) para medir e comparar o consumo de energia de algoritmos em Python (puro vs. Pandas), aplicando conceitos de Engenharia Verde.

## 🔬 Metodologia e Definição do Experimento

Este projeto realiza um estudo empírico para comparar a eficiência energética de duas abordagens populares de processamento de dados em Python:

1.  **Python Puro:** Utilizando o módulo nativo `csv`.
2.  **Biblioteca Pandas:** Uma biblioteca de alto desempenho para análise de dados.

[cite_start]O objetivo é responder à pergunta: **A abordagem com Pandas é mais eficiente energeticamente do que a abordagem com Python puro?** 

### A Tarefa
Ambas as implementações executaram uma tarefa idêntica para permitir uma comparação justa:
* [cite_start]Ler um arquivo CSV de dados 
* [cite_start]Armazenar os dados em memória 
* [cite_start]Iterar sobre todos os registros 
* [cite_start]Imprimir os registros no console 

[cite_start]A métrica principal é o **Consumo de Energia (em Joules)** [cite: 79, 81][cite_start], medido com a ferramenta `PyrAPL`[cite: 82].

### Documento de Definição
[cite_start]A metodologia completa, incluindo as hipóteses formais (Nula e Alternativa) [cite: 64, 68][cite_start], as Perguntas de Pesquisa (RQs) [cite: 70] [cite_start]e o fluxo detalhado da execução [cite: 100-142], está detalhada no documento acadêmico abaixo:

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
