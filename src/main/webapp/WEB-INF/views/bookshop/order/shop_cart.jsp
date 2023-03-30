<%@page import="java.util.List"%>
<%@page import="team1.project.bookshop.domain.Cart"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="./inc/header.jsp"%>
<%!
	int member_idx=2;
%>
<%
	List cartList = (List)request.getAttribute("cartList");
	out.print(cartList);
%>
</head>
<body>
    <%@ include file="./inc/preloader.jsp" %>

    <!-- Offcanvas Menu Begin -->
    <%@ include file="./inc/main_navi.jsp"%>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <%@ include file="./inc/header_section.jsp"%>
    <!-- Header Section End -->

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <span>Shopping cart</span>
                        <input type="hidden" value="<%=member_idx%>" id="member">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Cart Section Begin -->
    <section class="shop-cart spad" id="app1">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shop__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="cart in cartList">
                                	<cart :key="cart.cart_idx" :obj="cart"/>
                                </template>
                            </tbody>
                            <tbody>
                            <%for(int i=0; i<cartList.size();i++){ %>
                            <%Cart cart = (Cart)cartList.get(i); %>
                                <tr>
								    <td class="cart__product__item">
								        <img src="'/resources/data/'+<%=cart.getBook().getFilename()%>">
								        <div class="cart__product__item__title">
								            <h6><%=cart.getBook().getBook_name() %></h6>
								            <div class="rating">
								                <i class="fa fa-star"></i>
								                <i class="fa fa-star"></i>
								                <i class="fa fa-star"></i>
								                <i class="fa fa-star"></i>
								                <i class="fa fa-star"></i>
								            </div>
								        </div>
								    </td>
								    <td class="cart__price"><%=cart.getBook().getPrice() %></td>
								    <td class="cart__quantity">
									    <div class="pro-qty">
								    	<span class="dec qtybtn">-</span>
								        	<input type="text" name="bookQuantity" min="0" value="<%=cart.getQuantity()%>">
							    		<span class="inc qtybtn">+</span>
								    	</div>
								    </td>
								    <td class="cart__total"><%=cart.getBook().getPrice()*cart.getQuantity() %></td>
								    <td class="cart__close"><span class="icon_close""></span></td>
								</tr>
							<%} %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                </div>
                <div class="col-lg-4 offset-lg-2">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                        <ul>
                            <li>Subtotal <span>$ 750.0</span></li>
                            <li>Total <span>$ 750.0</span></li>
                        </ul>
                        <a href="javascript:shopOrder()" class="primary-btn">Proceed to checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Cart Section End -->

    <!-- Instagram Begin -->
    <%@ include file="./inc/instar.jsp" %>
    <!-- Instagram End -->

    <!-- Footer Section Begin -->
    <%@ include file="./inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Search Begin -->
    <%@ include file="./inc/search.jsp" %>
    <!-- Search End -->

    <!-- Js Plugins -->
    <%@ include file="./inc/footer_link.jsp" %>
<script type="text/javascript">
var clientKey = 'test_ck_D4yKeq5bgrpokQP5OwJVGX0lzW6Y';
var tossPayments = TossPayments(clientKey); 	// 클라이언트 키로 초기화하기

let app1;
let key=0;

const cart={
	template:
	`
	<tr>
	    <td class="cart__product__item">
	        <img v-bind:src="'/resources/data/'+cart.book.filename">
	        <div class="cart__product__item__title">
	            <h6>{{cart.book.book_name}}</h6>
	            <div class="rating">
	                <i class="fa fa-star"></i>
	                <i class="fa fa-star"></i>
	                <i class="fa fa-star"></i>
	                <i class="fa fa-star"></i>
	                <i class="fa fa-star"></i>
	            </div>
	        </div>
	    </td>
	    <td class="cart__price">{{cart.book.price}}</td>
	    <td class="cart__quantity">
		    <div class="pro-qty">
	    	<span @click="valDown()" class="dec qtybtn">-</span>
	        	<input type="text" v-model="ea" name="bookQuantity" min="0" value="1">
    		<span @click="valUp()" class="inc qtybtn">+</span>
	    	</div>
	    </td>
	    <td class="cart__total">{{cart.book.price*cart.quantity}}</td>
	    <td class="cart__close"><span @click="delCart(cart.cart_idx)" class="icon_close""></span></td>
	</tr>
	`
	, props:["obj"]
	, data(){
		return{
			cart:this.obj
			, ea:1
		}
	}
	, methods:{
		delCart(cart_idx){
			if(!confirm("삭제하시겠습니까?")){
				return;
			}	
			
			$.ajax({
				url:"/rest/cart/"+cart_idx
				, type:"DELETE"
				, success:function(result, status, xhr){
					alert(result.msg);
					getCartList();
				}
				, error:function(xhr, status, err){
					
				}
			});
		}
		, valUp(){
			$("input[name='bookQuantity']").attr('value',Number($("input[name='bookQuantity']").val())+1);
			console.log($("input[name='bookQuantity']").val());
		}
		,valDown(){
			$("input[name='bookQuantity']").attr('value',Number($("input[name='bookQuantity']").val())-1);
			console.log($("input[name='bookQuantity']").val());
		}
	}
}

app1 = new Vue({
	el:"#app1"
	, components:{
		cart
	}
	, data:{
		cartList:[]
	}
	, methods:{
		
	}
});

function shopOrder(){
	if(!confirm("결제창으로 이동합니다")){
		return;
	}
	location.href="/shop_order";
}

function getCartList(){
	let member = $("#member").val();

	$.ajax({
		url:"/rest/cart?member_idx="+member
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			app1.cartList=result;
		}
	});
}

$(function(){
	getCartList();
});
</script>
</body>
</html>