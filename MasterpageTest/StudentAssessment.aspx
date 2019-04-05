<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentAssessment.aspx.cs" Inherits="MasterpageTest.StudentAssessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /*gridview*/
        .table table tbody tr td a,
        .table table tbody tr td span {
            position: relative;
            float: left;
            padding: 6px 12px;
            margin-left: -1px;
            line-height: 1.42857143;
            color: #337ab7;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .table table > tbody > tr > td > span {
            z-index: 3;
            color: #fff;
            cursor: default;
            background-color: #337ab7;
            border-color: #337ab7;
        }

        .table table > tbody > tr > td:first-child > a,
        .table table > tbody > tr > td:first-child > span {
            margin-left: 0;
            border-top-left-radius: 4px;
            border-bottom-left-radius: 4px;
        }

        .table table > tbody > tr > td:last-child > a,
        .table table > tbody > tr > td:last-child > span {
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
        }

        .table table > tbody > tr > td > a:hover,
        .table table > tbody > tr > td > span:hover,
        .table table > tbody > tr > td > a:focus,
        .table table > tbody > tr > td > span:focus {
            z-index: 2;
            color: #23527c;
            background-color: #eee;
            border-color: #ddd;
        }
        /*end gridview */
    </style>
    <h1>Public Assessment</h1>
 <asp:HiddenField ID="HiddenData" runat="server" />
    <asp:HiddenField ID="hiddenPublic" runat="server" Value="Public" />
    <asp:HiddenField ID="HiddenAssign" runat="server" Value="ASSIGNED" />

    <h4>Public Multiple Choice Question Assessment</h4>   
    <asp:Label ID="LabelpublicAssessment" runat="server" Text=""></asp:Label>
    <asp:GridView ID="publicAssessment" runat="server" AutoGenerateColumns="False" DataKeyNames="MCQAssessmentID" DataSourceID="publicAssessmentQuery" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="publicAssessment_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" SortExpression="MCQAssessmentID" InsertVisible="False" ReadOnly="True" />       
            <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
            <asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />
            <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="publicAssessmentQuery" runat="server" OnSelected="publicAssessmentQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select * From MCQAssessment where MCQAssessmentID not in (Select MCQAssessmentID From MCQAssessmentList  Where Email  = @Email) AND MCQAssessmentType = @MCQAssessmentType ">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" />
            <asp:ControlParameter ControlID="hiddenPublic" Name="MCQAssessmentType" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h4>Public Open Ended Question</h4>
    <asp:Label ID="LabelpublicQNAAssessment" runat="server" Text=""></asp:Label>
    <asp:GridView ID="publicQNAAssessment" runat="server" AutoGenerateColumns="False" DataKeyNames="WrittenID" DataSourceID="publicQNAQuery"  CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="publicQNAAssessment_SelectedIndexChanged" >
        <Columns>
            <%--<asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ReadOnly="True" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" SortExpression="WrittenID" ReadOnly="True" />
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />
            <asp:BoundField DataField="WrittenID1" HeaderText="WrittenID1" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID1" />--%>
            <%--<asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />--%>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" SortExpression="WrittenID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
            <asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="publicQNAQuery" runat="server" OnSelected="publicQNAQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select * From WrittenAssessment where WrittenID not in (Select WrittenID From WrittenAssessmentList  Where Email  = @Email) AND WrittenAssessmentType = @WrittenAssessmentType ">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" />
            <asp:ControlParameter ControlID="hiddenPublic" Name="WrittenAssessmentType" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />

</asp:Content>
