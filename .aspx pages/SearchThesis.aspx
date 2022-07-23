<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchThesis.aspx.cs" Inherits="ByteMe.SearchThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            Enter a keyword:<br />
            <asp:TextBox ID="keyword" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="display" runat="server" OnClick="disp" Text="Display Results" />

            <br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>

            <br />
            <br />
            <asp:Button ID="dooma" runat="server" OnClick="backhome" Text="Back to Examiner Homepage" />

        </div>
    </form>
</body>
</html>
