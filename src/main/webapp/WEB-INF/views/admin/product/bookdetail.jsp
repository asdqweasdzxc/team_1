<%@page import="team1.project.bookshop.domain.Book"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Book book = (Book)request.getAttribute("book");
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
				
				<div class="container-flueid">
					<div class="row">
						<div class="col">
	
							<div class="card card-success">
								<div class="card-header">
									<h1 class="card-title"><%=book.getBook_name() %></h1>
								</div>
								<div class="card-body">
									<div class="container-fluid">
										<div class="row">
											<div class="col-4">
												<label>글쓴이:</label><br>
												<input class="form-control" type="text" placeholder="Default input" value="<%=book.getWriter() %>">
											</div>
											<div class="col-2"></div>
											<div class="col-4">
												<label>출판사:</label><br>
												<input class="form-control" type="text" placeholder="Default input" value="<%=book.getPublisher()%>">
											</div>
										</div> 
										
										
										<div class="row mt-5">
											<div class="col-4">
												<label>가격:</label><br>
												<input class="form-control" type="text" placeholder="Default input" value="<%=book.getPrice()%>">
											</div>
											<div class="col-4">
												<label>할인가:</label><br>
												<input class="form-control" type="text" placeholder="Default input" value="<%=book.getDiscount()%>">
											</div>
											<div class="col-4">
												<label>적립포인트:</label><br>
												<input class="form-control" type="text" placeholder="Default input" value="<%=book.getPoint()%>">
											</div>
										</div>
									
									
									<div class="row mt-5">
										<div class="col-6">
											<label>요약:</label><br>
											<textarea class="col-12" cols="12" rows="10" ><%=book.getSummary() %></textarea>
										</div>
										<div class="col-6 text-left">
											<img src="/resources/data/<%=book.getFilename()%>" height="90%" width="90%">
										</div>
										<input type="file">
									</div>
								
									<div class="row mt-5">
										<div class="col-12">
											<input type="hidden" id="book_type" value="<%=book.getBookType().getBookType_idx()%>">
											<select id="booktype" name="booktype">
												<option>책종류</option>
												<option value="1">online</option>
												<option value="2">offline</option>
											</select>
										</div>
									</div>
									<input type="hidden" value="<%=book.getBook_idx()%>" id="idx">
									<div class="row mt-5">
									
										<div class="col-4 text-right">
										</div>
										
										<div class="col-4 text-center">
											<button type="button" class="btn btn-info" >수정</button>
											<button type="button" class="btn btn-danger" id="bt_delete">삭제</button>
											<button type="button" class="btn btn-success" id="bt_list">목록</button>
										</div>
										
										<div class="col-4 text-left">
										</div>
										
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
	
	<script type="text/javascript">
	
	function selectOption(){
		let num = $("#book_type").val();
		if(num==1){
			$("#booktype").val('1').prop("selected", true);
		}else if(num==2){
			$("#booktype").val('2').prop("selected", true);
		}else{	
			$("#booktype").val('1').prop("selected", false);
			$("#booktype").val('2').prop("selected", false);
		}
	}
	
	
	$(function(){
		selectOption();
		
		$("#bt_list").click(function(){
			location.href="/admin/book/registform";
		});
		
		$("#bt_delete").click(function(){
			if(confirm("삭제하실거에오?")){
				let idx = $("#idx").val();
				location.href="/admin/deletebook?book_idx="+idx;
			}
		});
		
	});
	
	
	</script>
</body>
</html>









