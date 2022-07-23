<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewThesis.aspx.cs" Inherits="ByteMe.ViewThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <p>
            <asp:Button ID="VT" runat="server" OnClick="ViewT" Text="View Thesis" />
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </p>
        <p>
            <asp:Button ID="studback" runat="server" Onclick="backstud" Text="Back to Student Homepage" />
        </p>
    </form>
</body>
</html>
