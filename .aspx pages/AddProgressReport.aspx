<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProgressReport.aspx.cs" Inherits="ByteMe.AddProgressReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Please enter Thesis serial number:<p>
            <asp:TextBox ID="sn" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the Progress report date:</p>
        <p>
            <asp:TextBox ID="pr" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="addPR" runat="server" OnClick="AddPR" Text="Add Progress Report" />
        </p>
        <p>
            <asp:Button ID="studback" runat="server" OnClick="backstud" Text="Back to Student Homepage" />
        </p>
    </form>
</body>
</html>
