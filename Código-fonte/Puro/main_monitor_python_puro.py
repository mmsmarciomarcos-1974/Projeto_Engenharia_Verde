import csv
import time
import os
import pyRAPL

pyRAPL.setup(devices=[pyRAPL.Device.PKG])

def ler_csv():
    """Lê o arquivo CSV de forma pura (sem pandas) e imprime parte do conteúdo."""
    base_dir = os.path.dirname(os.path.abspath(__file__))
    caminho_csv = os.path.join(base_dir, "..", "dados", "cadastro_pf_100_000.csv")
    caminho_csv = os.path.normpath(caminho_csv)

    print(f"\n📘 Lendo arquivo: {caminho_csv}")
    linhas = []

    try:
        with open(caminho_csv, mode="r", encoding="utf-8") as f:
            leitor = csv.reader(f)
            cabecalho = next(leitor)
            linhas = list(leitor)
            total = len(linhas)

        print(f"\n✅ Leitura concluída com sucesso! Total de linhas: {total}")
        print(linhas)

    except FileNotFoundError:
        print(f"\n❌ ERRO: Arquivo não encontrado em: {caminho_csv}")
    except Exception as e:
        print(f"\n❌ ERRO inesperado: {e}")


def monitorar_leitura():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    pasta_resultados = os.path.join(base_dir, "..", "resultados")
    os.makedirs(pasta_resultados, exist_ok=True)
    resultados_csv = os.path.join(pasta_resultados, "resultados_python_puro_cadastro_pf_100_000.csv")

    print(f"\n📊 Resultados serão salvos em: {resultados_csv}")

    with open(resultados_csv, mode="w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["Execução", "Tempo (s)", "Energia (µJ)"])

    for i in range(1, 41):
        print(f"\n===============================")
        print(f"🚀 Execução {i}/40 iniciada...")
        print(f"===============================")

        medicao = pyRAPL.Measurement(f"execucao_{i}")
        medicao.begin()
        inicio = time.perf_counter()

        ler_csv()

        fim = time.perf_counter()
        medicao.end()

        tempo_exec = fim - inicio
        energia_pkg = medicao.result.pkg  # consumo do pacote da CPU

        print(f"\n⚡ Energia consumida: {energia_pkg} µJ")
        print(f"⏱️ Tempo decorrido: {tempo_exec:.4f} s")

        with open(resultados_csv, mode="a", newline="") as f:
            writer = csv.writer(f)
            writer.writerow([i, round(tempo_exec, 4), energia_pkg])

        print(f"✅ Execução {i} concluída e salva.")

if __name__ == "__main__":
    monitorar_leitura()
