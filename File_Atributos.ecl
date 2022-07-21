import $;

EXPORT File_Atributos := MODULE
  EXPORT Atr_Layout := RECORD
    UNSIGNED1 mes;
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
  EXPORT Atr_File := DATASET('~class::lmp::atributos',Atr_Layout,FLAT);
END;