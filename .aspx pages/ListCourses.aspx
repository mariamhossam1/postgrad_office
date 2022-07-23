<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListCourses.aspx.cs" Inherits="ByteMe.ListCourses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            <asp:Button ID="viewcourses" runat="server" OnClick="ViewCourses" Text="View Courses" />
        </p>
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        <br />
        <asp:Button ID="studback" runat="server" OnClick="backstud" Text="Back to Student Homepage" />
    </form>
</body>
</html>
