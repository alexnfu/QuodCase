import $;

QuodBase := $.File_Quod.File;

//OUTPUT(COUNT(QuodBase));
//OUTPUT(COUNT(QuodBase(data_mov=99999999))); //>20220507
//OUTPUT(QuodBase(data_mov=99999999));

//teste de numeros de entradas por pessoa
pessoas := RECORD
   QuodBase.id_consumidor;
    cnt := COUNT(GROUP);
END;

tablePessoas := TABLE(QuodBase,pessoas,id_consumidor);
//output(tablepessoas,ALL,NAMED('tablePessoas'));
//output(COUNT(tablepessoas),NAMED('NPessoas'));

//segmentacao em contadas quitadas e pendentes por id
filteredQuod := QuodBase(data_recebimento < 99999999);

Contas := RECORD
  filteredQuod.id_consumidor;
  cnt10 := SUM(GROUP,filteredQuod.contagem,filteredQuod.comando = 10.0);
  cnt50 := SUM(GROUP,filteredQuod.contagem,filteredQuod.comando = 50.0);
END;

tableID := TABLE(filteredQuod,Contas,id_consumidor);
//SORT(tableID,id_consumidor);
//COUNT(tableID);

Saldo := RECORD
  filteredQuod.id_consumidor;
  UNSIGNED1 saldo; 
END;

Saldo calculoSaldo(Contas L) := TRANSFORM
  self := L;
  self.saldo := L.cnt10 - L.cnt50;
 END;
 
SaldoPessoa := PROJECT(tableID,calculoSaldo(LEFT));
//OUTPUT(SORT(SaldoPessoa,id_consumidor),NAMED('SaldoPessoas'));

//entrada de dividas no ultimos 6 meses
data_qualquer := 20211010;
limite_inf := data_qualquer - 600;
filteredQuod1 := QuodBase(data_recebimento < data_qualquer AND data_recebimento > limite_inf);

DividasLayout := RECORD
  filteredQuod1.id_consumidor;
  cnt := SUM(GROUP,filteredQuod1.contagem,filteredQuod1.comando = 10.0);
END;

DividaPessoas := TABLE(filteredQuod1,DividasLayout,id_consumidor);
//OUTPUT(SORT(DividaPessoas,id_consumidor),NAMED('dividas6meses'));

//teste das funcoes
//OUTPUT($.FN_Atributes.FN_N_Inadimplencias(20211101));
//OUTPUT($.FN_Atributes.FN_6_meses_add(20211101));
OUTPUT($.FN_Atributes_Table(20211101),NAMED('Atributos'));
OUTPUT(COUNT($.FN_Atributes_Table(20211101)),NAMED('Consumidores_c_Atributos'));
//bancos diferentes
Bancos := RECORD
  filteredQuod.id_consumidor;
  filteredQuod.id_inad1;
END;
BancoPessoas := TABLE(filteredQuod,Bancos);

N_bancos := RECORD
  BancoPessoas.id_consumidor;
  UNSIGNED n := COUNT(GROUP);
END;
NBancos := TABLE(DEDUP(BancoPessoas,LEFT.id_inad1=RIGHT.id_inad1),N_bancos,id_consumidor,id_inad1);

//OUTPUT(SORT(NBancos,id_consumidor),NAMED('nbancos'));
//OUTPUT(COUNT(DEDUP(BancoPessoas,LEFT.id_inad1=RIGHT.id_inad1)));
   
 data_filt := 20211001;
 at1 := $.FN_Atributes.FN_N_Inadimplencias(data_filt);
 at2 := $.FN_Atributes.FN_6_meses_add(data_filt);
 at3 := $.FN_Atributes.FN_3_meses_add(data_filt);
 at4 := $.FN_Atributes.FN_Bancos_diferentes(data_filt);
 at14 := $.FN_Atributes.FN_lastUpdate(data_filt);
 
 at7 := $.FN_Atributes.FN_6_meses_exclusao(data_filt);
 at8 := $.FN_Atributes.FN_3_meses_exclusao(data_filt);
 
 OUTPUT(SORT(at1,id_consumidor),NAMED('at1'));
 OUTPUT(SORT(at2,id_consumidor),NAMED('at2'));
 OUTPUT(SORT(at3,id_consumidor),NAMED('at3'));
 OUTPUT(SORT(at4,id_consumidor),NAMED('at4'));
 OUTPUT(SORT(at7,id_consumidor),NAMED('at7'));
 OUTPUT(SORT(at8,id_consumidor),NAMED('at8'));
 OUTPUT(SORT(at14,id_consumidor),NAMED('at14'));
   

 //Conc1 := JOIN(at1,at2,LEFT.id_consumidor = RIGHT.id_consumidor);
 //Conc2 := JOIN(Conc1,at3,LEFT.id_consumidor = RIGHT.id_consumidor);
 //Conc3 := JOIN(Conc2,at4,LEFT.id_consumidor = RIGHT.id_consumidor);
 
 //Conc6 := JOIN(Conc3,at7,LEFT.id_consumidor = RIGHT.id_consumidor);
 //Conc7 := JOIN(Conc6,at8,LEFT.id_consumidor = RIGHT.id_consumidor);

 //Conc6;
 //Conc7;
 
 
limite_inf_3 := data_filt - 300;
filteredQuod2 :=  $.File_Quod.File(data_recebimento BETWEEN 0 AND data_filt);
OUTPUT(filteredQuod2,NAMED('Quod_teste'));
DividasLayout3 := RECORD
  filteredQuod2.id_consumidor;
  atr3 := SUM(GROUP,filteredQuod2.contagem,filteredQuod2.comando = 10.0);
END;

DividaPessoas2 := TABLE(filteredQuod2,DividasLayout3,id_consumidor);
OUTPUT(DividaPessoas2,,NAMED('at3_calc'));