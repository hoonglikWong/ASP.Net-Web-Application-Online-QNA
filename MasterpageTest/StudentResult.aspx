<%@ Page Language="C#"  MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="StudentResult.aspx.cs" Inherits="MasterpageTest.StudentResult" %>

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
    <h1>Student Result</h1>
    <asp:HiddenField ID="TypeRequest" runat="server" />

    <%
    if (TypeRequest.Value == "MCQ")
    {  %>
    
        <asp:Label ID="LabelStudentResultList" runat="server" Text=""></asp:Label>
        <asp:GridView ID="StudentResultList" runat="server" AutoGenerateColumns="False"   CssClass="table table-striped table-bordered table-hover" DataKeyNames="MCQAssessmentID,Email" DataSourceID="StudentResultQuery">
        <Columns>
            <asp:BoundField DataField="MCQAssessmentID" HeaderText="MCQAssessmentID" ReadOnly="True" SortExpression="MCQAssessmentID" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="Result" HeaderText="Result" SortExpression="Result" />
        </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="StudentResultQuery" runat="server" OnSelected="StudentResultQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MCQResult] WHERE ([MCQAssessmentID] = @MCQAssessmentID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="MCQAssessmentID" QueryStringField="MCQAssessmentID" Type="Int32" />
        </SelectParameters>
        </asp:SqlDataSource>
     <% }
    else if (TypeRequest.Value == "QNA")
    { %>
    <asp:Label ID="LabelStudentResultQNA" runat="server" Text=""></asp:Label>
    <asp:GridView ID="StudentResultQNA" runat="server" AutoGenerateColumns="False"   CssClass="table table-striped table-bordered table-hover" DataKeyNames="WrittenID,Email" DataSourceID="WrittenResultQuery">
        <Columns>
            <asp:BoundField DataField="WrittenID" HeaderText="WrittenID" ReadOnly="True" SortExpression="WrittenID" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
            <asp:BoundField DataField="Result" HeaderText="Result" SortExpression="Result" />
        </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="WrittenResultQuery" runat="server" OnSelected="WrittenResultQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenResult] WHERE ([WrittenID] = @WrittenID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="WrittenID" QueryStringField="WrittenID" Type="Int32" />
        </SelectParameters>
        </asp:SqlDataSource>

  <%}
    else
    { %>
    <asp:Label ID="StudentList" runat="server" Text="None student is marked!"></asp:Label>
  <%} %>
    



    


</asp:Content>