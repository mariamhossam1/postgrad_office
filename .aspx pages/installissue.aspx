<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="installissue.aspx.cs" Inherits="ByteMe.installissue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Payment ID:<br />
            <asp:TextBox ID="payment" runat="server"></asp:TextBox>
            <br />
            Installment Start Date:<br />
            <asp:TextBox ID="inststartdate" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="install" runat="server" OnClick="issinst" Text="Submit" />
            <br />
            <br />
            <asp:Button ID="adminback" runat="server" OnClick ="adback" Text="Back to Admin Main Page" />
        </div>
    </form>
</body>
</html>
