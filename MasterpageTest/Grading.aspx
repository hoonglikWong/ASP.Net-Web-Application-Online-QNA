<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Grading.aspx.cs" Inherits="MasterpageTest.Grading" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Mark Assessment</h1>
    <asp:HiddenField ID="HiddenData" runat="server" />

    <asp:DataList ID="DataListWritten" runat="server">
        <ItemTemplate>
            <p>
                Q<%#Container.ItemIndex+1 %>)<%# Eval("QuestionTitle")%></p>
            <asp:HiddenField ID="QuestionID" runat="server" Value='<%# Eval("WrittenQuestionID") %>' />
            <asp:HiddenField ID="ResponseEmail" runat="server" Value='<%# Eval("Email") %>' />
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="UserAnswer" runat="server" Columns="15" Rows="5" Text='<%# Eval("AnswerResponse") %>' Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Total Mark: "></asp:Label>
                        <asp:HiddenField ID="MarkHidden" runat="server" Value='<%# Eval("MaximumScore") %>'/>
                        <asp:Label ID="Mark" runat="server" Text=""><%# Eval("MaximumScore") %></asp:Label>
                        <asp:TextBox ID="WrittenMark" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click"/>
</asp:Content>
