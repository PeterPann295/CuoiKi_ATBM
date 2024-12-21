<%--
  Created by IntelliJ IDEA.
  User: Tấn Lộc
  Date: 16/12/2024
  Time: 06:37 SA
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<body>
<%@ include file="/layouts/header.jsp"%>

<div class="container_form">
    <form class="form-container" action="../customer?action=confirmEditOrder" method="post">
        <table class="table">
            <tr>
                <th colspan="2" style="text-align: center;">
                    <h3 class="text-success">Chi Tiết Đơn Hàng  </h3>
                </th>
            </tr>
            <tr>
                <td> Người Đặt Hàng: </td>
                <td> ${orderDetail.customer.fullName}</td>
            </tr>
            <tr>
                <td>Tên Người Nhận Hàng: </td>
                <td>
                    <input
                            type="text" class="form-control"  name="toName"
                            value="${orderDetail.toName}"
                            required="required"
                    >
                </td>
            </tr>
            <tr>
                <td> Số Điện Thoại: </td>
                <td>
                    <input
                            type="text" class="form-control"  name="numberPhone"
                            value="${orderDetail.numberPhone}"
                            required="required"
                    >
                </td>
            </tr>
            <tr>
                <td> Địa chỉ nhận hàng: </td>
                <td>
                    <input
                            type="text" class="form-control"  name="address"
                            value="${orderDetail.to_address}"
                            required="required"
                    >
                </td>
            </tr>
            <tr>
                <td>Sản Phẩm:</td>
                <td>
                    <c:forEach var="p" items="${orderDetail.orderItems}">
                        <div id="order-item-${p.id}" style="display: flex; align-items: center; margin-bottom: 10px;">
                            <!-- Hình ảnh sản phẩm -->
                            <img style="width: 40px; height: 40px; margin-right: 10px;" src="${p.product.imageUrl}" alt="Logo">

                            <!-- Tên sản phẩm -->
                            <b class="product-name" style="margin-right: 10px; font-size: 12px;">
                                    ${p.product.name}
                            </b>

                            <!-- Nhóm nút giảm, tăng, số lượng -->
                            <div class="btn-group" style="margin-left: 10px;">
                                <button style="height: 40px;" type="button" value="${p.product.id}" data-orderitem-id="${p.id}" class="btn-minus btn btn-info btn-sm">
                                    <i class="bi bi-dash icon"></i>
                                </button>
                                <input type="text" style="width: 50px; text-align: center;" class="form-control input-sm"
                                       id="quantity-${p.id}" name="quantity-${p.product.id}"
                                       value="${p.quantity}" readonly
                                       max="${importProduct.selectToTalProductInStock(p.product.id)}"
                                >
                                <button style="height: 40px;"
                                        type="button" class="btn-plus btn btn-info btn-sm"
                                        value="${p.id}" data-orderitem-id="${p.id}"
                                >
                                    <i class="bi bi-plus icon"></i>
                                </button>
                            </div>

                            <!-- Nút xóa -->
                            <button style="background: red"
                                    style="height: 40px; margin-left: 10px;" type="button"
                                    class="btn-remove btn btn-danger btn-sm" value="${p.id}"
                                    data-orderitem-id="${p.id}"
                            >
                                <i style="color: white" class="bi bi-trash icon"></i>
                            </button>
                        </div>
                    </c:forEach>
                </td>

            </tr>
            <tr>
                <td> Lưu ý: </td>
                <td>
                    <input
                            type="text" class="form-control"  name="note"
                            value="${orderDetail.note}"
                            required="required"
                    >
                </td>
            </tr>
            <tr>
                <td> Tình Trạng Đơn Hàng: </td>
                <b>
                    <td> ${orderDetail.status.name} </td>
                </b>
            </tr>
            <tr>
                <td> Ngày đặt hàng: </td>
                <td>
                    <fmt:formatDate value="${orderDetail.date}" pattern="dd/MM/yyyy" />
                </td>
            </tr>
            <tr>
                <td> Ngày giao hàng dự kiến: </td>
                <td>
                    <fmt:formatDate value="${orderDetail.deliveryDate}" pattern="dd/MM/yyyy" />
                </td>
            </tr>
            <tr>
                <td>Mã voucher:</td>
                <td> ${orderDetail.voucher.code} </td>
            </tr>

            <tr>
                <td>
                    <h6> Tổng tiền sản phẩm: </h6>
                </td>
                <td>
                    <b id="price-product">
                        <fmt:formatNumber
                            value="${orderDetail.priceProduct()}"
                            type="currency"
                            currencyCode="VND" minFractionDigits="0"
                        />
                    </b>
                </td>
            </tr>
            <tr>
                <td>
                    <h6> Phí vận chuyển: </h6>
                </td>
                <td>
                    <b>
                        <fmt:formatNumber
                                value="${orderDetail.deliveryFee}" type="currency"
                                currencyCode="VND" minFractionDigits="0"
                        />
                    </b>
                </td>
            </tr>
            <tr>
                <td>
                    <h6>Số tiền giảm giá: </h6>
                </td>
                <td>
                    <c:if test="${orderDetail.voucher == null}">0đ</c:if>
                    <c:if test="${orderDetail.voucher != null}">
                        <fmt:formatNumber
                                value="${orderDetail.voucher.discount}" type="currency"
                                currencyCode="VND" minFractionDigits="0"
                        />
                    </c:if>
                </td>
            </tr>
            <tr>
                <td>
                    <h5> Tổng tiền thanh toán: </h5>
                </td>
                <td id="totalPrice" style="font-weight: bolder" >
                    <b id="price-total">
                        <fmt:formatNumber
                                value="${orderDetail.total}" type="currency"
                                currencyCode="VND" minFractionDigits="0"
                        />
                    </b>
                </td>
            </tr>
            <tr>
                <td>Phương thức thanh toán: </td>
                <td>
                    ${orderDetail.paymentMethod.name}
                </td>
            </tr>
        </table>
        <button type="submit" class="btn btn-primary" style="width: 100%;">
            Xác nhận chỉnh sửa đơn hàng
        </button>
    </form>
</div>

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
