<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageAssessment.aspx.cs" Inherits="MasterpageTest.ManageAssessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery.searchabledropdown-1.0.8.min.js" type="text/javascript"></script>

    <link rel="stylesheet" href="Scripts/font-awesome.min.css">
    <style>
        * {
            box-sizing: border-box;
        }

        label {
            padding: 12px 12px 12px 0;
            display: inline-block;
        }

        .table-responsive {
            display: table;
        }

        .SearchAssessment {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        .TypeOfQuestion {
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
        /*end gridview */
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("select").searchable({
                maxListSize: 200, // if list size are less than maxListSize, show them all
                maxMultiMatch: 300, // how many matching entries should be displayed
                exactMatch: false, // Exact matching on search
                wildcards: true, // Support for wildcard characters (*, ?)
                ignoreCase: true, // Ignore case sensitivity
                latency: 200, // how many millis to wait until starting search
                warnMultiMatch: 'top {0} matches ...',
                warnNoMatch: 'no matches ...',
                zIndex: 'auto'
            });
        });

    </script>

    <h1>Manage Assessment</h1>


    <div class="container">
        <div class="row">
            <div class="col-25">
                <label for="TypeOfQuestion">Type of Question</label>
            </div>
            <div class="col-75">
                <asp:DropDownList ID="TypeOfQuestion" runat="server" CssClass="TypeOfQuestion" AutoPostBack="true">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Choose a Type of Question"></asp:ListItem>
                    <asp:ListItem Text="Multiple Choice Question" Value="MCQ"></asp:ListItem>
                    <asp:ListItem Text="Open Ended Question" Value="QNA"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>


        <%
    if (TypeOfQuestion.SelectedValue == "QNA")
    { %>

        <div class="row">
            <div class="col-25">
                <label for="SearchAssessment">&nbsp;&nbsp;&nbsp;Search Assessment</label>
            </div>
            <div class="col-75">
                <asp:DropDownList ID="SearchAssessmentQNA" AppendDataBoundItems="true" runat="server" CssClass="SearchAssessment" DataSourceID="SqlDataSource1" DataTextField="WrittenTitle" DataValueField="WrittenID" AutoPostBack="True" OnSelectedIndexChanged="SearchAssessmentQNA_SelectedIndexChanged">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Search the Assessment"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>


        <%}
    else if (TypeOfQuestion.SelectedValue == "MCQ")
    { %>

        <div class="row">
            <div class="col-25">
                <label for="SearchAssessment">&nbsp;&nbsp;&nbsp;Search Assessment</label>
            </div>
            <div class="col-75">
                <asp:DropDownList ID="SearchAssessment" AppendDataBoundItems="true" runat="server" CssClass="SearchAssessment" DataSourceID="SqlDataSource2" DataTextField="MCQTitle" DataValueField="MCQAssessmentID" AutoPostBack="True" OnSelectedIndexChanged="SearchAssessment_SelectedIndexChanged">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Search the Assessment"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <% }
    else
    {%>
        <%--do a javascript ask for select type of question first--%>
         <div class="row">
            <div class="col-25">
                <label for="SearchAssessment">&nbsp;&nbsp;&nbsp;Search Assessment</label>
            </div>
            <div class="col-75">
                <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" runat="server" CssClass="SearchAssessment">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Search the Assessment"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>



         <% } %>

        <asp:SqlDataSource ID="SqlDataSource1" OnSelected="SqlDataSource1_Selected" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessment] WHERE (([WrittenLectureEmail] = @WrittenLectureEmail) AND ([WrittenLectureEmail] = @WrittenLectureEmail2))" DeleteCommand="DELETE FROM [WrittenAssessment] WHERE [WrittenID] = @WrittenID" InsertCommand="INSERT INTO [WrittenAssessment] ([WrittenTitle], [WrittenLectureEmail], [WrittenAssessmentType]) VALUES (@WrittenTitle, @WrittenLectureEmail, @WrittenAssessmentType)" UpdateCommand="UPDATE [WrittenAssessment] SET [WrittenTitle] = @WrittenTitle, [WrittenLectureEmail] = @WrittenLectureEmail, [WrittenAssessmentType] = @WrittenAssessmentType WHERE [WrittenID] = @WrittenID">
            <DeleteParameters>
                <asp:Parameter Name="WrittenID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="WrittenTitle" Type="String" />
                <asp:Parameter Name="WrittenLectureEmail" Type="String" />
                <asp:Parameter Name="WrittenAssessmentType" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenData" Name="WrittenLectureEmail" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="HiddenData" Name="WrittenLectureEmail2" PropertyName="Value" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="WrittenTitle" Type="String" />
                <asp:Parameter Name="WrittenLectureEmail" Type="String" />
                <asp:Parameter Name="WrittenAssessmentType" Type="String" />
                <asp:Parameter Name="WrittenID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" OnSelected="SqlDataSource2_Selected" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [MCQAssessment] WHERE [MCQAssessmentID] = @MCQAssessmentID" InsertCommand="INSERT INTO [MCQAssessment] ([MCQTitle], [MCQLecturerEmail], [MCQAssessmentType]) VALUES (@MCQTitle, @MCQLecturerEmail, @MCQAssessmentType)" SelectCommand="SELECT * FROM [MCQAssessment] WHERE ([MCQLecturerEmail] = @MCQLecturerEmail)" UpdateCommand="UPDATE [MCQAssessment] SET [MCQTitle] = @MCQTitle, [MCQLecturerEmail] = @MCQLecturerEmail, [MCQAssessmentType] = @MCQAssessmentType WHERE [MCQAssessmentID] = @MCQAssessmentID">
            <DeleteParameters>
                <asp:Parameter Name="MCQAssessmentID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MCQTitle" Type="String" />
                <asp:Parameter Name="MCQLecturerEmail" Type="String" />
                <asp:Parameter Name="MCQAssessmentType" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenData" Name="MCQLecturerEmail" PropertyName="Value" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="MCQTitle" Type="String" />
                <asp:Parameter Name="MCQLecturerEmail" Type="String" />
                <asp:Parameter Name="MCQAssessmentType" Type="String" />
                <asp:Parameter Name="MCQAssessmentID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:HiddenField ID="HiddenData" runat="server" />


        <br />

        <%
    if (IsPostBack)
    { %>
                <h3>Assessment Record</h3>
               <% if (TypeOfQuestion.SelectedValue == "QNA")
    { %>
        
        <asp:Label ID="LabelAssessmentRecordQNA" runat="server" Text=""></asp:Label>
        <asp:GridView ID="AssessmentRecordQNA" runat="server" AllowSorting="True" DataKeyNames="WrittenID" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="AssessmentRecordQNA_SelectedIndexChanged" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID" />
                <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
                <asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />
                <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
            </Columns>
        </asp:GridView>

        <%}
    else if (TypeOfQuestion.SelectedValue == "MCQ")
    { %>

        <asp:Label ID="LabelAssessmentRecord" runat="server" Text=""></asp:Label>
        <asp:GridView ID="AssessmentRecord" runat="server" AllowSorting="True" DataSourceID="SqlDataSource2" CssClass="table table-striped table-bordered table-hover" OnSelectedIndexChanged="AssessmentRecord_SelectedIndexChanged" AutoGenerateColumns="False" DataKeyNames="MCQAssessmentID">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" SortExpression="MCQAssessmentID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
                <asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />
                <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />
            </Columns>
        </asp:GridView>
        <%}
    }%>

    </div>

</asp:Content>

