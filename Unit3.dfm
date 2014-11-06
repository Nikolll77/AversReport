object AgentForm: TAgentForm
  Left = 507
  Top = 257
  BorderStyle = bsSingle
  Caption = #1041#1072#1079#1072' '#1072#1075#1077#1085#1090#1086#1074
  ClientHeight = 595
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    498
    595)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 498
    Height = 561
    Align = alTop
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'terminal'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1088#1084#1080#1085#1072#1083
        Title.Color = clMoneyGreen
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072
        Title.Color = clGradientActiveCaption
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 301
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = -16
    Top = 568
    Width = 515
    Height = 25
    VisibleButtons = [nbPost]
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
  end
end
