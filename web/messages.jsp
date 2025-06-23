<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AgriRescue - Messages</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <style>
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
            }
            .modal-content {
                background-color: white;
                margin: 15% auto;
                padding: 20px;
                width: 70%;
                max-width: 500px;
                border-radius: 5px;
            }
            .unread-badge {
                background-color: red;
                color: white;
                padding: 2px 6px;
                border-radius: 50%;
                font-size: 12px;
            }
            .chat-container {
                display: flex;
                height: calc(100vh - 64px);
                background: linear-gradient(to right, #e0f7fa 0%, #e0f7fa 50%, #c6f6d5 50%, #c6f6d5 100%);
            }
            .sidebar {
                width: 30%;
                border-right: 1px solid #e5e7eb;
                overflow-y: auto;
                background-color: #ffffff;
                display: block;
            }

            .conversation {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                transition: background-color 0.3s;
                word-break: break-word;
            }

            .username-text {
                color: #1a202c;
                font-weight: 500;
                max-width: 80%;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                display: inline-block;
            }
            .chat-area {
                flex: 1;
                display: flex;
                flex-direction: column;
            }
            .messages {
                flex: 1;
                overflow-y: auto;
                padding: 10px;
                display: flex;
                flex-direction: column;
            }
            .message-wrapper {
                margin-bottom: 10px;
            }
            .input-area {
                padding: 10px;
                border-top: 1px solid #e5e7eb;
                width: 100%;
            }
            .language-select {
                padding: 4px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .sent-bubble {
                margin-left: auto !important;
                background-color: #10b981;
                color: white;
                padding: 6px 10px;
                border-radius: 10px;
                max-width: 60%;
                text-align: right;
            }
            .received-bubble {
                margin-right: auto !important;
                background-color: #e5e7eb;
                color: #374151;
                padding: 6px 10px;
                border-radius: 10px;
                max-width: 60%;
            }
            .time-stamp {
                font-size: 0.75rem;
                margin-top: 4px;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <%
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <header class="bg-green-600 text-white py-4 px-6 flex justify-between items-center shadow">
            <div class="flex items-center space-x-4">
                <h1 class="text-2xl font-bold">AgriRescue - Messages</h1>
                <a href="<%= request.getContextPath()%>/home" class="bg-green-800 px-4 py-2 rounded hover:bg-green-900">Home</a>
            </div>
            <div class="flex items-center space-x-3">
                <span>Welcome, <%= session.getAttribute("user")%>!</span>
                <a href="userprofile.jsp" class="bg-blue-600 px-4 py-2 rounded hover:bg-blue-700">Profile</a>
                <a href="LogoutServlet" class="bg-red-600 px-4 py-2 rounded hover:bg-red-700">Logout</a>
            </div>
        </header>

        <div class="chat-container mt-4">
            <div class="sidebar flex flex-col h-full border-r bg-white">
                <div class="p-4 border-b flex justify-between items-center">
                    <h2 class="text-lg font-semibold">Conversations</h2>
                    <button onclick="showUserModal()" class="bg-blue-600 text-white px-2 py-1 rounded hover:bg-blue-700">New</button>
                </div>
                <div class="p-2">
    <input type="text" placeholder="Search conversations..." onkeyup="filterConversations(this.value)"
        class="w-full px-2 py-1 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
</div>
                <div id="conversationList" class="flex-1 overflow-y-auto">
                    <div class="p-4 text-gray-500">Loading conversations...</div>
                </div>
            </div>

            <div class="chat-area">
                <div class="chat-header flex items-center justify-between">
                    <h2 id="chatWith" class="text-lg font-semibold">Select a conversation</h2>
                    <select id="languageSelect" class="language-select">
                        <option value="en">English</option>
                        <option value="vi">Tiếng Việt</option>
                    </select>
                </div>
                <div class="messages" id="messageArea">
                    <div class="p-4 text-gray-500">Select a conversation to start</div>
                </div>
                <div class="input-area flex items-center">
                    <input type="text" id="messageInput" class="flex-1 border rounded-l-lg p-2 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Type a message..." />
                    <button onclick="sendMessage()" class="bg-green-600 text-white px-4 py-2 rounded-r-lg hover:bg-green-700">Send</button>
                </div>
            </div>
        </div>

        <div id="userModal" class="modal">
            <div class="modal-content">
                <h2 class="text-xl font-semibold text-green-700 mb-4">Start New Conversation</h2>
                <input type="text" placeholder="Search users..." onkeyup="filterUsers(this.value)"
    class="w-full mb-3 px-2 py-1 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
                <div id="userList" class="max-h-60 overflow-y-auto">
                    <div class="p-2 text-gray-500">Loading users...</div>
                </div>
                <button onclick="closeUserModal()" class="mt-4 bg-gray-400 text-white px-4 py-2 rounded">Close</button>
            </div>
        </div>

        <script>
            const userId = <%=(userId != null) ? userId : "null"%>;

            if (userId === null) {
                alert("User ID not available. Redirecting...");
                window.location.href = 'login.jsp';
            }
            let selectedUserId = null;
            const languageSelect = document.getElementById('languageSelect');

            if (!userId || userId === 0) {
                alert('User ID not found. Please log in again.');
                window.location.href = 'login.jsp';
            }

            // Load conversations
           document.addEventListener('DOMContentLoaded', function () {
    console.log('DOM fully loaded, initiating loads for userId:', userId);
    loadConversations();
});

function loadConversations() {
    console.log('Loading conversations for userId:', userId);
    fetch('<%= request.getContextPath()%>/MessageServlet?action=listConversations&userId=' + userId)
        .then(response => {
            if (!response.ok) {
                console.error('Fetch error (conversations):', response.status, response.statusText);
                return response.text();
            }
            return response.json();
        })
        .then(data => {
            console.log('Conversations data received:', data);
            const conversationList = document.getElementById('conversationList');
            if (!conversationList) {
                console.error('Conversation list element not found');
                return;
            }

            conversationList.innerHTML = ''; // Clear existing content
            if (typeof data === 'string' || (data && data.error)) {
                conversationList.innerHTML = '<div class="p-2 text-red-500">Error: ' + (data.error || data.substring(0, 100)) + '...</div>';
                return;
            }

            if (!Array.isArray(data)) {
                conversationList.innerHTML = '<div class="p-2 text-red-500">Error: Invalid data format</div>';
                console.error('Data is not an array:', data);
                return;
            }

            if (data.length === 0) {
                conversationList.innerHTML = '<div class="p-4 text-gray-500">No conversations yet</div>';
                return;
            }

            data.forEach(conv => {
                console.log('Processing conversation:', conv);
                const div = document.createElement('div');
                div.className = 'conversation flex justify-between items-center p-2 hover:bg-gray-100 cursor-pointer text-sm';
                div.style.minHeight = '40px';
                div.style.borderBottom = '1px solid #e5e7eb';
                div.style.backgroundColor = 'white'; // Ensure visible background

                const username = conv.otherUsername || 'Unknown User';
                const unreadBadge = conv.unreadCount > 0
                    ? `<span class="unread-badge">${conv.unreadCount}</span>`
                    : '';

                const usernameSpan = document.createElement('span');
                usernameSpan.className = 'username-text truncate';
                usernameSpan.textContent = username;
                div.appendChild(usernameSpan);

const statusSpan = document.createElement('span');
statusSpan.className = 'text-xs text-gray-500 ml-2';
statusSpan.textContent = conv.unreadCount > 0 ? 'Unseen' : 'Seen';
div.appendChild(statusSpan);

                if (unreadBadge) {
                    const badgeSpan = document.createElement('span');
                    badgeSpan.innerHTML = unreadBadge;
                    div.appendChild(badgeSpan);
                }

                div.addEventListener('click', () => {
                    selectConversation(conv.otherUserId, conv.otherUsername);
                });

                conversationList.appendChild(div);
            });
        })
        .catch(error => {
            console.error('Error loading conversations:', error);
            const conversationList = document.getElementById('conversationList');
            if (conversationList) {
                conversationList.innerHTML = '<div class="p-2 text-red-500">Failed to load: ' + error.message + '</div>';
            }
        });
}

            // Load users for new conversation
            function loadUsers() {
                console.log('Loading users for userId:', userId);
                fetch('<%= request.getContextPath()%>/MessageServlet?action=listUsers&userId=' + userId)
                        .then(response => {
                            if (!response.ok) {
                                console.error('Fetch error (users):', response.status, response.statusText);
                                return response.text();
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Users data:', data);
                            const userList = document.getElementById('userList');
                            userList.innerHTML = '';
                            if (typeof data === 'string' || (data && data.error)) {
                                userList.innerHTML = '<div class="p-2 text-red-500">Error: ' + (data.error || data.substring(0, 100)) + '...</div>';
                                return;
                            }
                            if (!Array.isArray(data)) {
                                userList.innerHTML = '<div class="p-2 text-red-500">Error: Invalid data format</div>';
                                return;
                            }
                            if (data.length === 0) {
                                userList.innerHTML = '<div class="p-4 text-gray-500">No users available</div>';
                            } else {
                                data.forEach(user => {
                                    if (user.userId !== userId) {
                                        userList.innerHTML += `
                <div class="p-2 border-b cursor-pointer hover:bg-gray-100" onclick="startConversation(\${user.userId}, '\${user.username}')">
                    \${user.username}
                </div>
            `;
                                    }
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error loading users:', error);
                            document.getElementById('userList').innerHTML = '<div class="p-2 text-red-500">Failed to load: ' + error.message + '</div>';
                        });
            }

            // Select a conversation
            function selectConversation(otherUserId, username) {
                selectedUserId = otherUserId;
                document.getElementById('chatWith').textContent = 'Chat with ' + username;
                loadMessages();
                markMessagesAsRead();
            }

            // Start a new conversation
            function startConversation(otherUserId, username) {
                selectedUserId = otherUserId;
                document.getElementById('chatWith').textContent = 'Chat with ' + username;
                document.getElementById('messageArea').innerHTML = '';
                document.getElementById('userModal').style.display = 'none';
                loadMessages();
            }

            // Load messages for the selected conversation
            function loadMessages() {
                if (!selectedUserId)
                    return;

                console.log('Loading messages for userId:', userId, 'and selectedUserId:', selectedUserId);

                fetch('<%= request.getContextPath()%>/MessageServlet?action=getMessages&userId=' + userId + '&otherUserId=' + selectedUserId)
                        .then(response => {
                            if (!response.ok) {
                                console.error('Fetch error (messages):', response.status, response.statusText);
                                return response.text();
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Messages data:', data);
                            const messageArea = document.getElementById('messageArea');
                            messageArea.innerHTML = '';

                            if (typeof data === 'string' || (data && data.error)) {
                                messageArea.innerHTML = '<div class="p-2 text-red-500">Error: ' + (data.error || data.substring(0, 100)) + '...</div>';
                                return;
                            }

                            if (!Array.isArray(data) || data.length === 0) {
                                messageArea.innerHTML = '<div class="p-4 text-gray-500">No messages yet</div>';
                                return;
                            }

                            data.forEach(msg => {
                                const isSent = Number(msg.senderId) === Number(userId);
                                const sentDate = new Date(msg.sentTime.replace(' ', 'T'));

                                const wrapper = document.createElement('div');
                                wrapper.className = isSent ? 'flex justify-end mb-2' : 'flex justify-start mb-2';

                                const bubble = document.createElement('div');
                                bubble.className = isSent ? 'sent-bubble' : 'received-bubble';

                                const contentDiv = document.createElement('div');
                                contentDiv.textContent = msg.content;

                                const timeDiv = document.createElement('div');
                                timeDiv.className = 'time-stamp';
                                timeDiv.textContent = sentDate.toLocaleTimeString([], {hour: '2-digit', minute: '2-digit'});

                                bubble.appendChild(contentDiv);
                                bubble.appendChild(timeDiv);
                                wrapper.appendChild(bubble);
                                messageArea.appendChild(wrapper);
                            });

                            messageArea.scrollTop = messageArea.scrollHeight;
                        })
                        .catch(error => {
                            console.error('Error loading messages:', error);
                            document.getElementById('messageArea').innerHTML = '<div class="p-2 text-red-500">Failed to load: ' + error.message + '</div>';
                        });
            }

            // Send a message
            function sendMessage() {
                if (!selectedUserId) {
                    alert('Please select a conversation first.');
                    return;
                }
                const content = document.getElementById('messageInput').value.trim();
                const language = languageSelect.value;
                if (content) {
                    console.log('Sending message:', {action: 'sendMessage', senderId: userId, receiverId: selectedUserId, content, language});
                    fetch('<%= request.getContextPath()%>/MessageServlet', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({action: 'sendMessage', senderId: userId, receiverId: selectedUserId, content: content, language: language})
                    })
                            .then(response => response.json())
                            .then(data => {
                                console.log('Send message response:', data);
                                if (data.status === 'Message sent') {
                                    document.getElementById('messageInput').value = '';
                                    loadMessages();
                                } else {
                                    alert('Failed to send message: ' + (data.error || 'Unknown error'));
                                }
                            })
                            .catch(error => console.error('Error sending message:', error));
                }
            }

            // Mark messages as read
            function markMessagesAsRead() {
                if (!selectedUserId)
                    return;
                console.log('Marking messages as read for userId:', userId, 'and selectedUserId:', selectedUserId);
                fetch('<%= request.getContextPath()%>/MessageServlet?action=markAsRead&userId=' + userId + '&otherUserId=' + selectedUserId)
                        .then(response => response.json())
                        .then(data => console.log('Mark as read response:', data))
                        .catch(error => console.error('Error marking messages as read:', error));
            }

            // Show user modal
            function showUserModal() {
                console.log('Showing user modal for userId:', userId);
                document.getElementById('userModal').style.display = 'flex';
                loadUsers();
            }

            // Close user modal
            function closeUserModal() {
                document.getElementById('userModal').style.display = 'none';
            }

            // Poll for updates
            setInterval(loadMessages, 5000);
            setInterval(loadConversations, 5000);

            // Initial load
            document.addEventListener('DOMContentLoaded', function () {
                console.log('DOM fully loaded, initiating loads for userId:', userId);
                loadConversations();
                // showUserModal(); // Uncomment to test modal on load
            });
            function filterConversations(keyword) {
    keyword = keyword.toLowerCase();
    const list = document.querySelectorAll('#conversationList .conversation');
    list.forEach(item => {
        const name = item.querySelector('.username-text')?.textContent.toLowerCase() || '';
        item.style.display = name.includes(keyword) ? 'flex' : 'none';
    });
}

function filterUsers(keyword) {
    keyword = keyword.toLowerCase();
    const list = document.querySelectorAll('#userList > div');
    list.forEach(item => {
        const name = item.textContent.toLowerCase();
        item.style.display = name.includes(keyword) ? 'block' : 'none';
    });
}
        </script>
    </body>
</html>