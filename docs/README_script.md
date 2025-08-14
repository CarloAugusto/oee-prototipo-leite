# Script de Simulação de Dados de OEE para Linha de Envase de Leite

**Autor:** Carlos Augusto Freitas Silva  
**Data:** 17/07/2025  
**Versão:** 1.0

---

## Objetivo

Este script tem como objetivo **gerar dados simulados de produção** para uma linha de envase de leite, calcular os indicadores de **OEE (Overall Equipment Effectiveness)** — *Disponibilidade*, *Performance* e *Qualidade* — e salvar os resultados em:

- Um **arquivo CSV** (`oee_prototipo_leite.csv`)
- Um **banco de dados SQLite** (`oee_prototipo_leite.db`)

Esses arquivos podem ser utilizados para visualização e análise no **Power BI** ou em outras ferramentas analíticas.

---

## Dependências

O script utiliza as seguintes bibliotecas R:

```r
install.packages(c("RSQLite", "dplyr", "lubridate"))
```

- **RSQLite** → Criação e manipulação do banco SQLite
- **dplyr** → Manipulação e transformação de dados
- **lubridate** → Manipulação de datas

---

## Fluxo do Script

1. **Definição de parâmetros fixos**
   - Tempo de turno (`480` min = 8h)
   - Velocidade teórica da máquina (`120` caixas/min)
   - Lista de produtos: *Leite Integral*, *Leite Desnatado*, *Leite Semidesnatado*
   - Turnos: *Manhã*, *Tarde*, *Noite*

2. **Função `gerar_dados_producao()`**
   - Gera dados simulados para um dia de produção
   - Simula:
     - **Paradas não planejadas**: entre 15 e 60 min
     - **Fator de performance**: 88% a 97% da capacidade
     - **Taxa de defeito**: 0,5% a 2,5%
     - Produto aleatório por turno

3. **Geração para múltiplos dias**
   - Período: últimos **90 dias**
   - Uso de `lapply()` para repetir a função em cada data

4. **Cálculo dos indicadores OEE**
   - **Disponibilidade** = Tempo Real de Produção / Tempo Planejado 
   - **Performance** = Produção Total / Produção Teórica Possível       
   - **Qualidade** = Produção Boa / Produção Total 
   - **OEE** = Disponibilidade × Performance × Qualidade

5. **Exportação**
   - **CSV** → `data/oee_prototipo_leite.csv`
   - **SQLite DB** → `data/oee_prototipo_leite.db`  
     - Tabela criada: `dados_oee`

---

## Exemplo de Saída

| Data       | Turno  | Produto           | Disponibilidade | Performance | Qualidade | OEE   | ProducaoTotal | ProducaoBoa | ProducaoDefeituosa | TempoReal | Paradas |
|------------|--------|-------------------|-----------------|-------------|-----------|-------|---------------|-------------|--------------------|-----------|---------|
| 2025-05-16 | Manhã  | Leite Integral    | 0.938           | 0.956       | 0.982     | 0.880 | 53834         | 52850       | 984                | 451       | 29      |
| 2025-05-16 | Tarde  | Leite Desnatado   | 0.917           | 0.943       | 0.976     | 0.845 | 52389         | 51104       | 1285               | 440       | 40      |

---

## Observações
- O `.db` é um **arquivo SQLite**, ou seja, um banco de dados relacional em SQL armazenado localmente.
- Os valores gerados são **simulados** e não representam dados reais de produção.
- É possível alterar o número de dias simulados modificando:
  ```r
  datas_producao <- seq(from = data_final - days(89), to = data_final, by = "day")
  ```
- Para mudar a velocidade teórica da máquina, altere:
  ```r
  VELOCIDADE_TEORICA_CAIXAS_MIN <- 120
  ```
  ## Observações sobre importação no Power BI

> **Atenção:** O arquivo `.csv` gerado utiliza **ponto (`.`)** como separador decimal (padrão americano).  
> Se o **Power BI** estiver configurado para **Português (Brasil)**, as colunas decimais podem ser interpretadas incorretamente como números inteiros  
> *(ex.: `0.9562` sendo lido como `9562`)*.

As variáveis afetadas são:

- `Disponibilidade`
- `Performance`
- `Qualidade`
- `OEE`  
Todas variam de **0.0 a 1.0**.

---

