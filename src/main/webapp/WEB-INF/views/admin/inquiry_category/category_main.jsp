<%@page import="team1.project.bookshop.domain.Inquiry_category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Dashboard</title>
<%@ include file="../inc/header_link.jsp"%>
<style type="text/css">
.box-style{
	width:90px;
	height:95px;
	border:1px solid #ccc;
	display:inline-block;
	margin:5px;
}
.box-style img{
	width:75px;
	height:70px;
}
</style>
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
							<h1 class="m-0">카테고리 관리</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">고객센터> 카테고리등록</li>
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
			<section class="content" id="app1">
				<div class="container-fluid">
				
					<!-- Main row -->
					<div class="row">
					
						<div class="col-7">
						    <div class="card">
						        <!-- /.card-header -->
					        	
					        	
						        <div class="card-body table-responsive p-0">
						            <table class="table table-hover text-nowrap">
						                <tbody>
											<tr>
												<td colspan="2">
									        		<div class="form-group row">
									        			<div class="col-sm-9">
										                    <input type="text" name="inquiry_category_name" class="form-control" placeholder="카테고리 입력">
									        			</div>
									        			<div class="col-sm-3">
										                    <button type="button" class="btn btn-warning" id="bt_regist">등록</button>
									        			</div>
									        		</div>
												</td>
											</tr>	
											
											<template v-for="inquiry_category in inquiry_categoryList">					                
												<row :key="inquiry_category.inquiry_category_idx" :obj="inquiry_category"/>
						                    </template>
						                    
						                </tbody>
						            </table>
						        </div>
						        
						        
						        <!-- /.card-body -->
						    </div>
						    <!-- /.card -->
						</div>					
					
					
						<div class="col-5">
						    <div class="card">
						    
						        <div class="card-body">
						        	<form id="form2">
						        	<input type="hidden" name="_method">
						        	<input type="hidden" name="inquiry_category_idx">
					        		<div class="form-group row">
					        			<div class="col-6">
						                    <input type="text" name="inquiry_category_name" class="form-control" >
					        			</div>
					        			<div class="col-3">
						                    <button type="button" class="btn btn-info" id="bt_edit">수정</button>
					        			</div>
					        			<div class="col-3">
						                    <button type="button" class="btn btn-success" id="bt_del">삭제</button>
					        			</div>
					        		</div>
					        		</form>
						        </div>
						        
						    </div>
						</div>					
					
					
					</div>
					<!-- /.row (main row) -->
				</div>
				
				<!-- /.container-fluid -->
			
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
		let app1;
		let selectedRow; //현재 선택된  Row 컴포넌트 
		
		const row={
			template:`
				<tr>
					<td>{{inquiry_category.inquiry_category_idx}}</td>
					<td @click="getDetail(inquiry_category)"><a href="#">{{inquiry_category.inquiry_category_name}}</a></td>					
				</tr>
			`,
			props:["obj"],
			data(){
				return{
					inquiry_category:this.obj
				};
			},
			methods:{
				getDetail:function(inquiry_category){
					//우측 상세보기 영역에 데이터 출력 
					$("#form2 input[name='inquiry_category_idx']").val(inquiry_category.inquiry_category_idx);//inquiry_category_idx
					$("#form2 input[name='inquiry_category_name']").val(inquiry_category.inquiry_category_name);//inquiry_category_name
					
					console.log(this);
					selectedRow=this;
				}
			}
			
		};
		
		app1=new Vue({
			el:"#app1",
			components:{
				row
			},
			data:{
				count:5,
				inquiry_categoryList:[]
			}
		});
		
		/*------------------------------------------
		등록
		------------------------------------------*/
		function regist(){
			$.ajax({
				url:"/bookshop/admin/rest/inquiry_category",
				type:"post",
				data:{
					inquiry_category_name:$("input[name='inquiry_category_name']").val()
				}, 
				//서버로부터 전송된 HTTP 응답 헤더 정보가 성공일때 반응
				success:function(result, status, xhr){
					alert(result.msg); // {code:,  msg:"성공"}
					getCategoryList();
				},
				
				//서버로부터 전송된 HTTP 응답 헤더 정보가 실패일때 반응
				error:function(xhr, status, err){
					alert("에러에요"+err);
				}
				
			});			
		}
		
		
		function getCategoryList(){
			//서버에서 비동기로 가져다가,  app1의  categoryList 에 대입 
			$.ajax({
				url:"/bookshop/admin/rest/inquiry_category",
				type:"get",
				success:function(result, status, xhr){
					app1.inquiry_categoryList = result;										
				}
			});			
		}
		
		//동기방식의 수정 요청 
		//html의 form 태그는 GET/POST 만 지원...
		function edit(){
			//히든에 들어있는  _method 값을  PUT으로 놓자 
			$("#form2 input[name='_method']").val("PUT");
			
			$("#form2").attr({
				action:"/bookshop/admin/inquiry_category/edit",
				method:"POST"
			});
			$("#form2").submit();
		}
		
		
		//비동기방식의 수정 요청 
		function editAsync(){
			if(!confirm("수정하시겠습니까?")){
				return;
			}
			
			//전송 데이터를 ajax의 형식으로 전송 
			let json={};
			json['inquiry_category_idx']=$("#form2 input[name='inquiry_category_idx']").val();
			json['inquiry_category_name']=$("#form2 input[name='inquiry_category_name']").val();
			
			$.ajax({
				url:"/bookshop/admin/rest/inquiry_category",
				type:"PUT",
				contentType:"application/json;charset=utf-8", /*header 정보구성*/
				//웹상의 데이터 교환시 데이터형식은 무조건, 문자열이 되어야 한다..
				//따라서 자바스크립트 내장객체인 json 자체는 전송대상이 될수 없다. 
				//해결책: 문자열화 시키되 개발자가 일일이 수작업으로 하지말고, JSON.stringify()이용
				data:JSON.stringify(json), /*body 정보구성*/
				processData:false, /*query string화 여부*/
				success:function(result, status, xhr){
					console.log(result);
					
					//수정된 내용만 컴포넌트에 반영하기 
					selectedRow.inquiry_category=json;					
				},
				error:function(xhr, status, err){
					
				}
			});
			
		}
		
		function delAsync(){
			if(!confirm("삭제하시겠습니까?")){
				return;
			}	
			
			$.ajax({
				url:"/bookshop/admin/rest/inquiry_category/"+$("#form2 input[name='inquiry_category_idx']").val(),
				type:"DELETE",
				success:function(result, status, xhr){
					getCategoryList();
				},
				error:function(xhr, status, err){
					
				}
			});
		}
		
		
		//서머노트 적용하기 
		$(function(){
			
			//비동기로 카테고리 목록 가져오기
			getCategoryList();
			
			//등록 이벤트 연결 
			$("#bt_regist").click(function(){
				regist();
			});
			$("#bt_edit").click(function(){
				//edit(); //동기
				editAsync(); //비동기
			});
			$("#bt_del").click(function(){
				delAsync();
			});
			
		});
	
	</script>
</body>
</html>