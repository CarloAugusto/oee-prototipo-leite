Contexto
A planta de lácteos (UHT e pasteurização) tem baixa previsibilidade e dificuldade em priorizar causas de perda. Indicadores ficam dispersos em planilhas/apontamentos manuais, atrasando decisões de manutenção, qualidade e engenharia.

Problema de negócio
Não há um painel único que consolide OEE por linha/turno/produto, destaque TOP 5 motivos de parada e estime ganho potencial ao reduzir as principais perdas.

Objetivo do protótipo
Entregar um Power BI reprodutível com:

Cálculo padronizado de A/P/Q e OEE;

Pareto de downtime com drill-down por motivo;

Cenário de redução do maior motivo (parâmetro) e cálculo do ∆OEE;

Políticas documentadas (o que entra como downtime, janelas excluídas, ciclo ideal por produto).

Dados & escopo

Simulados por data × turno × linha × produto (data/oee_production_log.csv) + ciclo ideal por produto (data/oee_products.csv).

Métricas: Availability = RunTime/PlannedTime; Performance = TotalUnits/TheoreticalUnits; Quality = Good/Total;
OEE = Availability × Performance × Quality.

Critérios de sucesso

Visualizar tendência de OEE diário por linha/turno;

Identificar TOP 5 perdas em ≤ 3 cliques;

Estimar ganho de OEE com redução de X% no maior motivo;

README com regras de cálculo e premissas.
