<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddandLinkPublication.aspx.cs" Inherits="ByteMe.AddandLinkPublication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Please enter your publication title:"></asp:Label>

        </div>
        <p>
            <asp:TextBox ID="title" runat="server" OnTextChanged="title_TextChanged"></asp:TextBox>

        </p>
        <p>

            <asp:Label ID="Label2" runat="server" Text="Please enter the publication date:"></asp:Label>
            </p>
        <p>
            <asp:TextBox ID="date" runat="server"></asp:TextBox>

        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Please enter the host name:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="host" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Please enter the Accespted Bit:"></asp:Label>

        </p>
        <p>
            <asp:TextBox ID="accepted" runat="server"></asp:TextBox>

        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Please enter the publication place:"></asp:Label>

        </p>
        <p>
            <asp:TextBox ID="place" runat="server"></asp:TextBox>

        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="add" runat="server" Onclick="AddPub" Text="Add Publication" />

        </p>
        <p>
            <asp:Label ID="Label6" runat="server" Text="To Link the publication to a thesis do the following:"></asp:Label>

        </p>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Please enter the Publication ID:"></asp:Label>

        </p>
        <p>
            <asp:TextBox ID="id" runat="server"></asp:TextBox>

        </p>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Please enter the Thesis serial number:"></asp:Label>

        </p>
        <p>
            <asp:TextBox ID="sn" runat="server"></asp:TextBox>

        </p>
        <p>
            <asp:Button ID="link" runat="server" Onclick="LinkPub" Text="Link Publication to Thesis" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="studback" runat="server" OnClick="backstud" Text="Back to Student Homepage" />
        </p>
    </form>
</body>
</html>
