object dmDoners: TdmDoners
  OldCreateOrder = False
  Height = 457
  Width = 616
  object conDoner: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=DonersInformation.m' +
      'db;Mode=ReadWrite;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 96
    Top = 200
  end
  object tblDonerInfo: TADOTable
    Connection = conDoner
    CursorType = ctStatic
    TableName = 'DonerInformation'
    Left = 184
    Top = 144
  end
  object dscDonerInfo: TDataSource
    DataSet = tblDonerInfo
    Left = 288
    Top = 144
  end
  object tblDonationInfo: TADOTable
    Connection = conDoner
    CursorType = ctStatic
    TableName = 'DonationInformation'
    Left = 184
    Top = 256
  end
  object dscDonationInfo: TDataSource
    DataSet = tblDonationInfo
    Left = 280
    Top = 264
  end
end
