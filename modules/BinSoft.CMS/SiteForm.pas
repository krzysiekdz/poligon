var lHost, lURL, lmTitle, lmDesc : Boolean;


procedure fOnKeyUp_ptitle(Sender,Key,KeyChar);
var S : String;
begin
  S:=GetValue('ptitle','');
  if not lmTitle then SetValue('pmtitle',S);
end;

procedure fOnKeyUp_pdesc(Sender,Key,KeyChar);
var S : String;
begin
  S:=GetValue('pdesc','');
  if not lmDesc then SetValue('pmdesc',S);
end;

procedure fOnKeyUp_pmtitle(Sender,Key,KeyChar);
begin
  lmTitle:=TRUE;
end;

procedure fOnKeyUp_pmdesc(Sender,Key,KeyChar);
begin
  lmDesc:=TRUE;
end;

procedure fOnKeyUp_phost(Sender,Key,KeyChar);
var S : String;
begin
  S:=GetValue('phost','');
  if Pos('://',S)<=0 then S:='http://'+S;
  if not lURL then SetValue('purl',S);
  lHost:=TRUE;
end;

procedure fOnExit_phost(Sender);
var S : String;
    k : Integer;
begin
  S:=GetValue('phost','');
  k:=Pos('://',S);
  if k>0 then Delete(S,1,k+2);
  SetValue('phost',S);
end;

procedure fOnExit_purl(Sender);
var S : String;
    k : Integer;
begin
  S:=GetValue('purl','');
  k:=Pos('://',S);
  if k<=0 then S:='http://'+S;
  SetValue('purl',S);
end;


procedure fOnKeyUp_purl(Sender,Key,KeyChar);
var S : String;
    k : Integer;
begin
  S:=GetValue('purl','');
  k:=Pos('://',S);
  if k>0 then Delete(S,1,k+2);
  if not lHost then SetValue('phost',S);
  lURL:=TRUE;
end;

procedure fOnClearForm;
begin
  lURL:=FALSE;
  lHost:=FALSE;
  lmTitle:=FALSE;
  lmDesc:=FALSE;
end;

procedure fOnLoadForm(Sender);
begin
  if GetValue('phost','')<>'' then lHost:=TRUE;
  if GetValue('purl','')<>'' then lURL:=TRUE;
  if GetValue('pmtitle','')<>'' then lmTitle:=TRUE;
  if GetValue('pmdesc','')<>'' then lmDesc:=TRUE;
end;


procedure treeMenuAdd;
var S : String;
    Tree : TTreeView;
    lID : Integer;
begin
  Tree:=FindObjectControl('treeMenu');
  if Assigned(Tree.Selected) then lID:=GetTag(Tree.Selected) else lID:=0;
  S:=SelectForm('BinSoft.CMS.MenuItemForm','0','idsite={$$id};idr='+IntToStr(lID));
  FieldRefresh('treeMenu');
end;

procedure treeMenuEdit;
var S : String;
    Tree : TTreeView;
    lID : Integer;
begin
  Tree:=FindObjectControl('treeMenu');
  if Assigned(Tree.Selected) then lID:=GetTag(Tree.Selected) else Exit;
  S:=SelectForm('BinSoft.CMS.MenuItemForm',IntToStr(lID),'');
  FieldRefresh('treeMenu');
end;

procedure treeMenuDelete(LID : String);
var T : TBinTable;
begin
  T:=BinDB.GetAll('SELECT id FROM bsc_menu WHERE idr='+LID);
  while not T.Eof do
  begin
    treeMenuDelete(T.Fields[0]);
    T.Next;
  end;
  T.Free;
  BinDB.DeleteRow('bsc_menu','id='+LID);
end;

procedure treeMenuDel;
var S : String;
    Tree : TTreeView;
    lID : Integer;
begin
  Tree:=FindObjectControl('treeMenu');
  if Assigned(Tree.Selected) then lID:=GetTag(Tree.Selected) else Exit;
  if lID<=0 then Exit;

  if (APP.MessageBox('Usuwanie elementów menu','Czy na pewno chcesz <b>usunąć</b> wybrany element lub gałąź?',MT_CONFIRMATION,MB_YESNO,'')=ID_NO) then
  begin
        Exit;
  end;

  treeMenuDelete(IntToStr(lID));
  FieldRefresh('treeMenu');
end;

function fOnDblClick_treeMenu(Sender):String;
begin
  treeMenuEdit;
end;

function fOnSave : String;
var MX1,MX2: Integer;
begin
  if FormGetIDorUnique<=0 then
  begin
    MX1:=S2I(GetDBConfig('bsxshop','0'));
    MX2:=S2I(GetDBConfig('bsxcms','0'));
    if MX2>MX1 then MX1:=MX2;
    if BinDB.CountSQL('SELECT count(*) FROM bsc_sites')>=MX1 then
    begin
      Result:=FALSE;
      APP.ShowMessageError('Przekroczono liczbę dopuszczalnych Sklepów lub Stron WWW!');
      exit;
    end;
  end;

end;

begin

end;