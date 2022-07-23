<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentreg.aspx.cs" Inherits="ByteMe.studentreg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            First Name:<br />
            <asp:TextBox ID="firstname" runat="server"></asp:TextBox>
            <br />
            Last Name:<br />
            <asp:TextBox ID="lastname" runat="server"></asp:TextBox>
            <br />
            Email:<br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            Address:<br />
            <asp:TextBox ID="address" runat="server"></asp:TextBox>
            <br />
            Faculty:<br />
            <asp:TextBox ID="faculty" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:CheckBox ID="Gucian" runat="server" Text=" Gucian" />
            <br />
            <br />
            <asp:Button ID="signup" runat="server" OnClick="student" Text="Register" />
        </div>
    </form>
</body>
</html>
