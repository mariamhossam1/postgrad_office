<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ByteMe.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please Login<br />
            <br />
            Email:<br />
            <asp:TextBox ID="emailadd" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="signin" runat="server" OnClick="login" Text="Login" />
            <asp:Button ID="registerin" runat="server" OnClick="register" Text="Register" />            
            <br />
        </div>
    </form>
</body>
</html>
