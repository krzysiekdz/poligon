
function fOnSave:String;
begin
  if BinDB.RowExists('bsc_blocks_pr','id<>'+I2S(FormGetIDorUnique)+' AND iddoc='+GetValue('iddoc','0')+' AND pident='''+BinDB.AddSlashes(GetValue('pident',''))+'''') then
  begin
    APP.ShowMessageError('Identyfikator powinien być unikalny w skali całego bloku!');
    Result:='false';
    Exit;
  end;
end;