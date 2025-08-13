# OEE – Protótipo (Lácteos) · Power BI

**Protótipo reprodutível** com **dados simulados** para cálculo de OEE (Overall Equipment Effectiveness) e análise de perdas.

## Objetivo
Consolidar **A/P/Q** e **OEE** por data/turno/linha/produto; ranquear **TOP 5 paradas**; simular **ganho de OEE**.

## Estrutura
```
oee-prototipo-leite/
├─ data/
│  ├─ oee_production_log.csv
│  └─ oee_products.csv
├─ docs/
│  ├─ prints/
│  └─ onepager.pdf
├─ pbix/
│  └─ OEE_Prototipo.pbix
├─ README.md
└─ LICENSE
```

## DAX (sugestão)
```
Planned Time (min) = SUM(Log[planned_time_min])
Run Time (min)     = SUM(Log[run_time_min])
Downtime (min)     = SUM(Log[downtime_min])

Total Units = SUM(Log[total_units])
Good Units  = SUM(Log[good_units])
Scrap Units = SUM(Log[scrap_units])

Theoretical Units =
SUMX(
    Log,
    ( Log[run_time_min] * 60.0 ) / RELATED(Products[ideal_cycle_time_sec])
)

Availability = DIVIDE([Run Time (min)],[Planned Time (min)])
Performance  = DIVIDE([Total Units],[Theoretical Units])
Quality      = DIVIDE([Good Units],[Total Units])
OEE          = [Availability] * [Performance] * [Quality]
```
