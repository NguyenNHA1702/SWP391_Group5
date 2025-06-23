<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    model.Product product = (model.Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
    </head>
    <body>
        <h2>Edit Product</h2>

        <!-- ✅ Form gửi đi có cả productId và campaignId -->
        <form method="post" action="${pageContext.request.contextPath}/edit">
            <input type="hidden" name="productId" value="<%= product.getProductId() %>" />
            <input type="hidden" name="campaignId" value="<%= product.getCampaignId() %>" />


            Name: <input type="text" name="name" value="<%= product.getName() %>" /><br/>
            Description: <input type="text" name="description" value="<%= product.getDescription() %>" /><br/>
            Price: <input type="number" name="price" value="<%= product.getPrice() %>" /><br/>
            Quantity: <input type="number" name="quantity" value="<%= product.getQuantity() %>" /><br/>
            Language: 
            <select name="language">
                <option value="vi" <%= "vi".equals(product.getLanguage()) ? "selected" : "" %>>Vietnamese</option>
                <option value="en" <%= "en".equals(product.getLanguage()) ? "selected" : "" %>>English</option>
            </select><br/>

            <button type="submit">Save</button>
        </form>

        <!-- ✅ Quay về inventory theo campaignId -->
        <a href="${pageContext.request.contextPath}/farmer/inventory?campaignId=<%= product.getCampaignId() %>">Back</a>
    </body>
</html>
