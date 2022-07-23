

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentView.aspx.cs" Inherits="ByteMe.StudentView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
         </div>
        <asp:Button ID="viewprofile" runat="server" OnClick="ViewProfile" Text="View Profile" />

        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>

        <br />
        <asp:Button ID="listcourse" runat="server" OnClick="courselist" Text="List Courses" />

        <asp:Button ID="addpub" runat="server" OnClick="pubadd" Text="Add Publication" />

        <asp:Button ID="addprog" runat="server" OnClick="progadd" Text="Add Progress Report" />

        <asp:Button ID="fillprog" runat="server" OnClick="progfill" Text="Fill Progress Report" />

        <asp:Button ID="thview" runat="server" OnClick="viewth" Text="View Thesis" />

        <asp:Button ID="phone" runat="server" OnClick="phoneno" Text="Add Phone Number(s)" />

        <br />
        <br />
        <asp:Button ID="logback" runat="server" OnClick="backlog" Text="Logout" />

    </form>
</body>
</html>


