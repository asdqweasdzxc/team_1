<%@page import="team1.project.bookshop.domain.Member"%>
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
							<h1 class="m-0">회원목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/admin/main">Home</a></li>
								<li class="breadcrumb-item active">회원관리 > 회원목록</li>
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
						<div class="col-9">
						    <div class="card">
						        <!-- /.card-header -->
						        <div class="card-body table-responsive p-0">
						            <table class="table text-nowrap">
						                <tbody>
											<tr>
												<td colspan="2">
									        		<div class="form-group row">
									        			<div class="col-sm-9">
										                    <input type="text" id="search_member" class="form-control" placeholder="이름으로 사용자 검색">
									        			</div>
									        			<div class="col-sm-3">
										                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
									        			</div>
									        		</div>
												</td>
											</tr>						                
						                </tbody>
						            </table>
						            <table class="table">
									    <thead class="thead-light">
									      <tr>
									        <th>No</th>
									        <th>아이디</th>
									        <th>이름</th>
									        <th>생성일</th>
									        <th>SNS</th>
									      </tr>
									    </thead>
									    <tbody>
										  <template v-for="(member, i) in currentList">
											<member :key="member.member_idx" :num="num-i" :obj="member" />
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
	
	<!-- ./wrapper -->
	<%@ include file="../inc/footer_link.jsp" %>
	
	<script type="text/javascript" src="/resources/js/Pager.js"></script>
	<script type="text/javascript">
	let pager = new Pager(); //인스턴스 생성
	let currentPage=1; //현재 보고있는 페이지
	
	let app1;
	let key=0;
	
	const member={
			template:`
				<tr>
				  <td>{{n}}</td>
				  <td>{{json.id.substring(0,20)}}</td>
				  <td>{{json.name}}</td>
				  <td>{{json.create_date.substring(0,10)}}</td>
				  <td><span class="tag tag-success">{{json.sns.sns_name}}</span></td>
				 </tr>
			`,
			props:["obj", "num"], //props는 오직 외부에서 전달되는 데이터 받기 위함
			data(){ //자바로 비유하면 인스턴스 변수 영역
				return{
					json:this.obj,
					n:this.num
				};
			}
		};
	
	app1=new Vue({
		el:"#app1",
		components:{
			member
		},
		data:{
			count:5,
			memberList:[], //전체 배열
			currentList:[], //페이지당 보여질 배열
			num:0 //페이지당 시작 번호를 뷰 컴포넌트에서 접근할 수 있도록..
		}
	});
	
	function pageLink(n){
		//서버에서 가져온 데이터를 대상으로 페이징 로직을 적용해보기
		pager.init(app1.memberList, n);
		
		console.log("totalRecord : ", pager.totalRecord);
		console.log("pageSize : ", pager.pageSize);
		console.log("totalPage : ", pager.totalPage);
		console.log("blockSize : ", pager.blockSize);
		console.log("currentPage(n) : ", n);
		console.log("firstPage : ", pager.firstPage);
		console.log("lastPage : ", pager.lastPage);
		console.log("curPos : ", pager.curPos);
		console.log("num : ", pager.num);
		
		app1.num=pager.num;
		
		app1.currentList.splice(0, app1.currentList.length)
		
		for(let i=pager.curPos; i<pager.curPos+pager.pageSize;i++){
			//num이 1보다 작아지면 멈춤
			if(pager.num<1) break;
			pager.num--;
			//전체 배열에서, 일부 배열로 옮겨 심기
			app1.currentList.push(app1.memberList[i]);
		}
	}
	
	//서버에서 상품목록 가져오기
	function getList(){
		$.ajax({
			url:"/admin/rest/member",
			type:"get",
			success:function(result, status, xhr){
				app1.memberList = result;
				console.log(result);
				pageLink(currentPage); //페이징 처리 계산 수행
				
				//넘버링 출력
				for(let i=pager.firstPage; i<=pager.lastPage;i++){
					if(i > pager.totalPage)break; //내가 가진 페이지수를 넘어서면 반복문 빠져나오기
					$("#paging-area").append("<a href='javascript:pageLink("+i+")' style='margin:3px'>"+i+"</a>");
				}
				
			}
		});
	}
	
	function search(){
		search_member
		let keyword=$("#search_member").val();
		
		$.ajax({
			url:"/admin/rest/member/search",
			type:"post",
			data:{keyword:keyword},
			success:function(result, status, xhr){
				app1.memberList = result;
				console.log(result);
				pageLink(currentPage); //페이징 처리 계산 수행
				
				$("#paging-area").remove();
				//넘버링 출력
				for(let i=pager.firstPage; i<=pager.lastPage;i++){
					if(i > pager.totalPage)break; //내가 가진 페이지수를 넘어서면 반복문 빠져나오기
					$("#paging-area").append("<a href='javascript:pageLink("+i+")' style='margin:3px'>"+i+"</a>");
				}
				
			}
		});
	}
	
	$(function(){
		$("#bt_search").click(function(){
			search();
		});
		getList();
	});
	</script>
</body>
</html>





