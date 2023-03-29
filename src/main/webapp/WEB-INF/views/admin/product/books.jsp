<%@page import="team1.project.bookshop.domain.Book"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List bookList = (List)request.getAttribute("bookList"); 
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
							<h1 class="m-0">Main</h1>
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
						<div class="col">
							<form id="form1">
								<div id="app1">
									<select name="bookSubCategory.bookTopCategory.bookTopCategory_idx" id="t_category">
										<option>상위 카테고리선택</option>
										<template v-for="BookTopCategory in topcategoryList" >
											<row v-bind:value="BookTopCategory['bookTopCategory_idx']" v-bind:book_top_category_name="BookTopCategory['bookTopCategory_name']"></row>
										</template>
									</select>
								</div>
								<div id="app2">
									<select name="bookSubCategory.bookSubCategory_idx" id="s_category">
										<option>하위 카테고리 선택</option>
										<template v-for="BookSubCategory in subcategoryList" >
											<row2 :value="BookSubCategory['bookSubCategory_idx']" v-bind:book_sub_category_name="BookSubCategory['bookSubCategory_name']"></row>
										</template>
									</select>
								</div>
								<select name="bookType.bookType_idx">
									<option>책의 종류 선택</option>
									<option value="1">online</option>
									<option value="2">offline</option>
								</select> 
								<input type="hidden" class="form-control" placeholder="책이름"
									name="admin_name">
			
								<div class="container">
									<div class="row">
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="책이름"
													name="book_name">
											</div>
										</div>
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="저자"
													name="writer">
											</div>
										</div>
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="출판사"
													name="publisher">
											</div>
										</div>
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="가격"
													name="price">
											</div>
										</div>
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="할인가"
													name="discount">
											</div>
										</div>
										<div class="col-2">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="적립포인트"
													name="point">
											</div>
										</div>
			
									</div>
								</div>
			
								<textarea class="form-control" placeholder="책 정보" name="summary"></textarea>
								<input type="file" name="myfile"/>
								
								<div class="text-center">								
									<button type="button" class="btn btn-primary" id="bt_regist">등록</button>
								</div>
			
							</form>
						
						</div>
					</div>
				</div>
			
				<div class="card card-info">
					<div class="card-header">
	               		<h3 class="card-title">등록된 도서 목록</h3>
	             	</div>
				<div class="card-body">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>상위카테고리</th>
								<th>하위카테고리</th>
								<th>책이름</th>
								<th>저자</th>
								<th>출판사</th>
								<th>등록일</th>
								<th>등록자</th>
								<th>가격</th>
								<th>할인액</th>
								<th>적립될 포인트</th>
								<th>책 종류</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (int i = 0; i < bookList.size(); i++) {
								Book book = (Book) bookList.get(i);
							%>
							<tr data-widget="expandable-table" aria-expanded="false">
								<td><%=book.getBookSubCategory().getBookTopCategory().getBookTopCategory_name()%></td>
								<td><%=book.getBookSubCategory().getBookSubCategory_name()%></td>
								<td><%=book.getBook_name()%></td>
								<td><%=book.getWriter()%></td>
								<td><%=book.getPublisher()%></td>
								<td><%=book.getCreate_date()%></td>
								<td><%=book.getAdmin_name()%></td>
								<td><%=book.getPrice()%></td>
								<td><%=book.getDiscount()%></td>
								<td><%=book.getPoint()%></td>
								<td><%=book.getBookType().getType() %></td>
							</tr>	
							<tr class="expandable-body">
								<td colspan="12">
									<p><%=book.getSummary() %></p>
									<div class="text-center">
										<button type="button" class="btn btn-primary flex"  onclick="getDetail(<%=book.getBook_idx()%>)">상세</button>
									</div>
								</td>
							</tr>
							<%} %>
						</tbody>
					</table>
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
	let file;
	let app1;
	let app2;
	
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
	
	const Row2={
			template:
				`	
					<option>{{s_name}}</option>		
				`,
				props:['book_sub_category_idx','book_sub_category_name'],
				data(){
					return{
						s_idx:this.bookSubCategory_idx,
						s_name:this.book_sub_category_name
					};
				}
			
	}
	
	
	function regist() {
		
		//보내기 전에 new FormData() 해서 append 해서  data에 담아 보내 file.file 할수있도록
		//ex)let json=app1.imageList[i]; json = 선택한 파일
		//		formData.append("photo", json.file); json.file 은 file.file과 같다.
		let formData =new FormData();
		
		formData.append("admin_name", $("input[name='admin_name']").val());
		formData.append("book_name", $("input[name='book_name']").val());
		formData.append("writer", $("input[name='writer']").val());
		formData.append("publisher", $("input[name='publisher']").val());
		formData.append("price", $("input[name='price']").val());
		formData.append("discount", $("input[name='discount']").val());
		formData.append("point", $("input[name='point']").val());
		formData.append("myfile", file);
		
		
		
		
		$("#form1").attr({
			action:"/admin/bookregist",
			method:"POST",
			enctype:"multipart/form-data"
		});
		$("#form1").submit();
	}
	
	function getDetail(idx) {
		location.href="/admin/book/detail?book_idx="+idx
	}
	
	
	
	
	
	
	
	
	function init(){
		app1= new Vue({
			el:"#app1",
			components:{
				"row":Row
			},
			data:{
				topcategoryList:[]
			}
		});
		
		app2=new Vue({
			el:"#app2",
			components:{
				"row2":Row2
			},
			data:{
				subcategoryList:[]
			}
		});
		getTopCategoryList();
	}
	
	
	function getTopCategoryList() {
		
		$.ajax({
			url:"/admin/rest/topcategorylist/get",
			type:"GET",
			success:function(result, status, xhr){
				console.log(result);
				app1.topcategoryList=result;
			}
		});
	}
	
	function getSubCategoryList(topidx){
		
		$.ajax({
			url:"/admin/rest/subcategory/get?book_top_category_idx="+topidx,
			type:"GET",
			success:function(result, status, xhr){
				
				console.log(result);
				app2.subcategoryList=result;
			}
		});
	}
	
	$(function() {
		init();
		$("input[name='myfile']").change(function(){
			console.log(this.files[0]);
			file=this.files[0];
		});
		
		$("#bt_regist").click(function(){
			regist();
		});
		
		$("#s_category").click(function(){
			let topidx = $("#t_category").val();
			getSubCategoryList(topidx);
		});
		
		$("#t_category").click(function(){
			app2.subcategoryList="";
		});
	});


</script>
</html>









