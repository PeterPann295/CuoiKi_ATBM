<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <%@ include file="layouts/common.jsp" %>
    <link rel="stylesheet" type="text/css" href="assets/css/dangNhap.css">
    <script src="assets/javascript/facebookAPI.js"></script>
</head>
<body>
<%@ include file="layouts/header.jsp" %>

<div class="container_form content">
    <form action="customer?action=confirmRevokeKey" id="form-reset-password"  method="post" class="form-container">
        <h1 class="text-center mb-3 text-success ">
            Xác thực mã xác nhận <a href="#" class="logo-link"> <img
                style="width: 60px; height: 60px" src="assets/images/rau.png" alt="Logo"
                class="logo-image">
        </a>
        </h1>
        <div class="text-danger mb-3">${error_resetCode}</div>
        <div class="form-group mb-2">
            <label class="margin-label" for="resetCode">Nhập Mã Xác Nhận :</label> <input
                type="text" class="form-control" id="resetCode" name="resetCode"
                placeholder="Nhập mã xác nhận" required>
            <div id="error-username" style="color: red"></div>
        </div>
        <button type="submit" id="btn-submit" class="btn btn-primary" style="width: 100%;"> Xác Nhận </button>
        </button>
    </form>
</div>

</body

<footer>
    <%@ include file="layouts/footer.jsp" %>
</footer>
</html>