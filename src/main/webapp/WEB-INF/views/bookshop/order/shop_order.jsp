<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="./inc/header.jsp"%>
<%!
	int member_idx=2;
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
                                	<cartdetail :key="cart.cart_idx" :obj="cart"/>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                   <a href="javascript:ordercomp()" class="primary-btn">go comp</a>
                </div>
                <div class="col-lg-4 offset-lg-2">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                        <ul>
                            <li>Subtotal <span>$ 750.0</span></li>
                            <li>Total <span>$ 750.0</span></li>
                        </ul>
                        <a href="javascript:payment()" class="primary-btn">Proceed to checkout</a>
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
let app1;

var clientKey = 'test_ck_D4yKeq5bgrpokQP5OwJVGX0lzW6Y'
var tossPayments = TossPayments(clientKey) // 클라이언트 키로 초기화하기

function payment(){
	tossPayments.requestPayment('카드', { // 결제 수단 파라미터
		  // 결제 정보 파라미터
		  amount: 1234,
		  orderId: 'dp96vG5YwC_oG9zgRgOGG',
		  orderName: '토스 티셔츠 외 2건',
		  customerName: '박토스',
		  successUrl: 'http://localhost:7777/payment/callback/success?returnAmount=1234',
		  failUrl: 'http://localhost:7777/payment/callback/fail',
		}).catch(function (error) {
		  if (error.code === 'USER_CANCEL') {
		    // 결제 고객이 결제창을 닫았을 때 에러 처리
		  } else if (error.code === 'INVALID_CARD_COMPANY') {
		    // 유효하지 않은 카드 코드에 대한 에러 처리
		  }
		});
}

const cartdetail={
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
		    <input type="text" name="bookQuantity" min="0" value="1">
	    	</div>
	    </td>
	    <td class="cart__total">{{cart.book.price*cart.quantity}}</td>
	</tr>
	`
	, props:["obj"]
	, data(){
		return{
			cart:this.obj
		};
	}
}

function init(){
	app1 = new Vue({
		el:"#app1"
		, components:{
			cartdetail
		}
		, data:{
			cartList:[]
		}
	});	
}

function getCartList(){
	let member = $("#member").val();
	
	$.ajax({
		url:"/rest/cart?member_idx="+member
		, type:"get"
		, success:function(result, status, xhr){
			console.log(result);
			app1.cartList=result;
			$("input[name='bookQuantity']").attr('value',Number($("input[name='bookQuantity']").val()));
		}
	});
}

function ordercomp(){
	location.href="/ordercomp"
}

$(function(){
	getCartList();
	init();
});
</script>
</body>
</html>