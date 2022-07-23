<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefGrade.aspx.cs" Inherits="ByteMe.DefGrade" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Thesis Serial Number:<div>
            <asp:TextBox ID="thsn" runat="server"></asp:TextBox>
            <br />
            Defense Date:<br />
            <asp:TextBox ID="dfd" runat="server"></asp:TextBox>
            <br />
            Grade:<br />
            <asp:TextBox ID="grade" runat="server" ></asp:TextBox>
            &nbsp;(if you don&#39;t want to add a grade, insert &#39;-1&#39;)<br />
            Comment:<br />
            <asp:TextBox ID="cm" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="upgrade" runat="server" OnClick="gradeup" Text="Update Defense" />
            <br />
            <br />
            <asp:Button ID="dooma" runat="server" OnClick="backhome" Text="Back to Examiner Homepage" />
        </div>
    </form>
</body>
</html>
