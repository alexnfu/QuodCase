EXPORT File_Quod := MODULE
	EXPORT Layout := RECORD
    STRING32 origem;
    UNSIGNED4 data_recebimento;
    STRING32 id_consumidor;
    STRING1 tipo_pessoa;
    STRING32 id_inad1;
    STRING32 id_inad2;
    UNSIGNED1 tipo_baixa;
    UNSIGNED1 contagem;
    REAL8 data_mov;
    REAL4 comando;
  END;
	EXPORT File := DATASET('~class::tema1::base_inadimplencia_ccf.csv',Layout,CSV(heading(1)));
END;