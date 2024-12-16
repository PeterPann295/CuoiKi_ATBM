<%--
  Created by IntelliJ IDEA.
  User: Tấn Lộc
  Date: 16/12/2024
  Time: 06:37 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<script>
    $(document).ready(function() {
        $('.btn-minus').click(function() {
            var orderItemId = $(this).data('orderitem-id');
            updateQuantity(orderItemId, 'minus');
        });

    });
</script>
<%@ include file="/layouts/footer.jsp"%>
</body>
</html>
