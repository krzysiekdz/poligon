
procedure ustawPrzyciski;
begin

end;

procedure showSubView(P : Integer;Sender;Field);
begin

end;

procedure catBtn(Typ : Integer);
var N : Integer;
begin
  if FormGetID<=0 then
  begin
    App.ShowMessageError('Musisz zapisać ten produkt aby móc przypisać go do kategorii!');
    Exit;
  end;
  if Typ=1 then showPopup('selCatPopup','btnCatAdd',true)
  else if Typ=2 then
  begin
    N:=StrToIntDef(GetValue('mCats',0),0);
    if N>0 then
    begin
      BinDB.DeleteRow('bsc_products_cat','id='+IntToStr(N));
      ReloadItems('mCats');
    end;
  end;
end;

procedure fOnClearForm;
begin
  ustawPrzyciski;
end;

procedure fOnLoadForm(Sender);
begin
  ReloadItems('mCats');
  ustawPrzyciski;
end;

procedure fOnDblClick_treeCat(Sender);
var N : TTreeViewItem;
    T : TTreeView;
    E :TBinInsertUpdateRow;
begin
  T:=FindObjectControl('treeCat');
  if not Assigned(T) then Exit;
  N:=T.Selected;
  if not Assigned(N) then Exit;

  if BinDB.RowExists('bsc_products_cat','idprod='+IntToStr(FormGetID)+' AND idcat='+IntToStr(GetTag(N))) then Exit;

  E:=BinDB.InsertUpdateRow('bsc_products_cat');
  E.AddStandardFields(_iduser_);
  E.AddS('idprod','int',IntToStr(FormGetID));
  E.AddS('idcat','int',IntToStr(GetTag(N)));
  E.AddS('pcatname','varchar',GenRecursive(BinDB,'bsc_category','idr','ptitle',' : ',GetTag(N)));
  E.ExecuteS('');
  E.Free;

  hidePopup('selCatPopup');

  ReloadItems('mCats');

end;

procedure fOnChildBeforeAdd(Sender);
var S : String;
    L : TStringList;
    i : Integer;
    E :TBinInsertUpdateRow;
begin
        if FormGetID<=0 then
        begin
          App.ShowMessageError('Musisz zapisać ten produkt aby móc przydzielać mu trybuty!');
          Exit;
        end;

       S:=selectView('BinSoft.CMS.SelectAttributesView','','');
       L:=TStringList.Create;
       BinDB.BeginTransaction;
       try
         TBinFMUtils.ExplodeStr1(L,S,';',false);
         for i:=0 to L.Count-1 do
         begin
              if BinDB.RowExists('bsc_prod_attr','idprod='+IntToStr(FormGetID)+' AND idattr='+L[i]) then Continue;


              E:=BinDB.InsertUpdateRow('bsc_prod_attr');
              E.AddStandardFields(_iduser_);
              E.AddS('idprod','int',IntToStr(FormGetID));
              E.AddS('idattr','int',L[i]);
              E.ExecuteS('');
              E.Free;

         end;
       finally
         L.Free;
         BinDB.Commit;
       end;
end;


begin

end;