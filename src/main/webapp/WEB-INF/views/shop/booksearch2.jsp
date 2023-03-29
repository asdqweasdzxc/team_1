<%@page import="team1.project.bookshop.domain.Book"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%! 
List list; 
String con = "min";
Book book;
%>
<%
	list = (List)request.getAttribute("bookList");
book = (Book)list.get(0);


%>

<!DOCTYPE html>
<html lang="zxx">

<head>
<%@ include file="./inc/header.jsp" %>
</head>

<body>
    <!-- Page Preloder -->
	<%@ include file="./inc/preloader.jsp" %>

    <!-- Offcanvas Menu Begin -->
    <!-- 
    	jsp자체에서 지원하는 태그 
     	왜 써야 하나? 사실 jsp는 디자인 영역이므로, 개발자만 사용하는 것이
     	아니라 퍼블리셔, 웹디자이너와 공유를 한다..이때  java 에 대한 
     	非전문가들은 java 코드를 이해할 수 없기 때문에, 그들이 좀더 쉽게
     	다가갈 수 있도록 태그를 지원해준다 ( 협업 때문에 )
     -->
	<%@ include file="./inc/main_navi.jsp"%>    
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <%@ include file="./inc/header_section.jsp"%>
    <!-- Header Section End -->

	<section class="content">
	
		<div class="mt-5">
			
			
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="input-group mb-3">
							<input type="text" class="form-control" placeholder="제목또는 저자로 검색" id="keyword">
							<div class="input-group-prepend">
								<button class="btn btn-outline-primary" type="button" id="bt_search">검색</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		</div>

		<div class="container mt-5">
			<div class="row">
				<div class="col-lg-3 col-md-3">
					<%@ include file="./inc/sidebar2.jsp" %>	
				</div>
				<div class="col-9" id="app1">
					
					<div class="row" >
						<!-- row당 3개의 상품이 들어가야하며 총 9개의 상품을 확인 할 수 있다. -->
						<template v-for="(book, i) in showList">
							<book :key="book.book_idx" :obj="book" />
						</template>
					</div>
					
					<div class="row">
						<div class="col" style="margin: auto;">
							<ul class="pagination" id="pagees" >
								
								
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
    

<!-- Instagram Begin -->
<%@ include file="./inc/insta.jsp" %>
<!-- Instagram End -->

<!-- Footer Section Begin -->
<%@ include file="./inc/footer.jsp" %>
<!-- Footer Section End -->

<!-- Search Begin -->
<%@ include file="./inc/search.jsp" %>
<!-- Search End -->

<!-- Js Plugins -->
<%@ include file="./inc/footer_link.jsp" %>
<script src="/resources/js/Pager.js"></script>
<script type="text/javascript">
	let list;
	let app1; //상품출력
	let app2; //사이드바 상위카테고리
	let app3; //사이드바 하위 카테고리
	
	let pager = new Pager();
	let currentPage = 1;
	
	const categorys={
			template:`
			<div class="card-heading">
				<a :href="link">{{name}}</a>
			</div>
			`,
			props:["top", "num"],
			data(){
				return{
					name:this.top.bookTopCategory_name,
					link:"javascript:getSub("+this.top.bookTopCategory_idx+")"
					
				}
			}
	}
	
	
	const scategorys={
			template:`
			
				<li><a :href="link">{{name}}</a></li>
			
			`,
			props:["sub"],
			data(){
				return{
					name:this.sub.bookSubCategory_name,
					link:"javascript:searchByCategory("+this.sub.bookSubCategory_idx+")"
				}
			}
			
	}
	
	const book={
		template:`	
			<div class="col-lg-4 col-md-6">
				<div class="product__item">
					<div class="product__item__pic set-bg" data-setbg="/resources/data/" style="img">
						<div class="label new">New</div>
					</div>
					<div class="product__item__text">
						<h6>
							<a :href="link">{{book.book_name}}</a>
						</h6>
						<div class="product__price">{{book.price}}</div>
					</div>
				</div>
			</div>
		`,
		props:["obj", "num", "filename"],
		data(){
			return{
				img:"background-image: url('/resources/data"+this.obj.filename+"');",
				book:this.obj,
				ttest:4,
				link:"javascript:getDetail("+this.obj.book_idx+")"
			};
		}
		
	}
	
	
	
	function getList(){	
		$.ajax({
			url:"/rest/book/list",
			type:"GET",
			success:function(result, status, xhr){
				app1.bookList=result;
				pageLink(currentPage);
				for(let i=pager.firstPage;i<pager.lastPage;i++){	
					$("#pagees").append("<a href='javascript:pageLink("+i+")' style='margin:3px'>"+i+"</a>");
				}
			}
		});
	}
	
	function getSub(n) {	
		if(app3.ssList!=null){
			
		 	app3.ssList="";
		}
		
		$.ajax({
			url:"/rest/booksubcategory/selectlist?bookTopCategory_idx="+n,
			type:"GET",
			success:function(result, status, xhr){
			
				app3.ssList=result;
			
				if($("#name")!=null){					
					$("#name").remove();
				}
				$("#selectCategory").append("<div id='name'><h5>"+app3.ssList[0].bookTopCategory.bookTopCategory_name+"</h5><div>")
			}
		});
	}
	
	function getCategoryList(){
		$.ajax({
			url:"/rest/booksubcategory",
			type:"GET",
			success:function(result, status, xhr){
				app2.subList=result;
				for(let i=0;i<app2.subList.length;i++){
					if(app2.topList.length==0){
						app2.topList.push(app2.subList[i].bookTopCategory);
					}else{	
						let size = app2.topList.length;
						let count=0;
						for(let k=0;k<size;k++){
							if(app2.topList[k].bookTopCategory_name==app2.subList[i].bookTopCategory.bookTopCategory_name){
								count++;
							}
						}
						if(count==0){
							app2.topList.push(app2.subList[i].bookTopCategory);
						}
					
					}
					
					
				}
			}
		});
	}
	
	function searchByCategory(n) {
		//bookSubCategory_idx
		
		
		app1.bookList.splice(0,app1.bookList.length);
		
		$.ajax({
			url:"/rest/book/search/subcategory?bookSubCategory_idx="+n,
			type:"GET",
			success:function(result, status, xhr){
				console.log(result);
				app1.bookList=result;
				
				pageLink(1);
			}
		});
	}
	
	
	
	
	function init(){
		
		
		app1 = new Vue({
			el:"#app1",
			components:{
				book
			},
			data:{
				bookList:[],
				showList:[],
				num:0,
				count:9
			}
		});
		
		
		app2 = new Vue({
			el:"#app2",
			components:{
				categorys
			},
			data:{
				subList:[],
				topList:[],
				count:3
			}
		});
		
		
		app3 = new Vue({
			el:"#app3",
			components:{
				scategorys
			},
			data:{
				ssList:[]
			}
		});
		
		
		
		
	}
	
	function pageLink(n){
		//n=currentpage
		pager.init(app1.bookList, n);
		
		app1.num=pager.num;
		app1.showList.splice(0,app1.showList.length);
		
		for(let i=pager.curPos;i<pager.curPos+pager.pageSize;i++){
			if(1>pager.num)break;
			console.log("3");
			pager.num--;
			app1.showList.push(app1.bookList[i]);
		}
		
	}
	

	function searching() {
		
		let keyword = $("#keyword").val();
		
		app1.bookList.splice(0,app1.bookList.length);
		$.ajax({
			url:"/rest/search/word?book_name="+keyword,
			type:"GET",
			success:function(result, status, xhr){
				console.log("2");
				app1.bookList=result;
				
				pageLink(1);
			}
		});
	}
	
	function getDetail(idx) {
		location.href="/bookdetail?book_idx="+idx;
	}
	
	$(function(){
		init();
		getList();
		getCategoryList();
		getSub(1);
		
		
		$("#bt_search").click(function(){
			console.log("1");
			searching();
		});
		
	});
</script>
</body>

</html>