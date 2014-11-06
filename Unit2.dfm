object Form2: TForm2
  Left = 430
  Top = 121
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072
  ClientHeight = 149
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 105
    Caption = #1042#1099#1073#1086#1088' '#1086#1087#1077#1088#1072#1094#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 100
      Top = 52
      Width = 172
      Height = 13
      Caption = #1042#1099#1073#1086#1088#1082#1072' '#1079#1072' '#1085#1086#1084#1077#1088#1086#1084' '#1072#1075#1077#1085#1090#1072
    end
    object Label3: TLabel
      Left = 99
      Top = 79
      Width = 189
      Height = 13
      Caption = #1042#1099#1073#1086#1088#1082#1072' '#1079#1072' '#1085#1072#1079#1074#1072#1085#1080#1077#1084' '#1074#1072#1083#1102#1090#1099
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 50
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object ComboBox3: TComboBox
      Left = 8
      Top = 74
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnChange = ComboBox3Change
      Items.Strings = (
        'USD'
        'EUR'
        'RUB')
    end
    object RadioButton1: TRadioButton
      Left = 10
      Top = 22
      Width = 87
      Height = 17
      Caption = #1042#1099#1087#1083#1072#1090#1099
      TabOrder = 2
    end
    object RadioButton2: TRadioButton
      Left = 168
      Top = 24
      Width = 89
      Height = 17
      Caption = #1054#1090#1087#1088#1072#1074#1082#1080
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 16
    Top = 120
    Width = 129
    Height = 25
    Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 120
    Width = 121
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
end
