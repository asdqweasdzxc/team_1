<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="team1.project.bookshop.domain.BookTopCategory"%>
<%@page import="team1.project.bookshop.domain.BookSubCategory"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List list = (List)request.getAttribute("subcategoryList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Dashboard</title>
<%@ include file="../inc/header_link.jsp"%>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<%@ include file="../inc/preloader.jsp" %>
		
		<!-- Navbar -->
		<%@ include file="../inc/navbar.jsp" %>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<%@ include file="../inc/sidebar_left.jsp" %>
		
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">하위카테고리</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Dashboard v1</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<section class="content">
				<div class="container">
					<div class="row">
						<div class="col-6">
							
								<div class="container">
									<div class="row">
										<div class="col">
											<div class="card card-warning">
												<div class="card-header">
													<h3 class="card-title">하위 카테고리 목록</h3>
												</div>
	
												<table class="table table-striped">
													<tbody>
														<%	
															for (int i = 0; i < list.size(); i++) {
															BookSubCategory subcategory = (BookSubCategory) list.get(i);
														%>
														<tr>
															<td><%=subcategory.getBookSubCategory_name()%></td>
														</tr>
														<%
															}
														%>
													</tbody>
												</table>

											</div>

										</div>
									</div>
								</div>
						</div>
						<div class="col-6">
						<form id="form1">
							<div class="card card-warning">
								<div class="card-header">
									<h3 class="card-title">하위 카테고리 설정</h3>
								</div>
								<div class="card-body" id = "app1">
									<select name="bookTopCategory.bookTopCategory_idx" id="selectBox" class="form-control select2bs4">
										<option>상위카테고리 선택</option>
										<template v-for="BookTopCategory in categoryList" >
											<row v-bind:value="BookTopCategory['bookTopCategory_idx']" v-bind:book_top_category_name="BookTopCategory['bookTopCategory_name']"></row>
										</template>
									</select>
									<div class="input-group mb-3">
										<input type="text" class="form-control" placeholder="새 하위 카테고리" name="bookSubCategory_name">
										<div class="input-group-prepend">
											<button class="btn btn-outline-primary" type="button" id="bt_regist">등록</button>
										</div>
									</div>
								</div>
								<!-- /.card-body -->
							</div>

						</form>
						</div>
					</div>
				</div>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		
		<%@ include file="../inc/footer.jsp" %>		

		<!-- Control Sidebar -->
		<%@ include file="../inc/sidebar_right.jsp" %>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	<%@ include file="../inc/footer_link.jsp" %>
</body>
<script type="text/javascript">
let app1;


const Row={
		template:
			`	
			
				<option >{{name}}</option>		
			`,
			props:['book_top_category_idx','book_top_category_name'],
			data(){
				return{
					idx:this.bookTopCategory_idx,
					name:this.book_top_category_name
				};
			}
			
}

function init() {
	app1 = new Vue({
		el:"#app1",
		components:{
			"row":Row
		},
		data:{
			categoryList:[],
			name:"SH"
		}
	});
}


function regist() {
	let formData = $("#form1").serialize();

		$.ajax({
			url : "/admin/rest/subcategory",
			type : "POST",
			data : formData,
			success : function(result, status, xhr) {
				console.log(result);
			}
		});
	}
function getTopCategory(){
	$.ajax({
		url:"/admin/rest/topcategory/list",
		type:"GET",
		success:function(result, status, xhr){
			console.log(result);
			app1.categoryList=result;
		}
	});
	
}
	$(function() {
		init();
		
		$("#selectBox").click(function(){
			getTopCategory();
		});
		
		$("#bt_regist").click(function() {
			regist();
		});
	});
</script>
</html>









