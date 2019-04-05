<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AssessmentAssignation.aspx.cs" Inherits="MasterpageTest.AssessmentAssignation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" href="Scripts/font-awesome.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
        }

        .assessmentTitle, .TypeOfQuestion, .AssessmentQuestion, .MaximumMark {
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
    <h1>Assignation Private Assessment</h1>

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
        <div class="row">
            <div class="col-25">
                <label for="AssessmentQuestion">Assessment Question</label>
            </div>
            <div class="col-75">

                <%

                    if (TypeOfQuestion.SelectedValue == "MCQ")
                    { %>
                <asp:DropDownList ID="AssessmentQuestion" runat="server" CssClass="AssessmentQuestion" AutoPostBack="True" DataSourceID="AssessmentQuestionQuery" DataTextField="MCQTitle" DataValueField="MCQAssessmentID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="AssessmentQuestionQuery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MCQAssessment] WHERE ([MCQAssessmentType] = @MCQAssessmentType)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Private" Name="MCQAssessmentType" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%  }
                    else if (TypeOfQuestion.SelectedValue == "QNA")
                    {%>
                <asp:DropDownList ID="AssessmentQuestionQNA" runat="server" CssClass="AssessmentQuestion" AutoPostBack="True" DataSourceID="AssessmentQuestionQueryQNA" DataTextField="WrittenTitle" DataValueField="WrittenID"></asp:DropDownList>
                <asp:SqlDataSource ID="AssessmentQuestionQueryQNA" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [WrittenAssessment] WHERE ([WrittenAssessmentType] = @WrittenAssessmentType)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Private" Name="WrittenAssessmentType" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <%   }
                    else
                    { %>

                <asp:DropDownList ID="AssessmentQuestionEmpty" runat="server" CssClass="AssessmentQuestion" AutoPostBack="True">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Choose a Type of Question"></asp:ListItem>
                </asp:DropDownList>

                <%   }  %>
            </div>
        </div>
        <br />

        <% 
            if (TypeOfQuestion.SelectedValue == "MCQ")
            { %>
                <h4>Student List</h4>
        <asp:Label ID="LabelStudentList" runat="server" Text=""></asp:Label>
                <asp:GridView ID="StudentList" runat="server" AutoGenerateColumns="False" DataKeyNames="Email"  CssClass="table table-striped table-bordered table-hover" DataSourceID="StudentListQuery" OnSelectedIndexChanged="StudentList_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" SortExpression="ContactNumber" />
                        <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                        <asp:BoundField DataField="ProfileImage" HeaderText="ProfileImage" SortExpression="ProfileImage" />
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    </Columns>
        </asp:GridView>
                <asp:SqlDataSource ID="StudentListQuery" runat="server" OnSelected="StudentListQuery_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Person Where Email not in (Select Email from MCQAssessmentList Where MCQAssessmentID = @MCQAssessmentID AND Assignment = @Assignment) And Status = @Status">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="AssessmentQuestion" Name="MCQAssessmentID" PropertyName="SelectedValue" />
                        <asp:Parameter DefaultValue="ASSIGNED" Name="Assignment" />
                        <asp:Parameter DefaultValue="STUDENT" Name="Status" />
                    </SelectParameters>
        </asp:SqlDataSource>
        <%  }
            else if (TypeOfQuestion.SelectedValue == "QNA")
            {%>
                <h4>Student List</h4>
         <asp:Label ID="LabelStudentListQNA" runat="server" Text=""></asp:Label>
                <asp:GridView ID="StudentListQNA" runat="server" AutoGenerateColumns="False" DataKeyNames="Email"  CssClass="table table-striped table-bordered table-hover" DataSourceID="StudentListQueryQNA" OnSelectedIndexChanged="StudentListQNA_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" SortExpression="ContactNumber" />
                        <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                        <asp:BoundField DataField="ProfileImage" HeaderText="ProfileImage" SortExpression="ProfileImage" />
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    </Columns>
        </asp:GridView>
                <asp:SqlDataSource ID="StudentListQueryQNA" runat="server" OnSelected="StudentListQueryQNA_Selected" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"  SelectCommand="SELECT * FROM PERSON WHERE Email not in (SELECT Email from WrittenAssessmentList Where WrittenID= @WrittenID AND Assignment = @Assignment) AND Status = @Status">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="AssessmentQuestionQNA" Name="WrittenID" PropertyName="SelectedValue" />
                        <asp:Parameter DefaultValue="ASSIGNED" Name="Assignment" />
                        <asp:Parameter DefaultValue="STUDENT" Name="Status" />
                    </SelectParameters>
        </asp:SqlDataSource>

        <%   }%>
    </div>
</asp:Content>

