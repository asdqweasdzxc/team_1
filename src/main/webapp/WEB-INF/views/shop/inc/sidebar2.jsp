

<%@ page contentType="text/html;charset=UTF-8"%>

<div class="shop__sidebar">
					
						<div class="sidebar__categories">
							<div class="section-title">
								<h4>Categories</h4>
							</div>
							<div class="categories__accordion" >
								<div class="accordion" id="accordionExample">
									<div class="card" >
										<div id="app2">
										<template v-for=" topcategory in topList">
											<categorys :top="topcategory"/>
										</template>
										</div>
										
										<div class="card-heading active mt-5" id="selectCategory">
											
										</div>
										<div id="app3">
											<div class="card-body">
												<ul>
													<template v-for ="subcategory in ssList">
														<scategorys :sub="subcategory"/>
													</template>
												</ul>	
											</div>
										</div>

									
									</div>
								</div>
							</div>
						</div>
							
					</div>