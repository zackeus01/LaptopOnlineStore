<%-- 
    Document   : pagination
    Created on : Mar 8, 2023, 10:59:10 AM
    Author     : toden
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="store-filter clearfix">
  <span class="store-qty">Showing 20-100 products</span>
  <ul class="store-pagination">
    <c:if test="${sessionScope.page.getTotalPage()==1}">
        <li class="active"><a href="shop?cp=${sessionScope.page.getCurrentPage()}">${sessionScope.page.getCurrentPage()}</a></li>
    </c:if>
    <c:if test="${sessionScope.page.getTotalPage()!=1}">
        <c:if test="${sessionScope.page.getCurrentPage()>1&&sessionScope.page.getCurrentPage()<sessionScope.page.getTotalPage()}">
          <li><a href="shop?cp=1"><<</a></li>
          <li><a href="shop?cp=${sessionScope.page.getCurrentPage()-1}">${sessionScope.page.getCurrentPage()-1}</a></li>
          <li class="active"><a href="shop?cp=${sessionScope.page.getCurrentPage()}">${sessionScope.page.getCurrentPage()}</a></li>
          <li><a href="shop?cp=${sessionScope.page.getCurrentPage()+1}">${sessionScope.page.getCurrentPage()+1}</a></li>
          <li><a href="shop?cp=${sessionScope.page.getTotalPage()}">>></a></li>
        </c:if>
        <c:if test="${sessionScope.page.getCurrentPage()==1}">
          <li class="active"><a href="shop?cp=${sessionScope.page.getCurrentPage()}">${sessionScope.page.getCurrentPage()}</a></li>
          <li><a href="shop?cp=${sessionScope.page.getCurrentPage()+1}">${sessionScope.page.getCurrentPage()+1}</a></li>
          <li><a href="shop?cp=${sessionScope.page.getTotalPage()}">>></a></li>
        </c:if>
        <c:if test="${sessionScope.page.getCurrentPage()==sessionScope.page.getTotalPage()}">
          <li><a href="shop?cp=1"><<</a></li>
          <li><a href="shop?cp=${sessionScope.page.getCurrentPage()-1}">${sessionScope.page.getCurrentPage()-1}</a></li>
          <li class="active"><a href="ProductList?cp=${sessionScope.page.getCurrentPage()}">${sessionScope.page.getCurrentPage()}</a></li>
        </c:if>
    </c:if>
  </ul>
</div>






