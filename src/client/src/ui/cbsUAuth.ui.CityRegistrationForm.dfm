inherited frmCityRegistration: TfrmCityRegistration
  ClientHeight = 102
  ClientWidth = 337
  Caption = 'Cadastrar Cidade'
  BorderStyle = bsNone
  ActiveControl = edtName
  OnReady = UniFormReady
  ExplicitHeight = 102
  TextHeight = 15
  inherited btnOk: TUniBitBtn
    Left = 173
    Top = 69
    TabOrder = 3
    ExplicitLeft = 173
    ExplicitTop = 69
  end
  inherited btnCancel: TUniBitBtn
    Left = 254
    Top = 69
    TabOrder = 4
    ExplicitLeft = 254
    ExplicitTop = 69
  end
  inherited pnlBreak: TUniPanel
    Top = 59
    Width = 321
    ExplicitTop = 59
    ExplicitWidth = 321
  end
  object edtName: TUniDBEdit [3]
    Left = 8
    Top = 5
    Width = 240
    Height = 22
    Hint = ''
    DataField = 'Name'
    DataSource = damCustomerRegistration.dsoCYT
    TabOrder = 0
    FieldLabel = 'Cidade'
    FieldLabelAlign = laTop
  end
  object edtAreaCode: TUniDBEdit [4]
    Left = 254
    Top = 5
    Width = 75
    Height = 22
    Hint = ''
    DataField = 'AreaCode'
    DataSource = damCustomerRegistration.dsoCYT
    TabOrder = 1
    FieldLabel = 'DDD'
    FieldLabelAlign = laTop
  end
  inherited aclMain: TUniActionList
    Left = 8
    Top = 64
    inherited actOk: TAction
      Enabled = True
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 36
    Top = 64
  end
  inherited nilstMain: TUniNativeImageList
    Left = 64
    Top = 64
  end
end
