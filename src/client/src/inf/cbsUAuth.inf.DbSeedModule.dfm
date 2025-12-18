inherited damDbSeed: TdamDbSeed
  inherited sptSeed: TFDScript
    SQLScripts = <
      item
        Name = 'root'
        SQL.Strings = (
          '@identity_options'
          '@identity_users'
          '@identity_settings')
      end
      item
        Name = 'identity_options'
        SQL.Strings = (
          '------------------------------------------------------------'
          '-- O usu'#225'rio deve alterar a senha no pr'#243'ximo logon'
          '------------------------------------------------------------'
          'MERGE INTO [identity].[options] AS T'
          'USING (VALUES ('
          '    '#39'5A6F0A6E-5C6A-4E71-9E6A-5C9E3F9A3A01'#39','
          '    N'#39'O usu'#225'rio deve alterar a senha no pr'#243'ximo logon'#39','
          
            '    N'#39'For'#231'a um usu'#225'rio a alterar a senha na pr'#243'xima vez que fize' +
            'r logon na rede. '#39' +'
          
            '    N'#39'Use esta op'#231#227'o quando deseja garantir que o usu'#225'rio ser'#225' a' +
            ' '#250'nica pessoa a '#39' +'
          '    N'#39'conhecer a senha.'#39
          ')) AS S (Id, Name, Description)'
          'ON T.Id = S.Id'
          'WHEN MATCHED THEN'
          '    UPDATE SET'
          '        T.Name = S.Name,'
          '        T.Description = S.Description'
          'WHEN NOT MATCHED THEN'
          '    INSERT (Id, Name, Description)'
          '    VALUES (S.Id, S.Name, S.Description);'
          ''
          '------------------------------------------------------------'
          '-- O usu'#225'rio n'#227'o pode alterar a senha'
          '------------------------------------------------------------'
          'MERGE INTO [identity].[options] AS T'
          'USING (VALUES ('
          '    '#39'C9F8E3E2-6D8E-4E53-9C8D-9F9F7B2A4E02'#39','
          '    N'#39'O usu'#225'rio n'#227'o pode alterar a senha'#39','
          
            '    N'#39'Impede que os usu'#225'rios alterem suas senhas. Use esta op'#231#227'o' +
            ' quando desejar '#39' +'
          
            '    N'#39'manter o controle sobre uma conta de usu'#225'rio, como uma con' +
            'ta de convidado '#39' +'
          '    N'#39'ou tempor'#225'ria.'#39
          ')) AS S (Id, Name, Description)'
          'ON T.Id = S.Id'
          'WHEN MATCHED THEN'
          '    UPDATE SET'
          '        T.Name = S.Name,'
          '        T.Description = S.Description'
          'WHEN NOT MATCHED THEN'
          '    INSERT (Id, Name, Description)'
          '    VALUES (S.Id, S.Name, S.Description);'
          ''
          '------------------------------------------------------------'
          '-- A senha nunca expira'
          '------------------------------------------------------------'
          'MERGE INTO [identity].[options] AS T'
          'USING (VALUES ('
          '    '#39'2D7F9B4C-9F42-4A38-9F71-4E8F4B9D8C03'#39','
          '    N'#39'A senha nunca expira'#39','
          
            '    N'#39'Impede que uma senha do usu'#225'rio expire. '#201' recomend'#225'vel que' +
            ' as contas de '#39' +'
          
            '    N'#39'Servi'#231'o tenham esta op'#231#227'o habilitada e usem senhas de alto' +
            ' n'#237'vel.'#39
          ')) AS S (Id, Name, Description)'
          'ON T.Id = S.Id'
          'WHEN MATCHED THEN'
          '    UPDATE SET'
          '        T.Name = S.Name,'
          '        T.Description = S.Description'
          'WHEN NOT MATCHED THEN'
          '    INSERT (Id, Name, Description)'
          '    VALUES (S.Id, S.Name, S.Description);'
          ''
          '------------------------------------------------------------'
          '-- Conta desabilitada'
          '------------------------------------------------------------'
          'MERGE INTO [identity].[options] AS T'
          'USING (VALUES ('
          '    '#39'8E1A3D5B-7C5F-4F5B-BE2C-1F3A9E6D4A04'#39','
          '    N'#39'Conta desabilitada'#39','
          
            '    N'#39'Impede que um usu'#225'rio fa'#231'a logon com a conta selecionada. ' +
            'Muitos '#39' +'
          
            '    N'#39'administradores usam contas desabilitadas como modelos par' +
            'a contas de '#39' +'
          '    N'#39'usu'#225'rio comuns.'#39
          ')) AS S (Id, Name, Description)'
          'ON T.Id = S.Id'
          'WHEN MATCHED THEN'
          '    UPDATE SET'
          '        T.Name = S.Name,'
          '        T.Description = S.Description'
          'WHEN NOT MATCHED THEN'
          '    INSERT (Id, Name, Description)'
          '    VALUES (S.Id, S.Name, S.Description);')
      end
      item
        Name = 'identity_users'
        SQL.Strings = (
          '------------------------------------------------------------'
          '-- Conta interna: Administrador'
          '------------------------------------------------------------'
          'MERGE INTO [identity].[users] AS T'
          'USING (VALUES ('
          '    '#39'3F6C8A4E-2B91-4E4E-9D43-6F0E1C8B9A10'#39','
          '    N'#39'Administrador'#39','
          '    N'#39'Conta interna para a administra'#231#227'o de sistemas/dom'#237'nios.'#39','
          '    CAST(1 AS BIT), -- AccountBlockedOut'
          '    NULL,'
          '    CAST(1 AS BIT), -- Reserved'
          '    N'#39'd41d8cd98f00b204e9800998ecf8427e'#39','
          '    NULL'
          
            ')) AS S (Id, Name, Description, AccountBlockedOut, AccountExpire' +
            'sDate, Reserved, Password, PersonId)'
          'ON T.Id = S.Id'
          'WHEN MATCHED THEN'
          '    UPDATE SET'
          '        T.Name               = S.Name,'
          '        T.Description        = S.Description,'
          '        T.AccountBlockedOut  = S.AccountBlockedOut,'
          '        T.AccountExpiresDate = S.AccountExpiresDate,'
          '        T.Reserved           = S.Reserved,'
          '        T.Password           = S.Password,'
          '        T.PersonId           = S.PersonId'
          'WHEN NOT MATCHED THEN'
          '    INSERT ('
          '        Id,'
          '        Name,'
          '        Description,'
          '        AccountBlockedOut,'
          '        AccountExpiresDate,'
          '        Reserved,'
          '        Password,'
          '        PersonId'
          '    )'
          '    VALUES ('
          '        S.Id,'
          '        S.Name,'
          '        S.Description,'
          '        S.AccountBlockedOut,'
          '        S.AccountExpiresDate,'
          '        S.Reserved,'
          '        S.Password,'
          '        S.PersonId'
          '    );')
      end
      item
        Name = 'identity_settings'
        SQL.Strings = (
          '/*'
          '    Objetivo:'
          '    ----------'
          '    Garantir que todos os usu'#225'rios possuam todas as op'#231#245'es'
          '    cadastradas em [identity].[options], criando os registros'
          '    faltantes em [identity].[settings].'
          ''
          '    Regra geral:'
          '    -------------'
          '    - Checked = 0 para todas as combina'#231#245'es novas'
          ''
          '    Regra especial:'
          '    ----------------'
          '    - Para o usu'#225'rio:'
          '        3F6C8A4E-2B91-4E4E-9D43-6F0E1C8B9A10'
          '      e a op'#231#227'o:'
          '        5A6F0A6E-5C6A-4E71-9E6A-5C9E3F9A3A01'
          '      o campo Checked deve ser inicializado com 1'
          '*/'
          ''
          'INSERT INTO [identity].[settings] ('
          '    UserId,'
          '    OptionId,'
          '    Checked'
          ')'
          'SELECT'
          '    U.Id AS UserId,      -- Usu'#225'rio'
          '    O.Id AS OptionId,    -- Op'#231#227'o'
          ''
          '    -- Define o valor inicial de Checked'
          '    CASE'
          '        WHEN U.Id = '#39'3F6C8A4E-2B91-4E4E-9D43-6F0E1C8B9A10'#39
          '         AND O.Id = '#39'5A6F0A6E-5C6A-4E71-9E6A-5C9E3F9A3A01'#39
          '        THEN CAST(1 AS bit)   -- Regra especial (admin/master)'
          '        ELSE CAST(0 AS bit)   -- Regra padr'#227'o'
          '    END AS Checked'
          ''
          'FROM [identity].[users] AS U'
          ''
          '-- Cria todas as combina'#231#245'es poss'#237'veis (Usu'#225'rio '#215' Op'#231#227'o)'
          'CROSS JOIN [identity].[options] AS O'
          ''
          '-- Verifica se a combina'#231#227'o j'#225' existe'
          'LEFT JOIN [identity].[settings] AS S'
          '    ON  S.UserId   = U.Id'
          '    AND S.OptionId = O.Id'
          ''
          '-- Insere somente as combina'#231#245'es inexistentes'
          'WHERE S.UserId IS NULL;')
      end>
    Connection = damDb.Connection
  end
end
