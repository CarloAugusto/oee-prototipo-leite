# OEE (Overall Equipment Effectiveness)
OEE, ou Eficácia Geral do Equipamento, é um indicador chave de desempenho (KPI) usado para medir a eficiência de um processo de manufatura. É um "raio-x" da saúde e do desempenho de uma linha de produção. Combina três fatores importantes em uma única métrica, mostrando o percentual do tempo de produção que é verdadeiramente produtivo.

O OEE é calculado multiplicando três componentes:
OEE = Disponibilidade x Performance x Qualidade


Disponibilidade: Mede as perdas de tempo por paradas não planejadas.

    O que ela responde? "Quanto tempo a minha máquina realmente operou em comparação com o tempo que ela deveria ter operado?"
    Cálculo: (Tempo em Produção) / (Tempo Total Planejado)
    Exemplos de perdas: Quebras de equipamento, falta de matéria-prima, tempo de setup e ajustes.


Performance (ou Desempenho): Mede as perdas de velocidade.

    O que ela responde? "A minha máquina produziu na velocidade máxima que ela foi projetada para produzir?"
    Cálculo: (Produção Real) / (Produção Teórica no Tempo em Produção)
    Exemplos de perdas: Pequenas paradas não registradas, operação em velocidade reduzida, equipamento desgastado.


Qualidade: Mede as perdas por produtos defeituosos.

    O que ela responde? "Quantos dos produtos que eu fabriquei estão bons e sem defeitos, prontos para o cliente?"
    Cálculo: (Produtos Bons) / (Produção Real Total)
    Exemplos de perdas: Produtos que precisam de retrabalho, produtos descartados (sucata).

O resultado final é um percentual. Uma pontuação de 100% no OEE significa que você está produzindo apenas peças boas, o mais rápido possível, sem tempo de parada. 

Passo 1: Entender e Gerar os Dados
Cenário: Uma linha de envase de leite UHT (longa vida) em uma fábrica.

Crie uma Planilha (Excel/Google Sheets): Esta será sua base de dados (seu "CSV/SQL" do projeto). Crie colunas que representem os dados coletados em um turno de 8 horas (480 minutos).

    Data: Data da produção.
    Turno: Manhã, Tarde, Noite.
    Produto: Leite Integral, Leite Desnatado.
    Tempo_Planejado_Producao_min: 480 minutos.
    Tempo_Paradas_Nao_Planejadas_min: Simule valores aqui. Ex: 30 min (quebra), 15 min (falta de embalagem).
    Velocidade_Teorica_Caixas_por_min: A velocidade ideal da máquina. Ex: 100 caixas/min.
    Total_Produzido_Caixas: O número total de caixas que saíram da máquina. Ex: 39.000.
    Total_Caixas_Defeituosas: Caixas com defeito (vazamento, peso incorreto). Ex: 400.

Dica: Crie dados para vários dias para que seu dashboard tenha mais informações para analisar

Passo 2: Calcular os Indicadores na Própria Planilha


    Tempo_Real_Producao_min: Tempo_Planejado_Producao_min - Tempo_Paradas_Nao_Planejadas_min
    Disponibilidade_%: (Tempo_Real_Producao_min / Tempo_Planejado_Producao_min) * 100
    Producao_Teorica_Possivel: Tempo_Real_Producao_min * Velocidade_Teorica_Caixas_por_min
    Performance_%: (Total_Produzido_Caixas / Producao_Teorica_Possivel) * 100
    Total_Caixas_Boas: Total_Produzido_Caixas - Total_Caixas_Defeituosas
    Qualidade_%: (Total_Caixas_Boas / Total_Produzido_Caixas) * 100
    OEE_%: (Disponibilidade_% / 100) * (Performance_% / 100) * (Qualidade_% / 100) * 100

Passo 3: Construir o Dashboard no Power BI
Esta é a parte visual, onde você demonstra sua habilidade com a ferramenta.

    Importe os Dados: Conecte o Power BI à sua planilha de dados.
    Crie os Visuais:
        Cards de Destaque: Coloque os KPIs principais (OEE, Disponibilidade, Performance, Qualidade) em destaque, com a média do período.
        Gráfico de OEE ao Longo do Tempo: Um gráfico de linha mostrando a evolução do OEE dia a dia.
        Gráfico de Pareto para Paradas: Crie um gráfico de barras para mostrar os maiores motivos de parada (ex: "Quebra de Equipamento", "Falta de Material", "Setup"). Isso mostra que você sabe identificar e priorizar problemas.
        Gráfico de Pizza para Qualidade: Mostrando a proporção de "Produtos Bons" vs. "Produtos com Defeito".
        Filtros: Adicione filtros (Slicers) para que o usuário possa selecionar a Data, o Turno ou o Produto e ver os dados específicos.

Passo 4: Publicar e Documentar no GitHub

    Repositório no GitHub (oee-prototipo-leite):
        README.md: Este é o seu cartão de visitas. Explique o projeto de forma clara.
            Objetivo: "Desenvolver um protótipo de dashboard de OEE para simular a eficiência de uma linha de produção de leite, demonstrando habilidades em análise de dados, Power BI e compreensão de KPIs industriais."
            Ferramentas: "Excel (para simulação de dados), Power BI (para visualização) e GitHub (para documentação)."
            Metodologia: Explique brevemente o que é OEE e como você calculou os três indicadores.
            Como Usar: Coloque o link público do seu dashboard do Power BI aqui.
        Pasta dados: Suba a sua planilha Excel com os dados simulados.
        Pasta imagens: Tire prints do seu dashboard finalizado e coloque aqui, exibindo-os no README.md.
    Publicar o Power BI: Use a função "Publicar na Web" do Power BI para gerar um link público e incorporável do seu dashboard. Atenção: Use apenas dados fictícios, pois este link será público.

