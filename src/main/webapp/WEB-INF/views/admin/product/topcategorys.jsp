<%@page import="team1.project.bookshop.domain.BookTopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>

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
							<h1 class="m-0">상위카테고리</h1>
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
						<div class="col-3">
							<div class="card card-success">
								<div class="card-header">
									<h3 class="card-title">상위 카테고리 목록</h3>
								</div>
									<table class="table" id="app1">
										<thead>
											<tr>
												<th>카테고리명</th>
											</tr>
										</thead>
										<tbody>
											<template v-for="category in topList">
												<topcategory :key="category.bookTopCategory_idx" :obj="category"/>
											</template>
										</tbody>
									</table>	
							</div>
						</div>
						<div class="col-9">
							<div class="card card-success">
								<div class="card-header">
									<h3 class="card-title">상위 카테고리 등록</h3>
								</div>
								
								<div class="container">
									<div class="row">
										<div class="col-6">
											<form id="form1">
												<div class="card-body">
													<input type="text" class="form-control" placeholder="새 최상위 카테고리" name="bookTopCategory_name">
												</div>
											</form>
										</div>
										<div class="col-3 mt-3">
											<button type="button" class="btn btn-primary" id="bt_regist">등록</button>
											
										</div>
										<div class="col-3 mt-3">
										</div>
									</div>
								</div>
								<!-- /.card-body -->
							</div>
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
	
	const topcategory ={
		template:`
			
				<tr>
					<td><a :href="link">{{name}}</a></td>
				</tr>
	
		`,
		props:["obj"],
		data(){
			return{
				topcategory:this.obj,
				link:"javascript:del("+this.obj.bookTopCategory_idx+")",
				name:this.obj.bookTopCategory_name
			}
		}
		
	}
	
	function del(bookTopCategory_idx) {
		if(!confirm("삭제할거야?")){
			return;
		}
		
		$.ajax({
			url:"/admin/rest/topcategory/del?bookTopCategory_idx="+bookTopCategory_idx,
			type:"GET",
			success: function(result, status, xhr){
				console.log(result);	
				getList();
			}
		});
		
		
	
	}
	
	function regist() {
	
	let formData = $("#form1").serialize();
		$.ajax({
			url : "/admin/rest/topcategory",
			type : "POST",
			data : formData,
			success : function(result, status, xhr) {
				console.log(result);
				getList();
			}
		});
	}

	function search() {
		alert("찾기");
		let formData = $("#form1").serialize();

		$("#form1").attr({
			action : "/admin/searchtopcategory",
			method : "POST"
		});
		$("#form1").submit();
	}
	
	
	
	function getList(){
		$.ajax({
			url:"/admin/rest/topcategory/list",
			type:"GET",
			success:function(result, status, xhr){
				app1.topList=result;
			}
		});
	}

	function init(){
		app1 = new Vue({
			el:"#app1",
			components:{
				topcategory
			},
			data:{
				topList:[]
			}		
		});
	}
	
	
	
	$(function() {
		init();
		getList();
		
		$("#bt_regist").click(function() {
			regist();
		});
		$("#bt_search").click(function() {
			search();
		});
	});
</script>
</html>









