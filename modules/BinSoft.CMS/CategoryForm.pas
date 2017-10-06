


procedure treeMenuAdd;
var S : String;
    Tree : TTreeView;
    lID : Integer;
begin
  Tree:=FindObjectControl('treeMenu');
  if Assigned(Tree.Selected) then lID:=GetTag(Tree.Selected) else lID:=0;
  S:=SelectForm('BinSoft.CMS.CategoryItemForm','0','idr='+IntToStr(lID));
  FieldRefresh('treeMenu');
end;

procedure treeMenuEdit;
var S : String;
    Tree : TTreeView;
    lID : Integer;
begin
  Tree:=FindObjectControl('treeMenu');
  if Assigned(Tree.Selected) then lID:=GetTag(Tree.Selected) else Exit;
  S:=SelectForm('BinSoft.CMS.CategoryItemForm',IntToStr(lID),'');
  FieldRefresh('treeMenu');
end;

procedure treeMenuDelete(LID : String);
var T : TBinTable;
begin
  T:=BinDB.GetAll('SELECT id FROM bsc_category WHERE idr='+LID);
  while not T.Eof do
  begin
    treeMenuDelete(T.Fields[0]);
    T.Next;
  end;
  T.Free;
  BinDB.DeleteRow('bsc_category','id='+LID);
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

procedure fOnDblClick_treeMenu(Sender);
begin
  treeMenuEdit;
end;


begin

end;