import $;

 /*
 table_mensal_id := RECORD
  STRING8 mes;
  string32 id_consumidor;
  unsigned1 inad_ativ;
  integer8 inad_6_meses;
  integer8 inad_3_meses;
  boolean bancos_diferentes;
  integer8 quitacoes;
  integer8 quitacoes_6_meses;
  integer8 quitacoes_3_meses;
  unsigned4 data_update;
 END;
*/ 

//tabelas de atributos mensais em 2021
janeiro   := $.FN_Atributes_Table(20210131);
fevereiro := $.FN_Atributes_Table(20210228);
marco     := $.FN_Atributes_Table(20210331);
abril     := $.FN_Atributes_Table(20210430);
maio      := $.FN_Atributes_Table(20210531);
junho     := $.FN_Atributes_Table(20210630);
julho     := $.FN_Atributes_Table(20210731);
agosto    := $.FN_Atributes_Table(20210831);
setembro  := $.FN_Atributes_Table(20210930);
outubro   := $.FN_Atributes_Table(20211031);
novembro  := $.FN_Atributes_Table(20211130);
dezembro  := $.FN_Atributes_Table(20211231);

total  := janeiro + fevereiro + marco + abril + maio + junho + 
          julho + agosto + setembro + outubro+novembro+dezembro;
  
OUTPUT(total,,'~class::lmp::atributos',OVERWRITE);

