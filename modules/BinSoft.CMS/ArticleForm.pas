var lMod : Boolean;

procedure fOnChange_popc_mark(Sender);
var F, G;
begin
  F:=FindField('pbody');
  if F=nil then Exit;
  G:=F.InhObject;
  if G=nil then Exit;
  if GetValue('popc_mark','0')='0' then G.changeEditorType('html')
  else G.changeEditorType('markdown');
end;

procedure fOnClearForm;
begin
  lMod:=FALSE;
  fOnChange_popc_mark(nil);
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
  fOnChange_popc_mark(nil);
end;

