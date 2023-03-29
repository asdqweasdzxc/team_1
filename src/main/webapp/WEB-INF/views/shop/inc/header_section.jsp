<%@page import="team1.project.bookshop.domain.Inquiry_category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
	<%
		//카테고리 목록 가져오기
		List<Inquiry_category> inquiry_categoryList=(List)request.getAttribute("inquiry_categoryList");
	%>
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="/"><img src="/resources/shop/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="./index.html">Home</a></li>
                            <%for(int i=0;i<inquiry_categoryList.size();i++){ %>
                            <%Inquiry_category inquiry_category=inquiry_categoryList.get(i);%>
                            <li><a href="#"><%=inquiry_category.getInquiry_category_name() %></a></li>
                            <%} %>
                            
                            <li><a href="/book/search">도서검색</a></li>
                            <li><a href="#">고객센터</a>
                                <ul class="dropdown">
                                    <li><a href="./product-details.html">상품문의</a></li>
                                    <li><a href="./shop-cart.html">1:1문의</a></li>
                                    <li><a href="./checkout.html">공지사항</a></li>      
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                            <a href="/member/loginform">Login</a>
                            <a href="/member/joinform">Register</a>
                        </div>
                        <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <li>
 
                            	<a href="/payment/cartlist.jsp">
                            		<span class="icon_bag_alt"></span>
                                	<div class="tip">2</div>
                                </a>
                                
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>