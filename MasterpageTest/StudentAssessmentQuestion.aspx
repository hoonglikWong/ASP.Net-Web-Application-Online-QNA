<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentAssessmentQuestion.aspx.cs" Inherits="MasterpageTest.StudentAssessmentQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Assessment Question</h1>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
    <asp:HiddenField ID="HiddenTypeOfQuestion" runat="server" />
    <asp:HiddenField ID="HiddenData" runat="server" />


    <%
        if (HiddenTypeOfQuestion.Value == "MCQ")
        {  %>

    <asp:DataList ID="DataListQuestion" runat="server">
        <ItemTemplate>
            <p>
                Q<%#Container.ItemIndex+1 %>)<%# Eval("QuestionTitle")%></p>
            <asp:HiddenField ID="QuestionID" runat="server" Value='<%# Eval("MCQQuestionID") %>' />
            <table>
                <tr>
                    <td>
                        <asp:RadioButton ID="rblOptionOne" GroupName="Questions" Text='<%# Eval("ChoiceA") %>'
                            runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButton ID="rblOptionTwo" GroupName="Questions" Text='<%# Eval("ChoiceB") %>'
                            runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButton ID="rblOptionThree" GroupName="Questions" Text='<%# Eval("ChoiceC") %>'
                            runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButton ID="rblOptionFour" GroupName="Questions" Text='<%# Eval("ChoiceD") %>'
                            runat="server" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <%}%>

    <%
        if (HiddenTypeOfQuestion.Value == "QNA")
        {  %>

    <asp:DataList ID="QNADataList" runat="server">
        <ItemTemplate>
            <p>
                Q<%#Container.ItemIndex+1 %>)<%# Eval("QuestionTitle")%></p>
            <asp:HiddenField ID="QuestionID" runat="server" Value='<%# Eval("WrittenQuestionID") %>' />
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="UserAnswer" runat="server" Columns="15" Rows="5"></asp:TextBox>               
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Total Mark: "></asp:Label>
                        <asp:Label ID="Mark" runat="server" Text=""><%# Eval("MaximumScore") %></asp:Label>

                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>

     <% } %>


    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />

</asp:Content>


