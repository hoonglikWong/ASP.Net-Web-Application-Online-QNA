<%@ Page Language="C#" MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="GradingWrittenTest.aspx.cs" Inherits="MasterpageTest.GradingWrittenTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery.searchabledropdown-1.0.8.min.js" type="text/javascript"></script>
    <style>
        .SearchAssessment {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }
        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .col-25 {
            float: left;
            width: 10%;
            margin-top: 6px;
        }

        .col-75 {
            float: left;
            width: 90%;
            margin-top: 6px;
        }
        /* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
        @media screen and (max-width: 600px) {


            .col-25, .col-75 {
                width: 100%;
                margin-top: 0;
            }
        }

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
        /*end gridview CssClass="table table-striped table-bordered table-hover"*/
    </style>
    <h1>Grading Written Test</h1>
    <br />
    <h4>Written Assessment</h4>
    <asp:HiddenField ID="PersonDetail" runat="server" />


    <asp:GridView ID="WrittenAssessment" runat="server" AutoGenerateColumns="False" DataKeyNames="WrittenID" DataSourceID="AssessmentCreatedQuery"  CssClass="table table-striped table-bordered table-hover">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="AssessmentCreatedQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessment] WHERE ([WrittenLectureEmail] = @WrittenLectureEmail)">
        <SelectParameters>
            <asp:ControlParameter ControlID="PersonDetail" Name="WrittenLectureEmail" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br /><br />

    <%
        if (IsPostBack)
        {  %>
    <h4>Student Who Completed The Written Assessment</h4>
    <asp:Label ID="CompletedAssessmentLabel" runat="server" Text=""></asp:Label>

    <asp:GridView ID="StudentCompleted" runat="server" AutoGenerateColumns="False" DataKeyNames="WrittenID" DataSourceID="StudentCompletedQuery" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="StudentCompleted_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" ReadOnly="True" SortExpression="WrittenID" />
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />
        </Columns>
    </asp:GridView>


    <asp:SqlDataSource ID="StudentCompletedQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessmentList] WHERE ([WrittenID] = @WrittenID) AND Completion = 'completed'" OnSelected="StudentCompletedQuery_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="WrittenAssessment" Name="WrittenID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br /><br />
    <h4>Marked</h4>
    <asp:Label ID="MarkedResult" runat="server" Text=""></asp:Label>
    
    <asp:GridView ID="StudentMarked" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" DataKeyNames="Email,WrittenID" DataSourceID="StudentMarkedQuery">
        <Columns>
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" ReadOnly="True" SortExpression="WrittenID" />
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="StudentMarkedQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessmentList] WHERE ([WrittenID] = @WrittenID) AND Completion = 'MARKED'"  OnSelected="StudentMarkedQuery_Selected" >
        <SelectParameters>
            <asp:ControlParameter ControlID="WrittenAssessment" Name="WrittenID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>


    <%  }%>


        
    


</asp:Content>

