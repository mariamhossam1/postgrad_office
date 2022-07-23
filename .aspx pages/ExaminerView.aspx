<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerView.aspx.cs" Inherits="ByteMe.ExaminerView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="profedit" runat="server" OnClick="editprof" Text="Edit Profile" />
            <asp:Button ID="domdom" runat="server" OnClick="defview" Text="View Defense Information" />
            <asp:Button ID="gradeadd" runat="server" OnClick="addgrade" Text="Add Defense Grade/Comment" />
            <asp:Button ID="thsrch" runat="server" OnClick="srchth" Text="Search for Thesis" />
            <br />
            <br />
            <asp:Button ID="logback" runat="server" OnClick="backlog" Text="Logout" />
        </div>
    </form>
</body>
</html>
