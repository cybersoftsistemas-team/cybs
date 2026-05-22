inherited frmMain: TfrmMain
  ClientHeight = 661
  ClientWidth = 1008
  Caption = 'frmMain'
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'    /' +
      '/ manda para o Electron (somente se estiver no Electron)'#13#10'    Ap' +
      'pEnv.safeSendToElectron("after-login", { w: 1024, h: 700 });'#13#10'}')
  ExplicitWidth = 1024
  ExplicitHeight = 700
  TextHeight = 15
  object pclMain: TUniPageControl [0]
    Left = 246
    Top = 0
    Width = 762
    Height = 661
    Hint = ''
    ActivePage = tbsMain
    Align = alClient
    TabOrder = 2
    object tbsMain: TUniTabSheet
      Hint = ''
      Caption = 'Cybersoft'
    end
  end
  object trmMain: TUniTreeMenu [1]
    Left = 0
    Top = 0
    Width = 241
    Height = 661
    Hint = ''
    Items.FontData = {0100000000}
    SourceMenu = mimMain
    SingleExpand = True
  end
  object sptMain: TUniSplitter [2]
    Left = 241
    Top = 0
    Width = 5
    Height = 661
    Hint = ''
    Align = alLeft
    ParentColor = False
    Color = clBtnFace
  end
  inherited aclMain: TUniActionList
    Left = 880
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 908
  end
  inherited nilstMain: TUniNativeImageList
    Left = 964
  end
  object mimMain: TUniMenuItems
    Images = nilstMain
    Left = 936
    Top = 16
    object mimMain1: TUniMenuItem
      Caption = 'Produtos e Servi'#231'os'
      object Produtos1: TUniMenuItem
        Caption = 'Produtos'
      end
      object Servios1: TUniMenuItem
        Caption = 'Servi'#231'os'
      end
    end
  end
end
