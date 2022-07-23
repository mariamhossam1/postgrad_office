<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supervisor.aspx.cs" Inherits="ByteMe.Supervisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <p>
            <asp:Button ID="B1" runat="server" OnClick="ViewStudents" Text="myStudents" />

        </p>
        <p>
            StudentID:
            <asp:TextBox ID="studID" runat="server"></asp:TextBox>
        </p>
        
        EvaluateNo:
            <asp:TextBox ID="evaluateValue" runat="server"></asp:TextBox>
        <p>
            ProgressReportNo:
            <asp:TextBox ID="progressReport" runat="server" ></asp:TextBox>
            </p>
        
        <p>
            ThesisSerialNo:
        <asp:TextBox ID="ThesisID" runat="server"></asp:TextBox>
        </p>
        <p>

            <asp:Button ID="B2" runat="server" OnClick="ViewStudentsPub" Text="getPublications" />
        
        <asp:Button ID="B4" runat="server" OnClick="Evaluate" Text="EvaluateProgressReports" />
        
        <asp:Button ID="B3" runat="server" OnClick="CancelThesis" Text="CancelThesis" />
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </p>
        <p>
            <asp:GridView ID="GridView2" runat="server">
            </asp:GridView>
        </p>
        <p>
            DefenseDate:<asp:TextBox ID="DefenseDate" runat="server"></asp:TextBox>
        </p>
        <p>
            DefenseLocation:<asp:TextBox ID="DefenseLocation" runat="server"></asp:TextBox>
        </p>
        <p>
            ExaminerName:<asp:TextBox ID="ExaminerName" runat="server"></asp:TextBox>
        </p>
        <p>
            FieldOfWork:<asp:TextBox ID="FieldOfWork" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:CheckBox ID="isNational" runat="server"></asp:CheckBox>isNational
        </p>
        <p>
            <asp:Button ID="B5" runat="server" OnClick="AddDefense" Text="AddDefense" />
            <asp:Button ID="B6" runat="server" OnClick="AddExaminer" Text="AddExaminer" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="logback" runat="server" OnClick="backlog" Text="Logout" />
        </p>
    </form>
</body>
</html>
