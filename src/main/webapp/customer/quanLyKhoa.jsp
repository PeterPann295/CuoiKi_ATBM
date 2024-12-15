
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="keyPairModelDao" class="database.KeyPairModelDao" />
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
    <h2 class="text-success text">Quản lý khóa:</h2>
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

        <li class="nav-item" role="presentation">
            <a class="a" href="../customer?action=importNewKeyPairs&id=${customer_login.id}"> <button type="button" class="btn btn-success ">
                Nhập khóa mới</button></a>
        </li>

        <li class="nav-item ml-2" style="margin-left: 5px" role="presentation">
            <a class="a " href="../customer?action=createNewKeyPair&id=${customer_login.id}"> <button type="button" class="btn btn-primary ">
                Tạo khóa mới (Auto)</button></a>
        </li>

        <li class="nav-item ml-2" style="margin-left: 5px" role="presentation">
            <a class="a " href="../customer?action=requireRevokeKey&id=${customer_login.id}"> <button type="button" class="btn btn-warning">
                T/b Khóa bị lộ</button></a>
        </li>

    </ul>

    <div class="col-md-12">
        <div class="card card-plain">

            <div class="card-body">

                <div class="table-responsive">

                    <table class="styled-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Public Key</th>
                            <th>Status</th>
                            <th>Created At</th>
                            <th>Revoked At</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${keyPairModelDao.selectAllByCustomerId(customer_login.id)}" var="p">
                            <tr>
                                <td class="text-center align-middle"><b>${p.id}</b></td>
                                <td class="text-center align-middle">
                                    <textarea id="publicKey" rows="4" cols="50" readonly>${p.publicKey}</textarea>
                                </td>
                                <td class="text-center align-middle">
                                    <b style="color: ${p.status == 'active' ? 'green' : 'red'};">${p.status}</b>
                                </td>
                                <td class="text-center align-middle"><fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy hh:mm:ss" /></td>
                                <td class="text-center align-middle"><fmt:formatDate value="${p.revokedAt}" pattern="dd/MM/yyyy hh:mm:ss" /></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>

            </div>

        </div>



    </div>
</div>



</body>
</html>
