import os
import csv
import time
import pandas as pd
import pyRAPL

# ================================
# ⚙️ CONFIGURAÇÃO INICIAL
# ================================

# Diretório atual (onde este script está)
BASE_DIR = os.path.dirname(__file__)

# Diretório raiz do projeto (um nível acima)
ROOT_DIR = os.path.dirname(BASE_DIR)

# Caminho para os diretórios de dados e resultados (na raiz)
DIRETORIO_DADOS = os.path.join(ROOT_DIR, 'dados')
DIRETORIO_RESULTADOS = os.path.join(ROOT_DIR, 'resultados')

# Garante que os diretórios existam
os.makedirs(DIRETORIO_DADOS, exist_ok=True)
os.makedirs(DIRETORIO_RESULTADOS, exist_ok=True)

# Caminho completo do CSV de entrada e saída
CSV_DADOS = os.path.join(DIRETORIO_DADOS, 'cadastro_pf_100_000.csv')
CSV_RESULTADOS = os.path.join(DIRETORIO_RESULTADOS, 'resultados_medicoes_cadastro_pf_100_000.csv')

# ================================
# 🔋 CONFIGURAÇÃO pyRAPL
# ================================
pyRAPL.setup(devices=[pyRAPL.Device.PKG])

# ================================
# 📊 FUNÇÃO PRINCIPAL
# ================================
def get_dados_csv():
    print(f"--- 📖 Lendo o arquivo no caminho: {CSV_DADOS} ---")

    try:
        df = pd.read_csv(CSV_DADOS)
        print("\n--- ✅ Sucesso! Arquivo lido com sucesso! ---")
        # print(df.head())  # mostra apenas as primeiras linhas

        pd.set_option('display.max_rows', None)
        pd.set_option('display.max_columns', None)
        print(df)
    except FileNotFoundError:
        print(f"\n❌ ERRO: Arquivo não encontrado! Verifique se '{CSV_DADOS}' existe.")
    except Exception as e:
        print(f"\n❌ ERRO inesperado ao ler o arquivo:")
        print(e)

# ================================
# 🧪 EXECUÇÃO E MEDIÇÃO
# ================================
if __name__ == '__main__':
    print(f"📂 Resultados serão salvos em: {CSV_RESULTADOS}")

    with open(CSV_RESULTADOS, mode='w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['Execução', 'Tempo (s)', 'Energia (uJ)'])

    for i in range(1, 41):
        medicao = pyRAPL.Measurement(f"exec_{i}")

        inicio = time.time()
        medicao.begin()
        get_dados_csv()
        medicao.end()
        fim = time.time()

        tempo_execucao = round(fim - inicio, 3)
        energia = medicao.result.pkg  # energia em microjoules

        with open(CSV_RESULTADOS, mode='a', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([i, tempo_execucao, energia])

        print(f"✅ Execução {i} concluída | Tempo: {tempo_execucao}s | Energia: {energia} µJ")
        # time.sleep(1)

    print("\n🎉 Execuções concluídas com sucesso!")
    print(f"📊 Resultados salvos em: {CSV_RESULTADOS}")
