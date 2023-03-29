<%@page import="team1.project.bookshop.domain.Book"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%
	Book book = (Book)request.getAttribute("book");
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


    <!-- Categories Section Begin -->
  
<!-- Categories Section End -->

<!-- Product Section Begin -->


	<div class="container mt-5">
		<div class="row">
			
			<div class="col-lg-12 col-me-3">
				<div class="container">
					<div class="row">
						<div class="col-6">
						<img  src="/resources/data/<%=book.getFilename()%>">
							
						</div>
						<div class="col-6">
							<div class="product__details__text">
								<div>
									<input type="hidden" id="book_idx">
								</div>
								<div>
									<h3><%=book.getBook_name() %></h3>
								</div>
								<div class="product__details__price">
									<%=book.getDiscount() %>원 <span><%=book.getPrice() %></span>
								</div>
								<p><%=book.getSummary() %></p>
								<div class="product__details__button">
									
									<a href="#" class="cart-btn"><span class="icon_bag_alt"></span>장바구니에 담기</a>
								
								</div>
								<div class="product__details__widget">
									<ul>
										<li><span>Available color:</span>
											<div class="color__checkbox">
												<label for="red"> <input type="radio"
													name="color__radio" id="red" checked> <span
													class="checkmark"></span>
												</label> <label for="black"> <input type="radio"
													name="color__radio" id="black"> <span
													class="checkmark black-bg"></span>
												</label> <label for="grey"> <input type="radio"
													name="color__radio" id="grey"> <span
													class="checkmark grey-bg"></span>
												</label>
											</div></li>
										<li><span>Available size:</span>
											<div class="size__btn">
												<label for="xs-btn" class="active"> <input
													type="radio" id="xs-btn"> xs
												</label> <label for="s-btn"> <input type="radio" id="s-btn">
													s
												</label> <label for="m-btn"> <input type="radio" id="m-btn">
													m
												</label> <label for="l-btn"> <input type="radio" id="l-btn">
													l
												</label>
											</div></li>
										<li><span>Promotions:</span>
											<p>Free shipping</p></li>
										<li><span>Type:</span>
												<div >
													<label><%=book.getBookType().getType() %></label>
												</div></li>
									</ul>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
				

<!-- Product Section End -->

<!-- Banner Section Begin -->

<!-- Banner Section End -->

<!-- Trend Section Begin -->

<!-- Trend Section End -->

<!-- Discount Section Begin -->

<!-- Discount Section End -->

<!-- Services Section Begin -->

<!-- Services Section End -->

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
</body>
<script type="text/javascript">


</script>

</html>