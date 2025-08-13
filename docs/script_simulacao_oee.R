# Título: Script para Geração de Dados Simulados de OEE para Linha de Leite
# Autor: Carlos Augusto Freitas Silva
# Data: 17/07/2025
# Descrição: Este script gera dados de produção simulados para uma linha de envase de leite,
#            calcula os indicadores de OEE (Disponibilidade, Performance, Qualidade) e
#            armazena o resultado em um banco de dados SQLite para posterior análise no Power BI.

# --- PASSO 1: Instalar e Carregar as Bibliotecas ---

# Verifique se os pacotes estão instalados; se não, instale-os.
if (!require("RSQLite")) install.packages("RSQLite")
if (!require("dplyr")) install.packages("dplyr")
if (!require("lubridate")) install.packages("lubridate")

library(RSQLite)
library(dplyr)
library(lubridate)

# --- PASSO 2: Definir Parâmetros da Simulação ---

# Parâmetros fixos da linha de produção
TEMPO_TURNO_MIN <- 480 # 8 horas
VELOCIDADE_TEORICA_CAIXAS_MIN <- 120 # Capacidade máxima da máquina
PRODUTOS <- c("Leite Integral", "Leite Desnatado", "Leite Semidesnatado")
TURNOS <- c("Manhã", "Tarde", "Noite")

# --- PASSO 3: Função para Gerar Dados de um Dia ---

gerar_dados_producao <- function(data_producao) {
  
  dados_dia <- data.frame()
  
  for (turno_atual in TURNOS) {
    
    # Simular paradas não planejadas (em minutos)
    # Ex: entre 15 e 60 minutos de paradas por turno
    paradas_nao_planejadas <- round(runif(1, min = 15, max = 60))
    
    # Simular pequenas variações na produção real
    # A produção real será um pouco menor que a teórica devido a micro-paradas
    fator_performance <- runif(1, min = 0.88, max = 0.97) 
    
    # Simular a quantidade de produtos defeituosos
    # Taxa de defeito entre 0.5% e 2.5%
    taxa_defeito <- runif(1, min = 0.005, max = 0.025)
    
    # Selecionar um produto aleatório para o turno
    produto_do_turno <- sample(PRODUTOS, 1)
    
    # Criar um registro (linha) para este turno
    registro_turno <- data.frame(
      Data = as.Date(data_producao),
      Turno = turno_atual,
      Produto = produto_do_turno,
      TempoPlanejado_min = TEMPO_TURNO_MIN,
      ParadasNaoPlanejadas_min = paradas_nao_planejadas,
      VelocidadeTeorica_caixas_min = VELOCIDADE_TEORICA_CAIXAS_MIN,
      FatorPerformanceSimulado = fator_performance, # Apenas para cálculo
      TaxaDefeitoSimulada = taxa_defeito # Apenas para cálculo
    )
    
    dados_dia <- rbind(dados_dia, registro_turno)
  }
  
  return(dados_dia)
}

# --- PASSO 4: Gerar Dados para um Período (Ex: 90 dias) ---

# Gerar dados para os últimos 90 dias a partir de hoje
data_final <- Sys.Date()
datas_producao <- seq(from = data_final - days(89), to = data_final, by = "day")

# Usar lapply para aplicar a função a cada dia e rbind para juntar tudo em um dataframe
dados_brutos_completos <- do.call(rbind, lapply(datas_producao, gerar_dados_producao))

# --- PASSO 5: Calcular os Indicadores OEE ---

dados_calculados_oee <- dados_brutos_completos %>%
  mutate(
    # A. Cálculo da Disponibilidade
    TempoRealProducao_min = TempoPlanejado_min - ParadasNaoPlanejadas_min,
    Disponibilidade = (TempoRealProducao_min / TempoPlanejado_min),
    
    # B. Cálculo da Performance
    ProducaoTotal_caixas = floor(TempoRealProducao_min * VelocidadeTeorica_caixas_min * FatorPerformanceSimulado),
    ProducaoTeoricaPossivel_caixas = TempoRealProducao_min * VelocidadeTeorica_caixas_min,
    Performance = (ProducaoTotal_caixas / ProducaoTeoricaPossivel_caixas),
    
    # C. Cálculo da Qualidade
    ProducaoDefeituosa_caixas = floor(ProducaoTotal_caixas * TaxaDefeitoSimulada),
    ProducaoBoa_caixas = ProducaoTotal_caixas - ProducaoDefeituosa_caixas,
    Qualidade = (ProducaoBoa_caixas / ProducaoTotal_caixas),
    
    # D. Cálculo do OEE
    OEE = Disponibilidade * Performance * Qualidade
  ) %>%
  # Selecionar e renomear as colunas finais para o banco de dados
  select(
    Data,
    Turno,
    Produto,
    Disponibilidade,
    Performance,
    Qualidade,
    OEE,
    ProducaoTotal_caixas,
    ProducaoBoa_caixas,
    ProducaoDefeituosa_caixas,
    TempoRealProducao_min,
    ParadasNaoPlanejadas_min
  )

# Arredondar os percentuais para melhor visualização
dados_calculados_oee <- dados_calculados_oee %>%
  mutate(across(c(Disponibilidade, Performance, Qualidade, OEE), ~round(.x, 4)))

# Visualizar as primeiras linhas para conferir
head(dados_calculados_oee)

# --- PASSO EXTRA: Salvar também em CSV ---
csv_path <- file.path(getwd(), "oee_prototipo_leite.csv")

write.csv(dados_calculados_oee, csv_path, row.names = FALSE)

cat("Arquivo CSV salvo em:", csv_path, "\n")


# --- PASSO 6: Armazenar os Dados em um Banco de Dados SQLite (Versão Corrigida) ---

# Definir o nome do arquivo do banco de dados
db_path <- "oee_prototipo_leite.db"

# 1. Criar a conexão. O RSQLite criará o arquivo .db se ele não existir.
#    Não é mais necessário apagar o arquivo manualmente antes.
con <- dbConnect(RSQLite::SQLite(), dbname = db_path)

# 2. Escrever o dataframe na tabela 'dados_oee'.
#    O argumento 'overwrite = TRUE' garante que, se a tabela já existir,
#    ela será substituída pelos novos dados. Isso torna o código mais robusto.
dbWriteTable(con, "dados_oee", dados_calculados_oee, overwrite = TRUE, row.names = FALSE)

# Listar tabelas para confirmar que a tabela 'dados_oee' foi criada com sucesso
cat("Tabelas no banco de dados:\n")
print(dbListTables(con))

# Desconectar do banco de dados para liberar o arquivo
dbDisconnect(con)

# Mensagem final de sucesso
cat("\n") # Adiciona uma linha em branco para espaçamento
print(paste("Banco de dados '", db_path, "' populado com sucesso!"))
print(paste("Total de registros inseridos:", nrow(dados_calculados_oee)))
print("O arquivo está pronto para ser importado no Power BI.")

