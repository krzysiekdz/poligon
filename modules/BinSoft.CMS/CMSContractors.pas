


function catProdBtn(Typ : Integer;Sender;Field):String;
var N : Integer;
    L : TStringList;
    S : String;
    i : Integer;
    IT, T;
begin
  Result:='%%';
  if FormGetID<=0 then
  begin
    App.ShowMessageError('Musisz zapisać ten wpis aby móc przypisać go do kategorii!');
    Exit;
  end;
  if Typ=1 then
  begin
    N:=APP.GroupsSelect(DB,BinDB,'bs_stockindex',S);
    if N<=0 then Exit;

    if not BinDB.RowExists('bs_catprod','idg='+I2S(N)+' AND pidcontractor='+IntToStr(FormGetID)) then
    begin
       IT := BinDB.InsertUpdateRow('bs_catprod');
       IT.AddL('idg','int',N);
       IT.AddL('pidcontractor','int',FormGetID);
       IT.AddS('ppath','varchar',S);
       IT.Execute(0);
       IT.Free;
    end;
    ReloadItems('mProdCats');
  end else if Typ=2 then
  begin
    N:=StrToIntDef(GetValue('mProdCats',0),0);
    if N>0 then
    begin
        BinDB.DeleteRow('bs_catprod','id='+IntToStr(N));
        ReloadItems('mProdCats');
    end;
  end;
end;

function fOnLoadForm(Sender):String;
begin
 ReloadItems('mProdCats');
end;