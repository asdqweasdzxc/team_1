<%@page import="team1.project.bookshop.domain.Ship_condition"%>
<%@page import="team1.project.bookshop.domain.Orders"%>
<%@page import="team1.project.bookshop.domain.Book"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<Ship_condition> ship_conditionList = (List)request.getAttribute("ship_conditionList");
%>
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

.content img{
	width:105px;
	height:100px;
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
									      	<th>표지</th>
		                                    <th>책명</th>
		                                    <th>가격</th>
		                                    <th>주문개수</th>
		                                    <th>총합</th>
									      </tr>
									    </thead>
									    <tbody>
									    	<template v-for="order_detail in order_detailList">
		                                		<order_detail :key="order_detail.order_detail_idx" :obj="order_detail"/>
		                                	</template>
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
			<div style="padding:40px;"></div>
			<!-- /.content -->
			
			<!-- 세부사항 -->
			<div class="container">
			  <form id="form1">
			    <div class="form-group">
			      <label>주문자명</label>
			      <input type="text" class="form-control" name="name" readonly>
			    </div>
			    <div class="form-group">
			      <label>주문일자</label>
			      <input type="text" class="form-control" name="order_date" readonly>
			    </div>
			    <div class="form-group">
			      <label>배송일자</label>
			      <input type="text" class="form-control" name="ship_date" readonly>
			    </div>
			    <div class="form-group">
			      <label>주문금액</label>
			      <input type="text" class="form-control" name="total_pay" readonly>
			    </div>
			    <div class="form-group">
			      <label>주문방법</label>
			      <input type="text" class="form-control" name="pay_method" readonly>
			    </div>
			  </form>
			  <form id="form2">
			    <div class="form-group">
			      <label>배송현황(1. 결제완료	2. 배송전		3. 배송중		4. 배송완료)</label>
			      <select name="selected_ship_condition">
			      	<option value="0">배송현황선택</option>
			      	<%for(int i=0;i<ship_conditionList.size();i++){ %>
			      	<%Ship_condition ship_condition = ship_conditionList.get(i);%>
			      	<option value="<%=ship_condition.getShip_condition_idx() %>"><%=ship_condition.getShip_condition_info() %></option>
			      	<%} %>
			      </select>
			      <input type="text" class="form-control" name="ship_condition" readonly>
			    </div>
			    <div class="form-group">
			      <label>송장번호</label>
			      <input type="text" class="form-control" name="invoice_number" readonly>
			    </div>
			  </form>
			</div>
			<!-- /.세부사항 -->
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

const order_detail={
	template:
	`
	<tr>
	    <td class="cart__product__item">
	        <img v-bind:src="'/resources/data/'+orderDetail.book.filename">
	    </td>
        <td class="cart__product__item__title">
            {{orderDetail.book.book_name}}
        </td>
	    <td class="cart__price">{{orderDetail.final_price}}</td>
	    <td class="cart__quantity">{{orderDetail.quantity}}</td>
	    <td class="cart__total">{{orderDetail.final_price*orderDetail.quantity}}</td>
	</tr>
	`
	, props:["obj"]
	, data(){
		return{
			orderDetail:this.obj
		}
	}
};

app1 = new Vue({
	el:"#app1"
	, components:{
		order_detail
	}
	, data:{
		order_detailList:[]
	}
});

function getOrder_detailList(){
	$.ajax({
		url:"/admin/rest/order_detail?orders_idx=2"
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			app1.order_detailList=result;
		}
	});
}

function getOrders(){
	$.ajax({
		url:"/admin/rest/orders?orders_idx=2"
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			$("#form1 input[name='name']").val(result.member.name);
			$("#form1 input[name='order_date']").val(result.order_date);
			$("#form1 input[name='ship_date']").val(result.ship_date);
			$("#form1 input[name='total_pay']").val(result.total_pay);
			$("#form1 input[name='pay_method']").val(result.pay_method.payment);
		}
	});
}

function getShip_condition(){
	$.ajax({
		url:"/admin/rest/current_ship_condition?current_ship_condition_idx=1"
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			$("#form2 input[name='ship_condition']").val(result.ship_condition.ship_condition_info);
			$("#form2 input[name='invoice_number']").val(result.invoice_number);
		}
	});
}

$(function(){
	// 비동기로 Orders 목록 가져오기
	getOrder_detailList();
	getOrders();
	getShip_condition();
	
	// init에서 select의 변경값을 구한다
	$("#form2 select[name='selected_ship_condition']").change(function() {
	    //Use $option (with the "$") to see that the variable is a jQuery object
	    let $option = $(this).find('option:selected');
	    //Added with the EDIT
	    let value = $option.val();//to get content of "value" attrib
	    let text = $option.text();//to get <option>Text</option> content
	    
	    $.ajax({
			url:"/admin/rest/ship_condition?ship_condition_idx="+value
			, type:"put"
			, success:function(result, status, xhr){
				console.log(result);
				$("#form2 input[name='ship_condition']").val(result.ship_condition.ship_condition_info);
			}
		});
	});
});
</script>
</body>
</html>