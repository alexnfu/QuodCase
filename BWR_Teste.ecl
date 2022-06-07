import $, STD;

QuodBase := $.File_Quod.File;

BestRecord:= STD.DataPatterns.BestRecordStructure(QuodBase);
QuodBase;
OUTPUT(BestRecord, ALL, NAMED('BestRecord'));
