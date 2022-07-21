#WORKUNIT('name', 'Inad_mensal');
IMPORT $;
IMPORT $.Visualizer;

atributos := $.File_Atributos.Atr_File;

//inadimplencia atual
inad_mensal := SORT(TABLE(atributos,{atributos.mes;cnt := SUM(GROUP,atributos.inad_ativ)},mes),mes);
meses_list := ['Janeiro','Fevereiro','Marco','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];

inad_Numerico := RECORD
  inad_mensal.mes;
  inad_mensal.cnt;
END;

inad_Rotulado := RECORD
  STRING9 meses;
  inad_mensal.cnt;
END;

inad_Rotulado aplicaRotulo(inad_Numerico L) := TRANSFORM
  self.meses := meses_list[L.mes];
  self := L;
 END;
 
inad_mensal_rotulado := PROJECT(inad_mensal,aplicaRotulo(LEFT));
                        
OUTPUT(inad_mensal_rotulado,NAMED('inad_mensal'));
$.Visualizer.MultiD.column('inadimplencia_por_mes', /*datasource*/, 'Inad_mensal', /*mappings*/, /*filteredBy*/, /*properties*/ );

//inadimplentes mensais
Pessoas_mensal := SORT(TABLE(atributos,{atributos.mes;atributos.id_consumidor;cnt := IF(atributos.inad_ativ>0,1,0);}),mes);
//meses_list := ['Janeiro','Fevereiro','Marco','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];
Pessoas_soma_mensal := TABLE(Pessoas_mensal,{Pessoas_mensal.mes;soma := SUM(GROUP,Pessoas_mensal.cnt);},mes);

Pessoas_Numerico := RECORD
  Pessoas_soma_mensal.mes;
  Pessoas_soma_mensal.soma;
END;

Pessoas_Rotulado := RECORD
  STRING9 meses;
  UNSIGNED soma;
END;

Pessoas_Rotulado aplicaRotuloP(Pessoas_Numerico L) := TRANSFORM
  self.meses := meses_list[L.mes];
  self := L;
 END;
 
Pessoas_mensal_rotulado := PROJECT(Pessoas_soma_mensal,aplicaRotuloP(LEFT));
                        
OUTPUT(Pessoas_mensal_rotulado,NAMED('Pessoas_mensal'));
$.Visualizer.MultiD.column('inadimplentes_por_mes', /*datasource*/, 'Pessoas_mensal', /*mappings*/, /*filteredBy*/, /*properties*/ );
