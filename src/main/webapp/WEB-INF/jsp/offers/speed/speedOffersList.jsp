<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cheapy" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href='https://fonts.googleapis.com/css?family=Lobster' rel='stylesheet'>

<cheapy:layout pageName="ofertas">

	<spring:url value="/offers/foodOfferList" var="foodOfferUrl">
    </spring:url>
    <button type="button" role="link" onclick="window.location='/offers/foodOfferList'" style="font-family: 'Lobster'; font-size: 20px;">
	<span class="glyphicon 	glyphicon glyphicon-edit" aria-hidden="true" style="padding: 5px"> </span>
	Ofertas de plato especifico</button>
	
	<spring:url value="/offers/nuOfferList" var="nuOfferUrl">
    </spring:url>
    <button type="button" role="link" onclick="window.location='/offers/nuOfferList'" style="font-family: 'Lobster'; font-size: 20px;">
	<span class="glyphicon 	glyphicon glyphicon-edit" aria-hidden="true" style="padding: 5px"> </span>
	Ofertas por n�mero de comensales</button>
	
	<spring:url value="/offers/timeOfferList" var="timeOfferUrl">
    </spring:url>
    <button type="button" role="link" onclick="window.location='/offers/timeOfferList'" style="font-family: 'Lobster'; font-size: 20px;">
	<span class="glyphicon 	glyphicon glyphicon-edit" aria-hidden="true" style="padding: 5px"> </span>
	Ofertas de franja horaria</button>

    <h2 style="text-align:center;padding:5px"><fmt:message key="speedOffers"/></h2>
	<c:if test="${empty speedOfferLs }">
		<p id="vacio" >No hay ninguna oferta por tiempo empleado en comer activa.</p>
	</c:if>
	<c:if test="${not empty speedOfferLs }">
    <table id="speedOfferTable" class="table table-striped">
        <thead>
        <tr>
        	<!-- <th style="width: 150px;">Restaurante</th> -->
            <th><fmt:message key="name"/></th>
            <th><fmt:message key="startDate"/></th>
            <th><fmt:message key="endDate"/></th>
            <th><fmt:message key="goldGoal"/></th>
            <th><fmt:message key="goldDiscount"/></th>
            <th> </th>
            
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${speedOfferLs}" var="speedOffer">
            <tr>
                <td>
                    <c:out value="${speedOffer.client.name}"/>
                </td>
                <td>
                    <c:out value="${localDateTimeFormat.format(speedOffer.start)}"/>
                </td>
                <td>
                    <c:out value="${localDateTimeFormat.format(speedOffer.end)}"/>
                </td>
                <td>
                    <c:out value="${speedOffer.gold} minutos"/>
                </td>
                <td>
                    <c:out value="${speedOffer.discountGold}%"/>
                </td>
                <td>
                    <spring:url value="/offers/speed/{speedOfferId}" var="speedOfferUrl">
                        <spring:param name="speedOfferId" value="${speedOffer.id}"/>
                    </spring:url>
                    <div class="btn-detalles">
	                    <button type="button" role="link" onclick="window.location='${fn:escapeXml(speedOfferUrl)}'" class="btn-detalles" style="font-family: 'Lobster'; font-size: 20px;">
	                    <span class="glyphicon glyphicon-info-sign" aria-hidden="true" style="padding: 5px"> </span>
	                    <fmt:message key="details"/> </button>
	                </div>
                </td>
                  
            </tr>
        </c:forEach>
        </tbody>
    </table>
    </c:if>
</cheapy:layout>
