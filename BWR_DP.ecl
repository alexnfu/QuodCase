import $, STD;

QuodBase := $.File_Quod.File;

BestRecord:= STD.DataPatterns.BestRecordStructure(QuodBase);
ProfileResults := STD.DataPatterns.Profile(QuodBase);

//OUTPUT(QuodBase);
//OUTPUT(BestRecord, ALL, NAMED('BestRecord'));
//OUTPUT(ProfileResults, ALL, NAMED('ProfileResults'));

AtrBase := $.File_Atributos.Atr_File;

ProfileJan := STD.DataPatterns.Profile(AtrBase(mes = 1));
ProfileFeb := STD.DataPatterns.Profile(AtrBase(mes = 2));
ProfileMar := STD.DataPatterns.Profile(AtrBase(mes = 3));
ProfileApr := STD.DataPatterns.Profile(AtrBase(mes = 4));
ProfileMay := STD.DataPatterns.Profile(AtrBase(mes = 5));
ProfileJun := STD.DataPatterns.Profile(AtrBase(mes = 6));
ProfileJul := STD.DataPatterns.Profile(AtrBase(mes = 7));
ProfileAug := STD.DataPatterns.Profile(AtrBase(mes = 8));
ProfileSep := STD.DataPatterns.Profile(AtrBase(mes = 9));
ProfileOct := STD.DataPatterns.Profile(AtrBase(mes = 10));
ProfileNov := STD.DataPatterns.Profile(AtrBase(mes = 11));
ProfileDec := STD.DataPatterns.Profile(AtrBase(mes = 12));

OUTPUT(ProfileJan,NAMED('jan'));
OUTPUT(ProfileFeb,NAMED('feb'));
OUTPUT(ProfileMar,NAMED('mar'));
OUTPUT(ProfileApr,NAMED('apr'));
OUTPUT(ProfileMay,NAMED('may'));
OUTPUT(ProfileJun,NAMED('jun'));
OUTPUT(ProfileJul,NAMED('jul'));
OUTPUT(ProfileAug,NAMED('aug'));
OUTPUT(ProfileSep,NAMED('sep'));
OUTPUT(ProfileOct,NAMED('oct'));
OUTPUT(ProfileNov,NAMED('nov'));
OUTPUT(ProfileDec,NAMED('dec'));
