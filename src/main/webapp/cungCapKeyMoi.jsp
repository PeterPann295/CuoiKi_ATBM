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
    <form action="customer?action=login" id="form-login"  method="post" class="form-container">
        <h1 class="text-center mb-3 text-success ">
            Luu Key <a href="#" class="logo-link"> <img
                style="width: 60px; height: 60px" src="assets/images/rau.png" alt="Logo"
                class="logo-image">
        </a>
        </h1>

        <p style="text-align: center; color: red">${register_success}</p>
        <label for="publicKey">Public Key: </label>
        <div style="text-align: center">
            <textarea id="publicKey" rows="4" cols="50" readonly>
                ${publicKey}
            </textarea>
        </div>

        <!-- Liên kết tải Private Key -->
        <label >Private Key: </label>
        <div style="text-align: center">
            <a href="downloadPrivateKey?fileName=${privateKeyFilePath}" class="btn btn-success mt-3">Tải Private Key</a>
        </div>


    </form>
</div>