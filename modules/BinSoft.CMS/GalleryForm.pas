var lMod : Boolean;

procedure fOnClearForm;
begin
  lMod:=FALSE;
end;

procedure fOnKeyUp_ptitle(Sender,Key,KeyChar);
var S : String;
    i : Integer;
begin
  S:=GetValue('ptitle','');
  if not lMod then
  begin
    S:=lowercase(TBinFMUtils.pl_trimpl(S));
    for i:=1 to Length(S) do
    begin
     if ((S[i]>='a') and (S[i]<='z')) or
        ((S[i]>='A') and (S[i]<='Z')) or
        ((S[i]>='0') and (S[i]<='9')) or
        ((S[i]='_')) then
        begin

        end else
        begin
          S[i]:='-';
        end;
    end;
    S:=TBinFMUtils.ReplaceString(S,'--','-');
    SetValue('pmodrewrite',S);
  end;
end;

procedure fOnLoadForm(Sender);
begin
  if GetValue('pmodrewrite','')<>'' then lMod:=TRUE;
end;