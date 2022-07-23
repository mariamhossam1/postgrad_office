<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateext.aspx.cs" Inherits="ByteMe.updateext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Thesis Serial No.:<br />
            <asp:TextBox ID="thesis" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="upext" runat="server" OnClick="extup" Text="Update Extensions" />
            <br />
            <br />
            <asp:Button ID="adminback" runat="server" OnClick="adback" Text="Back to Admin Main Page" />
        </div>
    </form>
</body>
</html>
