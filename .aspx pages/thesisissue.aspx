<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thesisissue.aspx.cs" Inherits="ByteMe.thesisissue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Thesis Serial No.:<br />
            <asp:TextBox ID="thesisno" runat="server"></asp:TextBox>
            <br />
            Amount:<br />
            <asp:TextBox ID="amount" runat="server"></asp:TextBox>
            <br />
            No. of Installments:<br />
            <asp:TextBox ID="noinst" runat="server"></asp:TextBox>
            <br />
            Fund Percentage:<br />
            <asp:TextBox ID="fundperc" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="issuethesis" runat="server" OnClick="issue" Text="Submit" />
            <br />
            <br />
            <asp:Button ID="adminback" runat="server" OnClick="adback" Text="Back to Admin Main Page" />
        </div>
    </form>
</body>
</html>
