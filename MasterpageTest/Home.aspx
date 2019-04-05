<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MasterpageTest.Home" %>

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
    <h1>Welcome, <asp:Label ID="personName" Text="" runat="server"></asp:Label></h1>
    <asp:HiddenField ID="HiddenData" runat="server" />
    <asp:HiddenField ID="hiddenPublic" runat="server" Value="Public" />
    <asp:HiddenField ID="HiddenAssign" runat="server" Value="ASSIGNED" />
    <asp:HiddenField ID="HiddenStatus" runat="server"/>



    <%
        if(HiddenStatus.Value == "Student")
        { %>
            <br />
             <h4>Assigned Multiple Choice Question Assessment</h4>
    <asp:Label ID="LabelAssignedMCQ" runat="server" Text=""></asp:Label>
    <asp:GridView ID="AssignedMCQ" runat="server" CssClass="table table-striped table-bordered table-hover"  AutoGenerateColumns="False" DataKeyNames="MCQAssessmentID" DataSourceID="AssignedMCQQuery" OnSelectedIndexChanged="AssignedMCQ_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
            <%--<asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" ReadOnly="True" SortExpression="MCQAssessmentID" />--%>
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <%--<asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />--%>
             <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />
           <%-- <asp:BoundField DataField="MCQAssessmentID1" HeaderText="MCQAssessmentID1" InsertVisible="False" ReadOnly="True" SortExpression="MCQAssessmentID1" />--%>
            
            <%--<asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />--%>
           
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="AssignedMCQQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelected="AssignedMCQQuery_Selected" SelectCommand="SELECT * FROM MCQAssessmentList MAL,MCQAssessment MA WHERE MAL.MCQAssessmentID = MA.MCQAssessmentID AND  Email = @Email AND Assignment = @Assignment AND Completion = @Completion">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenAssign" Name="Assignment" PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="INCOMPLETE" Name="Completion" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h4>Assigned Open Ended Assessment</h4>
    <asp:Label ID="LabelAssignedQNA" runat="server" Text=""></asp:Label>
    <asp:GridView ID="AssignedMCQQNA" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" DataKeyNames="WrittenID" DataSourceID="AssignedQNAQuery" OnSelectedIndexChanged="AssignedMCQQNA_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
<%--            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" ReadOnly="True" SortExpression="WrittenID" />--%>
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
          <%--  <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />--%>
<%--            <asp:BoundField DataField="WrittenID1" HeaderText="WrittenID1" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID1" />--%>
            
<%--            <asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />--%>
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="AssignedQNAQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelected="AssignedQNAQuery_Selected" SelectCommand="SELECT * FROM WrittenAssessmentList WAL,WrittenAssessment WA WHERE WAL.WrittenID = WA.WrittenID AND  Email = @Email AND Assignment = @Assignment AND Completion = @Completion">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenAssign" Name="Assignment" PropertyName="Value" />
            <asp:Parameter DefaultValue="INCOMPLETE" Name="Completion" />
        </SelectParameters>
    </asp:SqlDataSource>



     <h4>Completed Multiple Choice Question</h4>
    <asp:Label ID="CompletedMCQLabel" runat="server" Text=""></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Email,MCQAssessmentID,MCQAssessmentID1" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover" >
        <Columns>
<%--            <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" ReadOnly="True" SortExpression="MCQAssessmentID" />--%>
            <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
             
            <asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />
            <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />

<%--            <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />
            <asp:BoundField DataField="MCQAssessmentID1" HeaderText="MCQAssessmentID1" InsertVisible="False" ReadOnly="True" SortExpression="MCQAssessmentID1" />
            
            --%>        
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelected="SqlDataSource1_Selected" SelectCommand="SELECT * FROM MCQAssessmentList MAL,MCQAssessment MA WHERE MAL.Email = @Email AND Completion = @Completion AND MAL.MCQAssessmentID = MA.MCQAssessmentID ">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="MARKED" Name="Completion" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h4>Completed Open Ended Question</h4>
    <asp:Label ID="CompletedQNALabel" runat="server" Text=""></asp:Label>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Email,WrittenID,WrittenID1" DataSourceID="SqlDataSource2" CssClass="table table-striped table-bordered table-hover">
        <Columns>
            <%--<asp:BoundField DataField="WrittenID" HeaderText="WrittenID" ReadOnly="True" SortExpression="WrittenID" />--%>
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
           <%-- <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />--%>
            
           
            <%--<asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment" />--%>
           <%-- <asp:BoundField DataField="WrittenID1" HeaderText="WrittenID1" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID1" />--%>
            
            <asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />
            
             <asp:BoundField DataField="Completion" HeaderText="Completion" SortExpression="Completion" />
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" OnSelected="SqlDataSource2_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM WrittenAssessmentList WAL,WrittenAssessment WA WHERE WAL.Email = @Email AND Completion = @Completion AND WAL.WrittenID = WA.WrittenID ">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenData" Name="Email" PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="MARKED" Name="Completion" />
        </SelectParameters>
    </asp:SqlDataSource>
   <%     }

        %>

    <%
        if(HiddenStatus.Value == "Lecturer")
        { %>

      <%}%>


        
    
</asp:Content>
