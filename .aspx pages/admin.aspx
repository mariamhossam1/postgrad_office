<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="ByteMe.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Welcome Admin!<br />
            <br />
            <asp:Button ID="listsup" runat="server" OnClick="suplist" Text="List All Supervisors" />
            <asp:Button ID="issuethesis" runat="server" OnClick="issueth" Text="Issue a Thesis Payment" />
            <asp:Button ID="installissue" runat="server" OnClick="install" Text="Issue Installments" />
            <asp:Button ID="updateth" runat="server" OnClick="update" Text="Update Thesis Extension" />
            <asp:Button ID="listth" runat="server" OnClick="viewth" Text="View All Theses" />
            <br />
            <br />
            <asp:Button ID="log" runat="server" OnClick="backlog" Text="Logout" />
        </div>
    </form>
</body>
</html>
