
procedure fOnSave(Sender);
begin
  if GetValue('pdefault','0')='1' then
  begin
    BinDB.ExecSQL('UPDATE bsc_attributes_pr SET pdefault=0 WHERE pid='+GetValue('pid','0')+' AND id<>'+IntToStr(FormGetID));
  end;
end;


begin

end;