<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Assessment.aspx.cs" Inherits="MasterpageTest.Assessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Create Assessment</h1>
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" href="Scripts/font-awesome.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script runat="server">

        void Server_Change(object sender, EventArgs e)
        {
            if (OptionAnswer1.Checked)
                OptionValue.Value = OptionAnswer1.Value;
            else if (OptionAnswer2.Checked)
                OptionValue.Value = OptionAnswer2.Value;
            else if (OptionAnswer3.Checked)
                OptionValue.Value = OptionAnswer3.Value;
            else if (OptionAnswer4.Checked)
                OptionValue.Value = OptionAnswer4.Value;
        }


    </script>
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

    <div class="scp-quizzes-main">
        <div class="scp-quizzes-data">
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
                        <label for="selection">Selection</label>
                    </div>
                    <div class="col-75">
                        <asp:DropDownList ID="Selection" runat="server" CssClass="TypeOfAssessmentQuestion" AutoPostBack="True">
                            <asp:ListItem disabled="disabled" Selected="true" Text="Please Select to Add New or Add Existing Assessment"></asp:ListItem>
                            <asp:ListItem Text="Add New Assessment" Value="NewAssessment"></asp:ListItem>
                            <asp:ListItem Text="Add Existing Assessment" Value="ExistingAssessment"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:HiddenField ID="hiddenData" runat="server" />
                <%
                    if (TypeOfQuestion.SelectedValue == "MCQ")
                    {
                        if (Selection.SelectedValue == "ExistingAssessment")
                        { %>
                <div class="row">
                    <div class="col-25">
                        <label for="selection">Existing Assessment</label>
                    </div>
                    <div class="col-75">
                        <asp:DropDownList ID="ChooseAssessment" runat="server" CssClass="TypeOfAssessmentQuestion" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="MCQTitle" DataValueField="MCQAssessmentID">
                            <asp:ListItem disabled="disabled" Selected="true" Text="Please Choose a Assessment Question"></asp:ListItem>
                        </asp:DropDownList>


                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [MCQAssessmentID] ,[MCQTitle] FROM [MCQAssessment] WHERE ([MCQLecturerEmail] = @MCQLecturerEmail)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenData" Name="MCQLecturerEmail" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                </div>
                <%  } %>
                <%}
                    else if (TypeOfQuestion.SelectedValue == "QNA")
                    {
                        if (Selection.SelectedValue == "ExistingAssessment")
                        { %>
                <div class="row">
                    <div class="col-25">
                        <label for="selection">Existing Assessment</label>
                    </div>
                    <div class="col-75">
                        <asp:DropDownList ID="ChooseAssessment2" runat="server" CssClass="TypeOfAssessmentQuestion" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="WrittenTitle" DataValueField="WrittenID">
                            <asp:ListItem disabled="disabled" Selected="true" Text="Please Choose a Assessment Question"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [WrittenID],[WrittenTitle] FROM [WrittenAssessment] WHERE ([WrittenLectureEmail] = @WrittenLectureEmail)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hiddenData" Name="WrittenLectureEmail" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <%  } %>
                <%} %>

                <div class="row">
                    <div class="col-25">
                        <label for="assessmentSubject">Type of Assessment</label>
                    </div>

                    <div class="col-75">
                        <asp:DropDownList ID="TypeOfAssessmentQuestion" runat="server" CssClass="TypeOfAssessmentQuestion">
                            <asp:ListItem disabled="disabled" Selected="true" Text="Please Choose a Type of Assessment Question"></asp:ListItem>
                            <asp:ListItem Text="Public" Value="Public"></asp:ListItem>
                            <asp:ListItem Text="Private" Value="Private"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>


                <%
                    if (!(Selection.SelectedValue == "ExistingAssessment"))
                    { %>
                <div class="row">
                    <div class="col-25">
                        <label for="assessmentTitle">Assessment Title</label>
                    </div>
                    <div class="col-75">
                        <asp:TextBox ID="assessmentTitle" runat="server" placeholder="Assessment Title" type="text" CssClass="assessmentTitle"></asp:TextBox>
                    </div>
                </div>
                <%  }%>
            </div>


            <%
                if (TypeOfQuestion.SelectedValue == "MCQ")
                {
            %>
            <h4>Q.&nbsp;&nbsp;<asp:TextBox ID="MCQTitle" runat="server" CssClass="questionTitle" Text=""></asp:TextBox></h4>
            <br />
            <table>
                <tr>
                    <td>
                        <label class="containerRadio">
                            <input type="radio" name="radio" runat="server" value="A" id="OptionAnswer1" onserverchange="Server_Change" >
                            <span class="checkmark"></span>
                        </label>
                    </td>
                    <td style="width: 100%">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A&nbsp;&nbsp;<asp:TextBox ID="OptionA" runat="server" CssClass="questionText" Text=""></asp:TextBox></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="containerRadio">
                            <input type="radio" name="radio" runat="server" value="B" id="OptionAnswer2" onserverchange="Server_Change" >
                            <span class="checkmark"></span>
                        </label>
                    </td>
                    <td style="width: 100%">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B&nbsp;&nbsp;<asp:TextBox ID="OptionB" runat="server" CssClass="questionText" Text=""></asp:TextBox></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="containerRadio">
                            <input type="radio" name="radio" runat="server" value="C" id="OptionAnswer3" onserverchange="Server_Change" >
                            <span class="checkmark"></span>
                        </label>
                    </td>
                    <td style="width: 100%">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C&nbsp;&nbsp;<asp:TextBox ID="OptionC" runat="server" CssClass="questionText" Text=""></asp:TextBox></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="containerRadio">
                            <input type="radio" name="radio" runat="server" value="D" id="OptionAnswer4" onserverchange="Server_Change" >
                            <span class="checkmark"></span>
                        </label>
                    </td>
                    <td style="width: 100%">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;<asp:TextBox ID="OptionD" runat="server" CssClass="questionText" Text=""></asp:TextBox></p>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="OptionValue" runat="server" />


            <% }%>

            <%
                if (TypeOfQuestion.SelectedValue == "QNA")
                { %>
            <h4>Q1.&nbsp;<asp:TextBox ID="QNATitle" runat="server" CssClass="questionTitle" Text=""></asp:TextBox></h4>
            <div class="container">
                <div class="row">
                    <div class="col-25">
                        <label for="assessmentTitle">Maximum Mark</label>
                    </div>
                    <div class="col-75">
                        <asp:TextBox ID="Mark" runat="server" placeholder="Maximum Mark" type="number" CssClass="MaximumMark"></asp:TextBox>
                    </div>
                </div>
            </div>


            <% }%>
        </div>
        <asp:Label ID="SubmittedMessage" runat="server" Text=""></asp:Label>
        <%
            if (Selection.SelectedValue == "ExistingAssessment")
            {%>
        <asp:Button ID="SubmitButtonExisting" runat="server" Text="Submit" CssClass="submit" OnClick="SubmitButtonExisting_Click" />
        <% }
            else
            { %>
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="submit" OnClick="SubmitButton_Click" />
        <% }%>
    </div>
</asp:Content>
