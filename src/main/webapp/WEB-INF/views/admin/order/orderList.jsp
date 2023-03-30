<%@page import="team1.project.bookshop.domain.Orders"%>
<%@page import="team1.project.bookshop.domain.Book"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard</title>
<%@ include file="../inc/header_link.jsp" %>
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
  <%@ include file="../inc/sidebar_left.jsp"%>
  
	<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">상품등록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">상품관리> 상품등록</li>
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
					<div class="row">
					    <div class="col-12">
					        <div class="card">
					            <div class="card-header">
					                <h3 class="card-title">Responsive Hover Table</h3>
					                <div class="card-tools">
					                    <div class="input-group input-group-sm" style="width: 150px;">
					                        <input type="text" name="table_search" class="form-control float-right" placeholder="Search">
					                        <div class="input-group-append">
					                            <button type="submit" class="btn btn-default">
					                                <i class="fas fa-search"></i>
					                            </button>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <!-- /.card-header -->
					            <div class="card-body table-responsive p-0">
					            	<table class="table">
										<thead class="thead-dark">
									      <tr>
									        <th>No</th>
									        <th>주문자명</th>
									        <th>주문출발일</th>
									        <th>주문완료일</th>
									        <th>주문금액</th>
									        <th>주문방법</th>
									      </tr>
									    </thead>
									    <tbody>
									      <template v-for="(orders,i) in currentList">
									      	<orders :key="orders.orders_idx" :num="num-i" :obj="orders"/>
									      </template>
									      <tr>
						                    	<td id="paging-area"></td>
						                    </tr>
									    </tbody>
								    </table>
					            </div>
					            <!-- /.card-body -->
					        </div>
					        <!-- /.card -->
					    </div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			<div style="padding:50px;"></div>
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
<script type="text/javascript" src="/resources/js/Pager.js"></script>
<script type="text/javascript">
let app1;
let selectedRow;	// 현재 선택된 Row 컴포넌트
let pager= new Pager();
let currentPage=1;

const orders={
	template:
	`
	<tr>
	  <td>{{n}}</td>
	  <td @click="getDetail(orders.orders_idx)"><a href="#">{{orders.member.name}}</a></td>
	  <td>{{orders.order_date}}</td>
	  <td>{{orders.ship_date}}</td>
	  <td>{{orders.total_pay}}</td>
	  <td>{{orders.pay_method.payment}}</td>
	</tr>
	`
	, props:["obj", "num"]
	, data(){
		return{
			orders:this.obj
			, n:this.num
		};
	}
	, methods:{
		getDetail:function(orders_idx){
			location.href="/admin/order_detail?orders_idx="+orders_idx;
		}
	}
};

function init(){
	app1 = new Vue({
		el:"#app1"
		, components:{
			orders
		}
		, data:{
			ordersList:[]
			, currentList:[]	// 페이지당 보여질 배열
			, num:0				// 페이지당 시작번호를 뷰에서 쓰게 할 수 있도록
		}
	});
	
	getOrdersList();
}

function pageLink(n){
	// 서버에서 가져온 데이터를 대상으로 페이징 로직을 적용해보기
	pager.init(app1.ordersList,n);
	
	app1.num=pager.num;
	
	// 넘겨받은 페이지 번호를 이용하여,  해당 페이지에 보여질 배열을 생성 후 currentList에 대입
	// Vue의 변수인 currentList만 제어하면 디자인은 자동으로 변경
	
	app1.currentList.splice(0,app1.currentList.length);
	
	for(let i=pager.curPos;i<pager.curPos+pager.pageSize;i++){
		// num이 1보다 작아지면 멈춤
		if(pager.num<1) break;
		pager.num--;
		// 전체 배열에서, 일부 배열로 옮겨 심기
		app1.currentList.push(app1.ordersList[i]);
	}
}

function getOrdersList(){
	// 서버에서 비동기로 가져다가, app1의 categoryList에 대입
	$.ajax({
		url:"/admin/rest/ordersList"
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			app1.ordersList = result;
			
			pageLink(currentPage);
			
			for(let i=pager.firstPage;i<=pager.lastPage;i++){
				$("#paging-area").append("<a href='javascript:pageLink("+i+")' style='margin:3px'>"+i+"</a>");
			}
		}
	});
}

$(function(){
	// 비동기로 Orders 목록 가져오기
	init();
});
</script>
</body>
</html>