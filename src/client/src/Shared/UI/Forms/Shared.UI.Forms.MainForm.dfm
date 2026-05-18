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
  object stbMain: TUniStatusBar [0]
    Left = 0
    Top = 639
    Width = 1008
    Hint = ''
    Panels = <
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Width = 200
      end>
    SizeGrip = False
    Align = alBottom
    ParentColor = False
    ExplicitTop = 585
    ExplicitWidth = 794
  end
  object pnlMain: TUniContainerPanel [1]
    Left = 0
    Top = 0
    Width = 1008
    Height = 639
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 408
    ExplicitTop = 136
    ExplicitWidth = 256
    ExplicitHeight = 128
    object pclMain: TUniPageControl
      Left = 0
      Top = 0
      Width = 1008
      Height = 639
      Hint = ''
      ActivePage = UniTabSheet1
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 208
      ExplicitTop = 152
      ExplicitWidth = 289
      ExplicitHeight = 193
      object UniTabSheet1: TUniTabSheet
        Hint = ''
        Caption = 'UniTabSheet1'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 1008
        ExplicitHeight = 598
      end
    end
  end
end
