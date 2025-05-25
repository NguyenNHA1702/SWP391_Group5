<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Campaign" %>
<%
    Campaign campaign = (Campaign) request.getAttribute("campaign");
    if (campaign == null) {
        response.sendRedirect("farmer-dashboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>Edit Campaign</title>
</head>
<body>
    <h2>Edit Campaign: <%= campaign.getTitle() %></h2>
    <form action="EditCampaignServlet" method="post">
        <input type="hidden" name="campaignId" value="<%= campaign.getId() %>">
        Title: <input type="text" name="title" value="<%= campaign.getTitle() %>" required><br>
        Description: <textarea name="description"><%= campaign.getDescription() %></textarea><br>
        Goal Amount: <input type="number" name="goalAmount" value="<%= campaign.getGoalAmount() %>" required><br>
        End Date: <input type="date" name="endDate" value="<%= campaign.getEndDate().toString().substring(0,10) %>" required><br>
        <input type="submit" value="Update Campaign">
    </form>
</body>
</html>
