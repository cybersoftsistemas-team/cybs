inherited frmDomains: TfrmDomains
  ClientHeight = 347
  ClientWidth = 451
  Caption = 'frmDomains'
  BorderStyle = bsNone
  ExplicitWidth = 451
  ExplicitHeight = 347
  TextHeight = 15
  inherited btnOk: TUniBitBtn
    Left = 287
    Top = 314
    TabOrder = 2
  end
  inherited btnCancel: TUniBitBtn
    Left = 368
    Top = 314
    TabOrder = 3
  end
  object grdDomains: TUniDBTreeGrid [2]
    Left = 8
    Top = 27
    Width = 435
    Height = 279
    Hint = ''
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    LoadMask.Message = 'Loading data...'
    Options = [dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
    UseArrows = True
  end
  object labDomains: TUniLabel [3]
    Left = 8
    Top = 8
    Width = 176
    Height = 13
    Hint = ''
    Caption = 'Selecione uma empresa de acesso:'
    TabOrder = 0
  end
  inherited aclMain: TUniActionList
    Left = 351
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 379
  end
  inherited nilstMain: TUniNativeImageList
    Left = 407
  end
end
