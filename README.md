# Contexto
Uma planta de lácteos com linhas de UHT e pasteurização reporta baixa previsibilidade de produção e dificuldade em priorizar causas de perda. Indicadores estão dispersos (planilhas e apontamentos manuais), o que atrasa decisões de manutenção, qualidade e engenharia de processo.

# Problema de negócio
Falta um painel único que consolide OEE (Availability, Performance, Quality) por linha/turno/produto, evidencie TOP 5 motivos de parada e estime ganhos potenciais ao reduzir as principais perdas.

Objetivo do protótipo
Entregar, em formato Power BI, um modelo reproduzível de OEE com:

    Cálculo padronizado de A/P/Q e OEE (por data, linha, turno, produto);

    Pareto de downtime com drill-down por motivo;

    Cenário: simulação de redução de paradas e impacto no OEE;

    Políticas documentadas (o que entra como downtime, janelas excluídas, ciclo ideal por produto).

    Escopo & Dados

    Dados simulados (didáticos) por data/turno/linha/produto (oee_production_log.csv) e ciclo ideal por produto (oee_products.csv).

    Unidades: minutos (tempo) e unidades (produção/defeitos).

    Métricas principais:

        Availability = RunTime / PlannedTime

        Performance = TotalUnits / TheoreticalUnits com TheoreticalUnits = (RunTime*60)/IdealCycleTimeSec

        Quality = GoodUnits / TotalUnits

        OEE = Availability × Performance × Quality

Critérios de sucesso

    Visualizar OEE diário por linha/turno com tendência;

    Identificar TOP 5 perdas em ≤ 3 cliques;

    Estimar ∆OEE ao reduzir a maior causa em X% (parâmetro no relatório);

    README explicando regras e premissas para auditoria/qualidade.

Entregáveis

    .pbix (Power BI) + README.md + prints + PDF one-pager.

    (Opcional) Demo pública via Power BI “Publicar na Web”.
