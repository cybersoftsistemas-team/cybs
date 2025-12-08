inherited frmDialogBase: TfrmDialogBase
  Caption = 'frmDialogBase'
  DesignSize = (
    321
    199)
  TextHeight = 15
  object btnOk: TUniBitBtn [0]
    Left = 157
    Top = 166
    Width = 75
    Height = 25
    Action = actOk
    Anchors = [akRight, akBottom]
    TabOrder = 0
    Default = True
  end
  object btnCancel: TUniBitBtn [1]
    Left = 238
    Top = 166
    Width = 75
    Height = 25
    Action = actCancel
    Cancel = True
    ModalResult = 2
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  inherited aclMain: TUniActionList
    object actOk: TAction
      Caption = 'Ok'
      Enabled = False
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = 'Cancelar'
    end
  end
end
