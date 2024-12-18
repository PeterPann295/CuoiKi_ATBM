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
        $('.btn-remove').click(function (){
            var orderItemId = $(this).data('orderitem-id');
            $.ajax({
                url: '../customer?action=removeOrderItem',
                method: 'POST',
                data: {
                    orderItem: orderItemId,
                },
                success: function(response) {
                    if(response.success){
                        $('#order-item-' + orderItemId).remove();
                        var formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.priceProduct);
                        var formattedPriceTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalPrice);

                        $('#price-product').text(formattedPrice);
                        $('#price-total').text(formattedPriceTotal);

                    }
                },
            });
        });
        // Lắng nghe sự kiện click của nút "btn-plus"
        $('.btn-plus').click(function() {
            var orderItemId = $(this).data('orderitem-id');
            updateQuantity(orderItemId, 'plus');
        });
        function updateQuantity(orderItemId, doing) {

        }
    });
</script>
<%@ include file="/layouts/footer.jsp"%>
</body>
</html>
