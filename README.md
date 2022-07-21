
# Case da Quod

Projeto da disciplina PRO3601 - Análise Massiva de Dados em Gestão de Operações (2022)

## Integrantes
- Alexander Heinrich Yuanlong Yang Nan Fu - 11262914
- Leonardo Martins Pires - 11262091
- Lucca Gamballi - 11261207
- Marcio Akira Imanishi de Moraes - 11262021

## Instalação

Para visualização dos gráficos gerados da nossa solução, instale o bundle Visualizer do HPPC.

```bash
cd “C:\Program Files (x86)\HPCCSystems\x.x.x\clienttools\bin”
ecl bundle install https://github.com/hpcc-systems/Visualizer.git --update --force
```
obs: no comando cd, substitua x.x.x pela versão correspondente a que você tem instalada.

## Book de atributos

- inad_ativ: total de inadimplências ainda não regularizados
- quitacoes: total de inadimplências regularizadas
- bancos_diferentes: possuiu inadimplências ativas em bancos diferentes
- data_update: última data de atualização
- inad_6_meses: número de inadimplências incluídas nos últimos 6 meses
- inad_3_meses: número de inadimplências incluídas nos últimos 3 meses
- quitacoes_6_meses: número de inadimplências excluídas nos últimos 6 meses
- quitacoes_3_meses: número de inadimplências excluídas nos últimos 3 meses


