
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="orderDao" class="database.OrderDao" />
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Lịch sử mua hàng</title>
    <%@ include file="/layouts/common.jsp"%>
    <style type="text/css">
        .size {
            width: 100px;
            height: 100px;
        }

        .icon {
            color: white;
            width: 40px;
            height: 40px;
        }

        .text {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .a{
            text-decoration: none;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }

        table th, table td {
            border: 2px solid #ddd; /* Đường viền đậm */
            padding: 8px;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2; /* Màu nền xen kẽ */
        }



        table th {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }
    </style>
</head>
<body>
<%@ include file="/layouts/header.jsp"%>
<div class="container">
    <h2 class="text-success text">Lịch Sử Mua Hàng:</h2>
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=0"><button class="nav-link active" id="all-orders" data-bs-toggle="pill"  type="button" role="tab" aria-controls="all-orders" aria-selected="false">Tất cả đơn hàng  </button></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=1"><button class="nav-link" id="pending-orders" data-bs-toggle="pill" type="button" role="tab" aria-controls="pending-orders" aria-selected="true"> Chờ xác nhận  </button></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=2"> <button class="nav-link" id="box-orders" data-bs-toggle="pill"  type="button" role="tab" aria-controls="delivered-orders" aria-selected="false"> Chờ đóng gói  </button></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=3"> <button class="nav-link" id="delivery-orders" data-bs-toggle="pill" type="button" role="tab" aria-controls="cancelled-orders" aria-selected="false"> Chờ giao hàng </button></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=4"> <button class="nav-link" id="delivering-orders" data-bs-toggle="pill"  type="button" role="tab" aria-controls="cancelled-orders" aria-selected="false"> Đã giao </button> </a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=getOrderStatus&status=5"><button class="nav-link" id="cancelled-orders" data-bs-toggle="pill" type="button" role="tab" aria-controls="cancelled-orders" aria-selected="false"> Đã hủy </button></a>
        </li>
    </ul>
    <h4 class="text">
        <span> ${emtyOrder} </span>
    </h4>
    <div class="col-md-12">
        <div class="card card-plain">

            <div class="card-body">

                <div class="table-responsive">

                    <table class="styled-table">
                        <tr>

                            <th class="text-center">Mã Đơn Hàng</th>
                            <th class="text-center">Sản Phẩm</th>
                            <th class="text-center">Ngày Đặt</th>
                            <th class="text-center">Ngày Giao Hàng Dự Kiến</th>
                            <th class="text-center">Tình Trạng</th>
                            <th class="text-center">Tổng Tiền</th>
                            <th></th>

                        </tr>

                        <c:forEach items="${orderDao.selectByCustomerId(customer_login.id)}" var="p">
                            <tr>

                                <td class="text-center align-middle"> <b> ${p.id} </b> </td>
                                <td class="text-center"><c:forEach items="${p.orderItems}" var="c">

                                    <p>
                                        <img style="width: 40px; height: 40px"
                                             src="${c.product.imageUrl}" alt="Logo">
                                        <b>${c.product.name}</b>
                                    </p>

                                </c:forEach></td>
                                <td class="text-center align-middle"><fmt:formatDate value="${p.date}" pattern="dd/MM/yyyy" /></td>
                                <td class="text-center align-middle"><fmt:formatDate value="${p.deliveryDate}" pattern="dd/MM/yyyy" /></td>
                                <td class="text-center align-middle"> ${p.status.name} </td>
                                <td class="text-center align-middle"><b><fmt:formatNumber value="${p.total}"
                                                                                          type="currency" currencyCode="VND" minFractionDigits="0"/></b></td>
                                <td class="text-center align-middle"> <a class="a" href="../customer?action=detailOrder&orderId=${p.id}"><button class="btn btn-success"> Chi tiết </button></a> <c:if test="${p.status.id < 3}">
                                    <a class="a" href="../customer?action=updateOrder&status=5&orderId=${p.id}"><button class="btn btn-success"> Hủy </button></a>
                                </c:if> <c:if test="${p.status.id == 3}">
                                    <a class="a" href="../customer?action=updateOrder&status=4&orderId=${p.id}"><button class="btn btn-success"> Đã nhận hàng </button></a>

                                </c:if> </td>
                            </tr>

                        </c:forEach>
                    </table>

                </div>

            </div>

        </div>



    </div>
</div>


</body>
</html>
