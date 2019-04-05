<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageQuestion.aspx.cs" Inherits="MasterpageTest.ManageQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .table-responsive {
            display: table;
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
        /*end gridview */
    </style>
    <h3>Assessment Question</h3>
    <div class="container">


        <asp:HiddenField ID="HiddenTypeOfQuestion" runat="server" />
        <asp:HiddenField ID="HiddenData" runat="server" />
        <%
            if (HiddenTypeOfQuestion.Value == "QNA")
            { %>

        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="WrittenQuestionID" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered table-hover">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="WrittenQuestionID" HeaderText="WrittenQuestionID" InsertVisible="False" ReadOnly="True" SortExpression="WrittenQuestionID" />
                <asp:BoundField DataField="QuestionTitle" HeaderText="QuestionTitle" SortExpression="QuestionTitle" />
                <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" SortExpression="WrittenID" />
                <asp:BoundField DataField="MaximumScore" HeaderText="MaximumScore" SortExpression="MaximumScore" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [WrittenQuestion] WHERE [WrittenQuestionID] = @WrittenQuestionID" InsertCommand="INSERT INTO [WrittenQuestion] ([QuestionTitle], [WrittenID], [MaximumScore]) VALUES (@QuestionTitle, @WrittenID, @MaximumScore)" SelectCommand="SELECT * FROM [WrittenQuestion] WHERE ([WrittenID] = @WrittenID)" UpdateCommand="UPDATE [WrittenQuestion] SET [QuestionTitle] = @QuestionTitle, [WrittenID] = @WrittenID, [MaximumScore] = @MaximumScore WHERE [WrittenQuestionID] = @WrittenQuestionID">
            <DeleteParameters>
                <asp:Parameter Name="WrittenQuestionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="QuestionTitle" Type="String" />
                <asp:Parameter Name="WrittenID" Type="Int32" />
                <asp:Parameter Name="MaximumScore" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenData" Name="WrittenID" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="QuestionTitle" Type="String" />
                <asp:Parameter Name="WrittenID" Type="Int32" />
                <asp:Parameter Name="MaximumScore" Type="Int32" />
                <asp:Parameter Name="WrittenQuestionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <%    }
            else if (HiddenTypeOfQuestion.Value == "MCQ")
            {%>
        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MCQQuestionID" DataSourceID="SqlDataSource2" CssClass="table table-striped table-bordered table-hover">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <%-- <asp:BoundField DataField="MCQQuestionID" HeaderText="MCQQuestionID" InsertVisible="False" ReadOnly="True" SortExpression="MCQQuestionID"  />--%>
                <asp:BoundField DataField="QuestionTitle" HeaderText="QuestionTitle" SortExpression="QuestionTitle" />
                <asp:BoundField DataField="ChoiceA" HeaderText="ChoiceA" SortExpression="ChoiceA" />
                <asp:BoundField DataField="ChoiceB" HeaderText="ChoiceB" SortExpression="ChoiceB" />
                <asp:BoundField DataField="ChoiceC" HeaderText="ChoiceC" SortExpression="ChoiceC" />
                <asp:BoundField DataField="ChoiceD" HeaderText="ChoiceD" SortExpression="ChoiceD" />
                <asp:BoundField DataField="Answer" HeaderText="Answer" SortExpression="Answer" />
                <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" SortExpression="MCQAssessmentID" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [MCQQuestion] WHERE [MCQQuestionID] = @MCQQuestionID" InsertCommand="INSERT INTO [MCQQuestion] ([QuestionTitle], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [Answer], [MCQAssessmentID]) VALUES (@QuestionTitle, @ChoiceA, @ChoiceB, @ChoiceC, @ChoiceD, @Answer, @MCQAssessmentID)" SelectCommand="SELECT * FROM [MCQQuestion] WHERE ([MCQAssessmentID] = @MCQAssessmentID)" UpdateCommand="UPDATE [MCQQuestion] SET [QuestionTitle] = @QuestionTitle, [ChoiceA] = @ChoiceA, [ChoiceB] = @ChoiceB, [ChoiceC] = @ChoiceC, [ChoiceD] = @ChoiceD, [Answer] = @Answer, [MCQAssessmentID] = @MCQAssessmentID WHERE [MCQQuestionID] = @MCQQuestionID">
            <DeleteParameters>
                <asp:Parameter Name="MCQQuestionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="QuestionTitle" Type="String" />
                <asp:Parameter Name="ChoiceA" Type="String" />
                <asp:Parameter Name="ChoiceB" Type="String" />
                <asp:Parameter Name="ChoiceC" Type="String" />
                <asp:Parameter Name="ChoiceD" Type="String" />
                <asp:Parameter Name="Answer" Type="String" />
                <asp:Parameter Name="MCQAssessmentID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenData" Name="MCQAssessmentID" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="QuestionTitle" Type="String" />
                <asp:Parameter Name="ChoiceA" Type="String" />
                <asp:Parameter Name="ChoiceB" Type="String" />
                <asp:Parameter Name="ChoiceC" Type="String" />
                <asp:Parameter Name="ChoiceD" Type="String" />
                <asp:Parameter Name="Answer" Type="String" />
                <asp:Parameter Name="MCQAssessmentID" Type="Int32" />
                <asp:Parameter Name="MCQQuestionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <%  }
            else
            {%>

        <h2>No Record Found!</h2>

        <% } %>
    </div>
</asp:Content>
