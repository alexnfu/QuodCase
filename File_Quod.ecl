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
	EXPORT File := DATASET('~class::lmp::base_inadimplencia',Layout,CSV(heading(1)));
  //EXPORT IDX_File := INDEX(File,{id_consumidor},{contagem,comando,data_recebimento},'~class::lmp::index::base_atributo1');
END;