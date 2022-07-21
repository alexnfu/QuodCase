import $;

EXPORT FN_Atributes_Table(UNSIGNED4 data_filt) := FUNCTION   
    
   //entradas
   //Base_consumers := RECORD
   //   $.File_Quod.File.id_consumidor;
   //END;
   //consumer_table := TABLE($.File_Quod.File,Base_consumers);
   //consumers := DEDUP(consumer_table,id_consumidor);
   
   //atributos
   at1 := $.FN_Atributes.FN_N_Inadimplencias(data_filt);
   at2 := $.FN_Atributes.FN_6_meses_add(data_filt);
   at3 := $.FN_Atributes.FN_3_meses_add(data_filt);
   at4 := $.FN_Atributes.FN_Bancos_diferentes(data_filt);
   at6 := $.FN_Atributes.FN_inad_regularizadas(data_filt);
   at7 := $.FN_Atributes.FN_6_meses_exclusao(data_filt);
   at8 := $.FN_Atributes.FN_3_meses_exclusao(data_filt);
   at14 := $.FN_Atributes.FN_lastUpdate(data_filt);
   
   //Conc0 := JOIN(consumers,at1,LEFT.id_consumidor = RIGHT.id_consumidor,LEFT OUTER);
   Conc1 := JOIN(at1,at2,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   Conc2 := JOIN(Conc1,at3,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   Conc3 := JOIN(Conc2,at4,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   Conc4 := JOIN(Conc3,at6,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);   
   Conc5 := JOIN(Conc4,at7,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   Conc6 := JOIN(Conc5,at8,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   Conc7 := JOIN(Conc6,at14,LEFT.id_consumidor = RIGHT.id_consumidor,FULL OUTER);
   
   RETURN SORT(Conc7,id_consumidor);
   //RETURN OUTPUT(CHOOSEN(SORT(Conc4,id_consumidor),20));
END;