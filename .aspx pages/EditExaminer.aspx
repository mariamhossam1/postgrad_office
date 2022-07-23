<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditExaminer.aspx.cs" Inherits="ByteMe.EditExaminer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            (If you don&#39;t want to change a value, just type in the value that is currently on the system)<br />
            New Examiner Name:<br />
            <asp:TextBox ID="adoom" runat="server"></asp:TextBox>
            <br />
            <br />
            New Field of Work:<br />
            <asp:TextBox ID="adam" runat="server"></asp:TextBox>
            <br />
            <br />
            New Email:<br />
            <asp:TextBox ID="mail" runat="server"></asp:TextBox>
            <br />
            <br />
            New Password:<br />
            <asp:TextBox ID="pass" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="profup" runat="server" OnClick="upprof" Text="Update Profile" />
            <br />
            <br />
            <asp:Button ID="dooma" runat="server" OnClick="backhome" Text="Back to Examiner Homepage" />
        </div>
    </form>
</body>
</html>
