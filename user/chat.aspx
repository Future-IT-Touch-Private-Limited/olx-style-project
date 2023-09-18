<%@ Page Title="" Language="C#" MasterPageFile="~/main-user.master" AutoEventWireup="true" CodeFile="chat.aspx.cs" Inherits="user_chat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .chatbox {
            /*max-width: 400px;*/
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .chatbox-header {
            background: linear-gradient(to right, #fcbc80, #f6416c);
            color: #fff;
            padding: 25px 30px;
            text-align: center;
            font-weight: bold;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .chatbox-body {
            padding: 15px;
            max-height: 300px;
            overflow-y: auto;
        }

        .message {
            background-color: #f0f0f0;
            padding: 20px;
            margin: 25px 0;
            border-radius: 10px;
        }

            .message.sent {
                background-color: #daf4ff;
                text-align: right;
                margin-left: 60px;
            }

            .message.received {
                background-color: #f6f6f6;
                text-align: left;
                margin-right: 60px;
            }

        .chatbox-footer {
            padding: 10px;
            border-top: 1px solid #ddd;
        }

            .chatbox-footer input {
                width: 100%;
                padding: 8px;
                border: none;
                border-radius: 5px;
                outline: none;
            }

            .chatbox-footer button {
                margin-top: 5px;
            }


        .message {
            position: relative;
        }

            .message::before {
                content: attr(data-sender);
                position: absolute;
                top: -15px;
                font-size: 12px;
                color: #aaa;
            }

            .message.sent::before {
                right: 10px;
            }

            .message.received::before {
                left: 10px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Live Chat</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dash" data-bs-original-title="" title="">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg></a></li>
                        <li class="breadcrumb-item">Chat</li>
                        <li class="breadcrumb-item active">Live Chat</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:HiddenField ID="sender_name_hf" runat="server" />
            <asp:HiddenField ID="receiver_name_hf" runat="server" />
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2">
                        <div class="chatbox">
                            <div class="chatbox-header">Chatbox (Chat with
                                <asp:Label ID="receiver_lbl" Font-Bold="true" runat="server" Text=""></asp:Label>)</div>
                            <div class="chatbox-body">
                                <asp:Repeater ID="Repeater1" OnItemDataBound="Repeater1_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="from_username_hf" Value='<%# Eval("from_username") %>' runat="server" />
                                        <asp:Panel ID="messageDiv" CssClass="" runat="server"><%# Eval("message") %></asp:Panel>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="chatbox-footer">
                                <asp:TextBox ID="messagetxt" runat="server" placeholder="Type your message..."></asp:TextBox>
                                <asp:Button ID="sendbtn" OnClick="sendbtn_Click" class="btn btn-primary" runat="server" Text="Send" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // Function to scroll the chatbox to the bottom
                function scrollToBottom() {
                    var chatbox = document.getElementById('<%= Repeater1.ClientID %>');
                    chatbox.scrollTop = chatbox.scrollHeight;
                }

                // Call the server-side function to fill the Repeater with updated data
                function updateChatbox() {
                    PageMethods.FillRepeater(function (result) {
                        var repeaterContainer = document.getElementById('<%= Repeater1.ClientID %>');
            repeaterContainer.innerHTML = result;

            // Scroll to the bottom after updating the Repeater
            scrollToBottom();
        });
                }

                // Register the script to be called after each UpdatePanel update
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_endRequest(function () {
                    // Call the updateChatbox function after each UpdatePanel update
                    updateChatbox();
                });

                // Call the updateChatbox function when the page initially loads
                window.onload = function () {
                    updateChatbox();
                    // Set interval for updating the chatbox every 5 seconds
                    setInterval(updateChatbox, 5000);
                };
            </script>


        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
