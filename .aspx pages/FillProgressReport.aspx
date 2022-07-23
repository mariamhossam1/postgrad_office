<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FillProgressReport.aspx.cs" Inherits="ByteMe.FillProgressReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Please enter Thesis serial number:"></asp:Label>
        </div>
        <p>
            <asp:TextBox ID="sn" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Please enter the Progress report number:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="pr" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Please enter the State:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="s" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Please enter the description:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="d" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="fillpr" runat="server" OnClick="FillPR" Text="Fill Progress Report" />
        </p>
        <p>
            <asp:Button ID="studback" runat="server" OnClick="backstud" Text="Back to Student Homepage" />
        </p>
    </form>
</body>
</html>
