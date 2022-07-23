
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="ByteMe.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="studentregister" runat="server" Onclick="studentreg" Text="StudentRegister" />
        &nbsp;<asp:Button ID="supervisorregister" runat="server" Onclick="supervisorreg" Text="SupervisorRegister" />
            <asp:Button ID="examinerregister" runat="server" Onclick="examinerreg" Text="ExaminerRegister" />
        </div>
    </form>
</body>
</html>
