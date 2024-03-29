<%@ page contentType="text/html;charset=UTF-8"%>
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
							<h1 class="m-0">문의목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">고객센터> 문의목록</li>
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
					                <h3 class="card-title"></h3>


									<div class="card-tools">
										<div class="input-group mb-1">
											<input type="text" class="form-control" placeholder="제목으로 검색"
												id="keyword">
											<button class="btn btn-outline-primary" type="button"
												id="bt_search">검색</button>
										</div>
									</div>
								</div>
					                
					                
					            </div>
					            <!-- /.card-header -->
					            <div class="card-body table-responsive p-0">
					                <table class="table table-hover text-nowrap">
					                    <thead>
					                        <tr>
					                            <th>No</th>
					                            <th>카테고리</th>
					                            <th>제목</th>
					                            <th>날짜</th>
					                        </tr>
					                    </thead>
					                    <tbody>
											<!-- template는 자체로는 아무런 효과가 없고, 그냥 뷰의 영역임을 지정한다 -->
											<template v-for="(inquiry, i) in currentList">
												<inquiry :key="inquiry.inquiry_idx" :num="num-i" :obj="inquiry" />
					                       	</template>
					                       	<tr>
					                       		<td id="paging-area" colspan="5" style="text-align:center"></td>
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
		let pager = new Pager(); //인스턴스 생성
		let currentPage=1; //현재 보고있는 페이지
		
		let app1;
		let key=0;
		
		const inquiry={
			template:`
                <tr>
	                <td>{{n}}</td>
	                <td>{{json.inquiry_category.inquiry_category_name}}</td>
	                <td @click="getDetail(obj.inquiry_idx)"><a href="#">{{json.title}}</a></td>
	                <td>{{json.regdate.substring(0, 10)}}</td>
                </tr>
			`,
			props:["obj", "num"], //props 오직 외부에서 전달되는 데이터 받기 위함
			data(){ //자바로 비유하면 인스턴스 변수영역
				return{
					json:this.obj,
					n:this.num
				};
			},
			methods:{
				getDetail:function(inquiry_idx){
					location.href="/admin/inquiry/detail?inquiry_idx="+inquiry_idx;
				}
			}
		};
		
		app1=new Vue({
			el:"#app1",
			components:{
				inquiry
			},
			data:{
				count:5,
				inquiryList:[], //전체배열
				currentList:[], //페이지당 보여질 배열
				num:0 //페이지당 시작 번호를 뷰 컴포넌트에서 접근할 수 있도록...
			},
			
		});
		
		function pageLink(n) {
			//서버에서 가져온 데이터를 대상으로 페이징 로직을 적용해보기
			pager.init(app1.inquiryList, n);
			
			console.log("totalRecord=", pager.totalRecord);
			console.log("pageSize=", pager.pageSize);
			console.log("totalPage=", pager.totalPage);
			console.log("blockSize=", pager.blockSize);
			console.log("currentPage=", pager.currentPage);
			console.log("firstPage=", pager.firstPage);
			console.log("lastPage=", pager.lastPage);
			console.log("curPos=", pager.curPos);
			console.log("num=", pager.num);
			
			app1.num=pager.num;
			
			//넘겨받은 페이지 번호를 이용하여, 해당 페이지에 보여질 배열을 생성 후
			//currentList 에 대입(Vue의 변수인 currentList 만 제어하면 디자인은 자동으로 변경)
			
			app1.currentList.splice(0, app1.currentList.length);//싹 비우고...
			
			for(let i=pager.curPos; i<pager.curPos+pager.pageSize;i++){
				//num이 1보다 작아지면 멈춤
				if(pager.num<1)break;
				pager.num--;
				
				//전체 배열에서, 일부 배열로 옮겨 심기
				app1.currentList.push(app1.inquiryList[i]);
			}
		}
		
		//서버에서 상품목록 가져오기
		function getList() {
			$.ajax({
				url:"/admin/rest/inquiry",
				type:"get",
				success:function(result, status, xhr){
					//서버에서 가져온 json 배열을 뷰의 템플릿이 바라보고 있는 inquiryList 에 대입만하면
					//디자인은 알아서 변경된다...(개발자는 데이터 제어에만 집중하면 됨...디자인 신경꺼라)
					app1.inquiryList = result;
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
		
		function search() {
			app1.currentList.splice(0,app1.currentList.length);
			let keyword=$("#keyword").val();
			$.ajax({
				url:"/rest/searchInquiry?title="+keyword,
				type:"get",
				success:function(result, status, xhr){
					console.log(result);
					app1.currentList=result;
					
				}
			});
		}
		
		$(function(){			
			//등록 이벤트 연결 
			$("#bt_regist").click(function(){
				regist();
			});
			
			$("#bt_search").click(function(){
				search();
			});
			
			getList();
			
		});
	
	</script>
</body>
</html>