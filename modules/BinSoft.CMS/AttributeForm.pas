var lName, lTitle : Boolean;


procedure fOnKeyUp_ptitle(Sender,Key,KeyChar);
var S : String;
begin
  lTitle:=TRUE;
  S:=GetValue('ptitle','');
  if not lName then SetValue('pname',S);
end;

procedure fOnKeyUp_pname(Sender,Key,KeyChar);
var S : String;
begin
  lName:=TRUE;
  S:=GetValue('pname','');
  if not lTitle then SetValue('ptitle',S);
end;


procedure fOnClearForm;
begin
  lName:=FALSE;
  lTitle:=FALSE;
end;

procedure fOnLoadForm(Sender);
begin
  if GetValue('pname','')<>'' then lName:=TRUE;
  if GetValue('ptitle','')<>'' then lTitle:=TRUE;
end;


begin

end;