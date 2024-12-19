<%--
  Created by IntelliJ IDEA.
  User: Tấn Lộc
  Date: 19/12/2024
  Time: 11:20 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đặt hàng</title>
    <%@ include file="/layouts/common.jsp"%>
    <link rel="stylesheet" type="text/css" href="/assets/css/dangKi.css">
</head>
<body>
<%@ include file="/layouts/header.jsp"%>

<div class="container_form">
    <form class="form-container" action="" method="post" style="margin-top: 60px">
        <h1 class="text-center text-success">
            Xác Nhận Chinh Sua Đơn Hàng
            <a href="#" class="logo-link">
                <img style="width: 80px;
                    height: 80px" src="/assets/images/rau.png" alt="Logo"
                    class="logo-image"
                >
            </a>
        </h1>
        <b> Chúc mừng bạn đã chỉnh sửa đơn hàng thành công
            <a class="link-warning" href="<c:url value='../trangChu.jsp'/>">
                Quay về trang chủ !
            </a>
        </b>
    </form>
</div>
<footer style="margin-top: 140px">
    <%@ include file="/layouts/footer.jsp"%>
</footer>
</body>
</html>
