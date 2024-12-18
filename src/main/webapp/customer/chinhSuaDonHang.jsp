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
    <link rel="stylesheet" type="text/css" href="/assets/css/dangKi.css">
    <style>
        .btn-check-voucher {
            border: none;
            background: #ee4d2d;
            color: white;
            border-radius: 5px
        }
        .product-name {
            display: inline-block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 50px; /* Điều chỉnh độ rộng phù hợp */
        }

    </style>
</head>
<%@ include file="/layouts/header.jsp"%>

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
            $.ajax({
                url: '../customer?action=updateQuantityOnOrder',
                method: 'POST',
                data: {
                    orderItem: orderItemId,
                    update: doing
                },
                success: function(response) {
                    if(response.status == 'update'){
                        // Xử lý phản hồi từ server cho việc cập nhật số lượng
                        // Cập nhật giao diện người dùng nếu cần
                        var formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.priceUpdate);
                        // Cập nhật số lượng hiển thị
                        $('#quantity-'+orderItemId).val(response.quantity);

                        var formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.priceProduct);
                        var formattedPriceTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalPrice);

                        $('#price-product').text(formattedPrice);
                        $('#price-total').text(formattedPriceTotal);
                    }else if(response.status == 'delete'){
                        $('#order-item-' + orderItemId).remove();
                        var formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.priceProduct);
                        var formattedPriceTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalPrice);

                        $('#price-product').text(formattedPrice);
                        $('#price-total').text(formattedPriceTotal);
                    }
                },
            });
        }
    });
</script>
<%@ include file="/layouts/footer.jsp"%>
</body>
</html>
