<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng kí tài khoản</title>
    <%@ include file="/layouts/common.jsp"%>
    <script src="assets/javascript/dangKi.js"></script>
    <link rel="stylesheet" type="text/css" href="/assets/css/dangKi.css">
    <style>
        /* CSS cơ bản */
        .dropdown {
            margin: 10px 0;
        }
    </style>
</head>
<body>
<%@ include file="/layouts/header.jsp"%>
<div class="container_form">
    <form id="form_register" class="form-container" action="../customer?action=confirmSignature" method="post">
        <h1 class="text-center text-success">
            Xác thực chữ kí điện tử: <a href="#" class="logo-link"> <img
                style="width: 80px; height: 80px" src="/assets/images/rau.png" alt="Logo"
                class="logo-image">
        </a>
        </h1>
        <p style="color: red; text-align: center">Vui lòng tạo chữ kí với văn bản dưới đây để xác nhận đặt hàng</p>
        <p style="color: red; text-align: center">${error_signature}</p>

    <%--        <div class="mb-3">--%>
<%--            <label for="hash" class="form-label">Mã Hash Đơn Hàng</label>--%>
<%--            <textarea id="hash" rows="4" cols="50" readonly>--%>
<%--            ${hash_code}--%>
<%--        </textarea>--%>
<%--        </div>--%>
        <div class="mb-3">
            <label for="hash" class="form-label">Mã Hash Đơn Hàng:
            </label>
            <textarea type="text" class="form-control" id="hash"
                      name="hash_code" readonly rows="5"
                      cols="50"> ${hash_code} </textarea>

        </div>
<%--        <div class="mb-3">--%>
<%--            <label  class="form-label">Tải xuống mã hash</label>--%>
<%--            <a href="../downloadHashCode?fileName=${hashCodeFile}" class="btn btn-success mt-3">Tải Private Key</a>--%>
<%--            --%>
<%--        </div>--%>
        <div class="mb-3">
            <label for="digital_signature" class="form-label">Nhập chữ kí điện tử:
            </label>
            <textarea type="text" class="form-control" id="digital_signature"
                      name="digital_signature" placeholder="Nhập chữ kí điện tử " rows="5"
                      cols="50"> </textarea>

        </div>
        <button type="submit" id="btn-submit" class="btn btn-primary" style="width: 100%;">Xác Nhận Chữ Kí</button>
    </form>
</div>
<%@ include file="/layouts/footer.jsp"%>
</body>
</html>
