IMPORT $;

EXPORT FN_Atributes := MODULE
  
  //atributo 1: n. de inadimplencias
  EXPORT FN_N_Inadimplencias(UNSIGNED4 data_filt) := FUNCTION

    filteredQuod := $.File_Quod.File(data_recebimento <= data_filt);
    //IDX_filteredQuod := $.File_Quod.IDX_File(data_recebimento <= data_filt);
    
    Contas := RECORD
      filteredQuod.id_consumidor;
      cnt10 := SUM(GROUP,filteredQuod.contagem,filteredQuod.comando = 10.0);
      cnt50 := SUM(GROUP,filteredQuod.contagem,filteredQuod.comando = 50.0);
    END;

    tableID := TABLE(filteredQuod,Contas,id_consumidor);

    Saldo := RECORD
      UNSIGNED1 mes;
      filteredQuod.id_consumidor;
      UNSIGNED1 inad_ativ; 
    END;
    
    //mes := ['janeiro','fevereiro','marco','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'];
    Saldo calculoSaldo(Contas L) := TRANSFORM
      self.mes := (data_filt%10000-data_filt%100)/100;
      self := L;
      self.inad_ativ := L.cnt10 - L.cnt50;
     END;
     
    SaldoPessoa := PROJECT(tableID,calculoSaldo(LEFT));

    RETURN SaldoPessoa;
    
  END;
  
  //atributo 2: dividas em 6 meses
  EXPORT FN_6_meses_add(UNSIGNED4 data_filt) := FUNCTION
    
    limite_inf := IF((data_filt%10000-data_filt%100)/100 < 6,data_filt-10000-600+1200+data_filt%1000,data_filt-600);
    filteredQuod1 :=  $.File_Quod.File(data_recebimento < data_filt AND data_recebimento > limite_inf);

    DividasLayout := RECORD
      filteredQuod1.id_consumidor;
      inad_6_meses := SUM(GROUP,filteredQuod1.contagem,filteredQuod1.comando = 10.0);
    END;

    DividaPessoas := TABLE(filteredQuod1,DividasLayout,id_consumidor);
    RETURN DividaPessoas;
    
  END;
  
  //atributo 3: dividas em 3 meses
  EXPORT FN_3_meses_add(UNSIGNED4 data_filt) := FUNCTION
    
    limite_inferior := IF((data_filt%10000-data_filt%100)/100 < 3,
                          data_filt-10000-300+1200+data_filt%1000,
                          data_filt-300);
    filteredQuod_3m :=  $.File_Quod.File(data_recebimento < data_filt 
                                         AND data_recebimento > limite_inferior);

    DividasLayout3 := RECORD
      filteredQuod_3m.id_consumidor;
      inad_3_meses := SUM(GROUP,filteredQuod_3m.contagem,filteredQuod_3m.comando = 10.0);
    END;

    DividaPessoas_3m := TABLE(filteredQuod_3m,DividasLayout3,id_consumidor);
    RETURN DividaPessoas_3m;
    
  END; 
  
  //Atributo 4: possui inadimplencias ativas em bancos diferentes
  EXPORT FN_Bancos_diferentes(UNSIGNED4 data_filt) := FUNCTION
    
    filteredQuod := $.File_Quod.File(data_recebimento <= data_filt);
    BancoPorPessoa := RECORD
      filteredQuod.id_consumidor;
      filteredQuod.id_inad1;
    END;
    BancoPessoas := TABLE(filteredQuod,BancoPorPessoa);

    N_bancos := RECORD
      BancoPessoas.id_consumidor;
      UNSIGNED n := COUNT(GROUP);
    END;
    NBancos := TABLE(DEDUP(BancoPessoas,LEFT.id_inad1=RIGHT.id_inad1,ALL),N_bancos,id_consumidor,id_inad1);  
    
    atr_N_bancos := RECORD
      BancoPessoas.id_consumidor;
      BOOLEAN bancos_diferentes;
    END;

    atr_N_bancos atrCalc(N_bancos L) := TRANSFORM
      self.id_consumidor := L.id_consumidor;
      self.bancos_diferentes := IF(L.n > 1, True, False);
    END;
    Atr_Banco := PROJECT(Nbancos,atrCalc(LEFT));
    
    RETURN Atr_Banco;
  END;
  
  //Atributo 6: total de inadimpl?ncias regularizadas
  EXPORT FN_inad_regularizadas(UNSIGNED4 data_filt) := FUNCTION
  
    filteredQuod := $.File_Quod.File(data_recebimento <= data_filt);
    
    PagamentoLayout := RECORD
          filteredQuod.id_consumidor;
          quitacoes := SUM(GROUP,filteredQuod.contagem,filteredQuod.comando = 50.0);
    END;

    PagoPessoas := TABLE(filteredQuod,PagamentoLayout,id_consumidor);
    RETURN PagoPessoas;   
    
  END;

  //Atributo 14: ultima atualizacao  
  EXPORT FN_lastUpdate(UNSIGNED4 data_filt) := FUNCTION
    
    filteredQuod := $.File_Quod.File(data_recebimento <= data_filt);
    
    LastDate := RECORD
      filteredQuod.id_consumidor;
      UNSIGNED4 data_update := MAX(GROUP,filteredQuod.data_recebimento);
    END;
    LastUpdate := TABLE(filteredQuod,LastDate,id_consumidor,data_recebimento);
    RETURN DEDUP(SORT(LastUpdate,id_consumidor,-data_update),id_consumidor,BEST(-data_update));
  
  END;
  //Atributo 7: n?mero de inadimpl?ncias exclu?das nos ?ltimos 6 meses
  EXPORT FN_6_meses_exclusao(UNSIGNED4 data_filt) := FUNCTION
    
    limite_inf := IF((data_filt%10000-data_filt%100)/100 < 6,data_filt-10000-600+1200+data_filt%1000,data_filt-600);
    filteredQuod1 :=  $.File_Quod.File(data_recebimento < data_filt AND data_recebimento > limite_inf);

    DividasLayout := RECORD
      filteredQuod1.id_consumidor;
      quitacoes_6_meses := SUM(GROUP,filteredQuod1.contagem,filteredQuod1.comando = 50.0);
    END;

    ExclusaoDivida := TABLE(filteredQuod1,DividasLayout,id_consumidor);
    RETURN ExclusaoDivida;
    
  END;
  
  //Atributo 8: n?mero de inadimpl?ncias exclu?das nos ?ltimos 3 meses
  EXPORT FN_3_meses_exclusao(UNSIGNED4 data_filt) := FUNCTION
    
    limite_inf := IF((data_filt%10000-data_filt%100)/100 < 3,data_filt-10000-300+1200+data_filt%1000,data_filt-300);
    filteredQuod1 := $.File_Quod.File(data_recebimento < data_filt AND data_recebimento > limite_inf);
    
    DividasLayout := RECORD
      filteredQuod1.id_consumidor;
      quitacoes_3_meses := SUM(GROUP,filteredQuod1.contagem,filteredQuod1.comando = 50.0);
    END;

    ExclusaoDivida := TABLE(filteredQuod1,DividasLayout,id_consumidor);
    RETURN ExclusaoDivida;
    
  END; 
  //Atributo 5: possui mais de uma inadimpl?ncia ativa em um mesmo banco
  //Atributo 9: possui inadimpl?ncias regularizadas em bancos diferentes
  //Atributo 10: possui mais de uma inadimpl?ncia regularizada em um mesmo banco
  //Atributo 11: indicador de inadimpl?ncias ativas
  //Atributo 12: indicador de inadimpl?ncias regularizadas
  //Atributo 13: tempo m?dio para quitar as d?vidas 
  
END;
