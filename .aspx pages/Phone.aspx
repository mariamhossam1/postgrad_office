<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Phone.aspx.cs" Inherits="ByteMe.Phone" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Phone Number:<br />
            <asp:TextBox ID="phones" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="addphone" runat="server" OnClick ="phoneno" Text="Add" />
            <br />
            <br />
            <asp:Button ID="studback" runat="server" OnClick="backstud" Text="Back to Student Homepage" />
            <br />
        </div>
    </form>
</body>
</html>
