var lMod : Boolean;
    _ID : Integer;

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

//=============== po zapisaniu dokumentu =====================
procedure fOnAfterSave(Sender,fID);
var L1 : TStringList;
    S,SLUG : String;
    T : TBinTable;
    E, i,k;
begin

  _ID:=FormGetID;

  //korekta tagów
  L1:=TStringList.Create;
  try
    BinDB.ExecSQL('DELETE FROM bs_newstags_pr WHERE idnews='+IntToStr(_ID));
    TBinFMUtils.ExplodeStr1(L1,GetValue('wtags',''),';',FALSE);
    for i:=0 to L1.Count-1 do
    begin
      S:=lowercase(L1[i]);
      k:=BinDB.GetValueI('SELECT id FROM bs_newstags WHERE pname='''+BinDB.AddSlashes(S)+'''',0);
      if k<=0 then
      begin

          SLUG:=lowercase(TBinFMUtils.pl_trimpl(S));
          for k:=1 to Length(SLUG) do
          begin
           if ((SLUG[k]>='a') and (SLUG[k]<='z')) or
              ((SLUG[k]>='A') and (SLUG[k]<='Z')) or
              ((SLUG[k]>='0') and (SLUG[k]<='9')) or
              ((SLUG[k]='_')) then
              begin

              end else
              begin
                SLUG[k]:='-';
              end;
          end;
          SLUG:=TBinFMUtils.ReplaceString(SLUG,'--','-');
          while (SLUG<>'') and (SLUG[length(SLUG)]='-') do Delete(SLUG,Length(SLUG),1);



         E:=BinDB.InsertUpdateRow('bs_newstags');
         E.AddStandardFields(_iduser_);
         E.AddS('pname','varchar',S);
         E.AddS('wslug','varchar',SLUG);
         K:=E.Execute(0);
         E.Free;
      end;
      E:=BinDB.InsertUpdateRow('bs_newstags_pr');
      E.AddL('idnews','int',_ID);
      E.AddL('idtag','int',K);
      E.Execute(0);
      E.Free;
    end;
  finally
    L1.Free;
  end;

end;

