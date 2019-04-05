<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainLoginPage.aspx.cs" Inherits="MasterpageTest.MainLoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/JQUERYMain.js"></script>
    <title>TARUC</title>
</head>
<body>
<%--    <script>
        $(document).ready(function () {
            $("#signup_btn").click(function () {
                $("#main").animate({ left: "22.5%" }, 400);
                $("#main").animate({ left: "30%" }, 500);
                $("#loginform").css("visibility", "hidden");
                $("#loginform").animate({ left: "25%" }, 400);

                $("#signupform").animate({ left: "17%" }, 400);
                $("#signupform").animate({ left: "30%" }, 500);
                $("#signupform").css("visibility", "visible");
            });

            $("#login_btn").click(function () {
                $("#main").animate({ left: "77.5%" }, 400);
                $("#main").animate({ left: "70%" }, 500);
                $("#signupform").css("visibility", "hidden");
                $("#signupform").animate({ left: "75%" }, 400);

                $("#loginform").animate({ left: "83.5%" }, 400);
                $("#loginform").animate({ left: "70%" }, 500);
                $("#loginform").css("visibility", "visible");
            });
        });


    </script>--%>
    <style>
        body {
            margin: 0px;
            padding: 0px;
            background-color: lightblue;
        }

        #box {
            height: 200px;
            width: 1000px;
            background-color: #2D2D2D;
            border-radius: 5px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
        }

        #main {
            height: 450px;
            width: 450px;
            background-color: white;
            border-radius: 5px;
            position: absolute;
            top: 50%;
            left: 70%;
            transform: translate(-50%,-50%);
            z-index: 99;
        }

        #loginform, #signupform {
            position: absolute;
            top: 50%;
            left: 70%;
            transform: translate(-50%,-50%);
            z-index: 999;
        }

        #signupform {
            top: 45%;
            left: 75%;
            visibility: hidden;
        }

            #loginform h1, #signupform h1 {
                font-family: arial;
                font-size: 25px;
                color: lightblue;
            }

        #loginEmail, #loginPassword, #Name, #SignUpEmail, #SignUpPassword, #SignUpContact, #SignUpGender, #SignUpStatus {
            height: 40px;
            width: 300px;
            border: 0px;
            outline: none;
            border-bottom: 1px solid black;
            margin: 5px;
        }

        #ChkMeText, #ChkMeText {
            height: 40px;
            width: 300px;
            border: 0px;
            outline: none;
            margin: 5px;
        }

        .loginButton, .signupButton {
            height: 35px;
            width: 130px;
            background-color: lightblue;
            font-family: monospace;
            font-size: 16px;
            color: white;
            border: none;
            outline: none;
            border-radius: 5px;
            margin-top: 30px;
            margin-left: 175px;
        }

            .loginButton:hover, .signupButton:hover {
                background-color: Highlight;
                color: white;
                cursor: pointer;
            }

        #login_btn, #signup_btn {
            height: 35px;
            width: 120px;
            background-color: transparent;
            color: white;
            border: 1px solid white;
            border-radius: 5px;
            outline: none;
            position: absolute;
            left: 75%;
            top: 65%;
            transform: translate(-50%,-50%);
            transition: all .8s;
        }

        #signup_btn {
            left: 25%;
        }

            #login_btn:hover, #signup_btn:hover {
                background-color: white;
                color: #2d2d2d;
                cursor: pointer;
            }

        #login_msg, #signup_msg {
            font-family: arial;
            font-size: 25px;
            color: white;
            position: absolute;
            top: 35%;
            left: 75%;
            transform: translate(-50%,-50%);
            z-index: 1;
        }

        #signup_msg {
            left: 25%;
        }
    </style>

    <div id="box">
        <div id="main"></div>

        <form id="form1" runat="server">
            <div id="loginform">
                <h1>LOGIN</h1>
                <asp:TextBox ID="loginEmail" runat="server" placeholder="Email" type="email"></asp:TextBox><br />
                <asp:TextBox ID="loginPassword" runat="server" placeholder="Password" type="password"></asp:TextBox><br />
                <br />
                <asp:Label ID="ChkMeText" runat="server" Text="Remember Me: "></asp:Label><asp:CheckBox ID="ChkMe" runat="server" />
                <asp:Button ID="loginButton" CssClass="loginButton" runat="server" Text="LOGIN" OnClick="loginButton_Click" />
            </div>

            <div id="signupform">
                <h1>SIGN UP</h1>
                <asp:TextBox ID="Name" runat="server" placeholder="Full Name" type="text"></asp:TextBox><br />
                <asp:TextBox ID="SignUpEmail" runat="server" placeholder="Email" type="email"></asp:TextBox><br />
                <asp:TextBox ID="SignUpPassword" runat="server" placeholder="Password" type="password"></asp:TextBox><br />
                <asp:TextBox ID="SignUpContact" runat="server" placeholder="Contact Number" type="text"></asp:TextBox><br />
                <asp:DropDownList ID="SignUpGender" runat="server">
                    <asp:ListItem disabled="disabled" Selected="true" Text="Please Select Gender"></asp:ListItem>
                    <asp:ListItem Value="Male" Text="Male"></asp:ListItem>
                    <asp:ListItem Value="Female" Text="Female"></asp:ListItem>
                </asp:DropDownList><br />
                <asp:DropDownList ID="SignUpStatus" runat="server">
                    <asp:ListItem disabled="disabled" Selected="true" Text="I am a:"></asp:ListItem>
                    <asp:ListItem Value="Student" Text="Student"></asp:ListItem>
                    <asp:ListItem Value="Lecturer" Text="Lecturer"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Button ID="signupButton" CssClass="signupButton" runat="server" Text="SIGN UP" OnClick="signupButton_Click" />
            </div>
        </form>


        <div id="login_msg">Have an account?</div>
        <div id="signup_msg">Don't have an account?</div>

        <button id="login_btn">LOGIN</button>
        <button id="signup_btn">SIGN UP</button>
    </div>
</body>
</html>
