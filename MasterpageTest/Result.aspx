<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="MasterpageTest.View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" href="Scripts/font-awesome.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        * {
            box-sizing: border-box;
        }

        .assessmentTitle, .TypeOfQuestion, .TypeOfAssessmentQuestion, .MaximumMark {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        .questionTitle {
            width: 95%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
            margin-bottom: -20px;
            margin-top: 20px;
        }

        .questionText {
            width: 50%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        label {
            padding: 12px 12px 12px 0;
            display: inline-block;
        }

        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .col-25 {
            float: left;
            width: 25%;
            margin-top: 6px;
        }

        .col-75 {
            float: left;
            width: 75%;
            margin-top: 6px;
        }


        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        /* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
        @media screen and (max-width: 600px) {


            .col-25, .col-75 {
                width: 100%;
                margin-top: 0;
            }
        }

        .submit {
            margin-right: -20px;
            margin-top: 20px;
            background-color: black;
            height: 50px;
            width: 120px;
            color: white;
            float: right;
            border: 1px solid white;
            border-radius: 5px;
            outline: none;
            transform: translate(-50%,-50%);
            transition: all .8s;
        }

            .submit:hover {
                background-color: gray;
                color: #2d2d2d;
                cursor: pointer;
            }


        /* The container */
        .containerRadio {
            display: block;
            position: relative;
            padding-left: 35px;
            margin-bottom: 12px;
            cursor: pointer;
            font-size: 22px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

            /* Hide the browser's default radio button */
            .containerRadio input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
            }

        /* Create a custom radio button */
        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 25px;
            width: 25px;
            background-color: #bbb;
            border-radius: 50%;
        }

        /* On mouse-over, add a grey background color */
        .containerRadio:hover input ~ .checkmark {
            background-color: #ccc;
        }

        /* When the radio button is checked, add a blue background */
        .containerRadio input:checked ~ .checkmark {
            background-color: #2196F3;
        }

        /* Create the indicator (the dot/circle - hidden when not checked) */
        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        /* Show the indicator (dot/circle) when checked */
        .containerRadio input:checked ~ .checkmark:after {
            display: block;
        }

        /* Style the indicator (dot/circle) */
        .containerRadio .checkmark:after {
            top: 9px;
            left: 9px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: white;
        }
    </style>

    <h1>Result</h1>

    <asp:HiddenField ID="hiddenResult" runat="server" />
    <asp:HiddenField ID="hiddenStatus" runat="server" />


    <%
        if (hiddenStatus.Value == "Student")
        { %>

    <h4>Multiple Choice Question Result</h4>
    <asp:Label ID="LabelStudentResult" runat="server" Text=""></asp:Label>
    <asp:GridView ID="StudentResult" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataKeyNames="MCQAssessmentID,MCQAssessmentID1,Email" DataSourceID="StudentResultQuery">
        <Columns>
            <%--<asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" InsertVisible="False" ReadOnly="True" SortExpression="MCQAssessmentID" />--%>
            <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
            <asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />
            <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />
            <%-- <asp:BoundField DataField="MCQAssessmentID1" HeaderText="MCQAssessmentID1" ReadOnly="True" SortExpression="MCQAssessmentID1" />--%>
            <%--<asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />--%>
            <asp:BoundField DataField="Result" HeaderText="Result" SortExpression="Result" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="StudentResultQuery" runat="server" OnSelected="StudentResultQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM MCQAssessment MA, MCQResult MR WHERE MA.MCQAssessmentID = MR.MCQAssessmentID AND MR.Email = @Email">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenResult" Name="Email" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />

    <h4>Open Ended Question Result</h4>
    <asp:Label ID="LabelStudentResultQNA" runat="server" Text=""></asp:Label>
    <asp:GridView ID="StudentResultQNA" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataKeyNames="WrittenID" DataSourceID="StudentResultQNAQuery">
        <Columns>
            <%--<asp:BoundField DataField="WrittenID" HeaderText="WrittenID" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID" />--%>
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
            <asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
            <%--<asp:BoundField DataField="WrittenID1" HeaderText="WrittenID1" ReadOnly="True" SortExpression="WrittenID1" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />--%>
            <asp:BoundField DataField="Result" HeaderText="Result" SortExpression="Result" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="StudentResultQNAQuery" runat="server" OnSelected="StudentResultQNAQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM WrittenAssessment WA, WrittenResult WR WHERE WA.WrittenID = WR.WrittenID AND WR.Email = @Email">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenResult" Name="Email" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>

    <% }  %>



    <%
        if (hiddenStatus.Value == "Lecturer")
        { %>
    <h4>Multiple Choice Question Result</h4>
    <asp:GridView ID="MCQAssessmentResult" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataKeyNames="MCQAssessmentID" DataSourceID="MCQAssessmentResultQuery" OnSelectedIndexChanged="MCQAssessmentResult_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" InsertVisible="False" ReadOnly="True" SortExpression="MCQAssessmentID" />
            <asp:BoundField DataField="MCQTitle" HeaderText="MCQTitle" SortExpression="MCQTitle" />
            <%--<asp:BoundField DataField="MCQLecturerEmail" HeaderText="MCQLecturerEmail" SortExpression="MCQLecturerEmail" />--%>
            <asp:BoundField DataField="MCQAssessmentType" HeaderText="MCQAssessmentType" SortExpression="MCQAssessmentType" />
        </Columns>
    </asp:GridView>


    <asp:SqlDataSource ID="MCQAssessmentResultQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MCQAssessment] WHERE ([MCQLecturerEmail] = @MCQLecturerEmail)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenResult" Name="MCQLecturerEmail" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />
    <h4>Open Ended Question Result</h4>



    <asp:GridView ID="QNAAssessmentResult" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataKeyNames="WrittenID" DataSourceID="QNAAssessmentResultQuery" OnSelectedIndexChanged="QNAAssessmentResult_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" InsertVisible="False" ReadOnly="True" SortExpression="WrittenID" />
            <asp:BoundField DataField="WrittenTitle" HeaderText="WrittenTitle" SortExpression="WrittenTitle" />
            <%--<asp:BoundField DataField="WrittenLectureEmail" HeaderText="WrittenLectureEmail" SortExpression="WrittenLectureEmail" />--%>
            <asp:BoundField DataField="WrittenAssessmentType" HeaderText="WrittenAssessmentType" SortExpression="WrittenAssessmentType" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="QNAAssessmentResultQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessment] WHERE ([WrittenLectureEmail] = @WrittenLectureEmail)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenResult" Name="WrittenLectureEmail" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%   }  %>
</asp:Content>
