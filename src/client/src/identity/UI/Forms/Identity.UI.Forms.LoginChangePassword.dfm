inherited frmLoginChangePassword: TfrmLoginChangePassword
  ClientHeight = 347
  ClientWidth = 451
  Caption = 'Altera'#231#227'o obrigat'#243'ria de senha'
  BorderStyle = bsNone
  ActiveControl = edtCurrentPassword
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'   if' +
      ' (AppEnv.isElectron()) {'#13#10'      sender.addCls("electron-login-ch' +
      'ange-password-pos");'#13#10'   }'#13#10'}')
  ExplicitWidth = 451
  ExplicitHeight = 347
  TextHeight = 15
  inherited btnOk: TUniBitBtn
    Left = 256
    Top = 313
    Width = 105
    TabOrder = 2
    ExplicitLeft = 256
    ExplicitTop = 313
    ExplicitWidth = 105
  end
  inherited btnCancel: TUniBitBtn
    Left = 367
    Top = 313
    TabOrder = 3
    ExplicitLeft = 367
    ExplicitTop = 313
  end
  inherited pnlBreak: TUniPanel
    Top = 302
    Width = 435
    TabOrder = 1
    ExplicitTop = 302
    ExplicitWidth = 435
  end
  object pnlLcp: TUniContainerPanel [3]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 0
    DesignSize = (
      429
      287)
    object labStep03Title: TUniLabel
      Left = 0
      Top = 0
      Width = 160
      Height = 13
      Hint = ''
      Caption = 'Altera'#231#227'o obrigat'#243'ria de senha'
      ParentFont = False
      Font.Style = [fsBold]
      TabOrder = 0
    end
    object labStep03SubTitle: TUniLabel
      Left = 16
      Top = 20
      Width = 429
      Height = 27
      Hint = ''
      AutoSize = False
      Caption = 
        'Por seguran'#231#227'o, voc'#234' precisa alterar sua senha para continuar ac' +
        'essando o sistema.'
      ParentFont = False
      TabOrder = 2
    end
    object pnlBreakTop2: TUniPanel
      Left = 0
      Top = 42
      Width = 429
      Height = 1
      Hint = ''
      Enabled = False
      BodyRTL = False
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 3
      ShowCaption = False
      Caption = 'pnlBreak'
    end
    object edtCurrentPassword: TUniEdit
      Left = 47
      Top = 72
      Width = 345
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 4
      EmptyText = 'Informe sua senha atual'
      ClearButton = True
      FieldLabel = 'Senha atual'
      FieldLabelAlign = laTop
      FieldLabelFont.Style = [fsBold]
    end
    object edtNewPassword: TUniEdit
      Left = 47
      Top = 118
      Width = 345
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 5
      EmptyText = 
        'A senha deve ter no m'#237'nimo 8 caracteres, incluindo letras e n'#250'me' +
        'ros'
      ClearButton = True
      FieldLabel = 'Nova senha'
      FieldLabelAlign = laTop
      FieldLabelFont.Style = [fsBold]
    end
    object edtConfirmPassword: TUniEdit
      Left = 47
      Top = 165
      Width = 345
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 6
      EmptyText = 'Digite novamente a nova senha'
      ClearButton = True
      FieldLabel = 'Confirmar nova senha'
      FieldLabelAlign = laTop
      FieldLabelFont.Style = [fsBold]
    end
    object pnlMsg: TUniSimplePanel
      Left = 47
      Top = 231
      Width = 345
      Height = 22
      Hint = ''
      ParentColor = False
      Color = clInfoBk
      Border = True
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  sender.set' +
          'Style({'#13#10'    borderRadius: '#39'2px'#39','#13#10'    overflow: '#39'hidden'#39#13#10'  });' +
          #13#10'}')
      TabOrder = 7
      Layout = 'auto'
      LayoutAttribs.Align = 'stretch'
      object labMsg: TUniLabel
        AlignWithMargins = True
        Left = 23
        Top = 3
        Width = 319
        Height = 19
        Hint = ''
        Margins.Left = 0
        Margins.Bottom = 0
        AutoSize = False
        Caption = 'Ap'#243's alterar a senha, voc'#234' ser'#225' redirecionado a fazer o login'
        Align = alClient
        ParentFont = False
        Font.Color = 3618615
        TabOrder = 2
      end
      object imgMsg: TUniImage
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 21
        Height = 20
        Hint = ''
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Transparent = True
        Images = nilstMain
        ImageIndex = 0
      end
    end
  end
  inherited aclMain: TUniActionList
    Left = 12
    Top = 307
    inherited actOk: TAction
      Caption = 'Alterar senha'
      Enabled = True
    end
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 40
    Top = 307
  end
  inherited nilstMain: TUniNativeImageList
    Left = 68
    Top = 307
    Images = {
      01000000FFFFFF1F04F400000089504E470D0A1A0A0000000D49484452000000
      100000001008060000001FF3FF610000001974455874536F6674776172650041
      646F626520496D616765526561647971C9653C0000000B744558745469746C65
      00496E666F3B6D122D860000007F49444154785EADD3C10904210C05D094926A
      72DBA6F6AC556C13DB41DA112C20F3850C88E02E337F847750C247A3CAEBFD5D
      19547068C973CDD6FA79A250A0436CF4ACD13540E193457F65ADCE0105E2A272
      06D86EDB1832FC388E493627AE06A42AD9E1B8C947402376D01E097022C0E926
      D2D7483E24FE29F39F89FECE074CA754D1009116650000000049454E44AE4260
      82}
  end
end
