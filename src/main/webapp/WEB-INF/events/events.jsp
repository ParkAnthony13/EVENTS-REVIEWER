<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Date" import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>Insert title here</title>
	</head>
	<body>
		<div class="container d-flex justify-content-end m-3"><a href="/logout" class="btn btn-warning">Log Out</a></div>
		<div class="container">
			<h1>Welcome <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></h1>
			<p>Here are some of the events in your State: </p>
			<table class="table table-dark">
				<thead>
					<tr>
						<td>Name</td>
						<td>Date</td>
						<td>Location</td>
						<td>Host</td>
						<td>Action/Status</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${events}" var="event">
						<c:if test="${event.state==user.state}">
						<tr>
							<td><a href="/events/${event.id}"><c:out value="${event.eventName}"/></a></td>
							<td>
								<fmt:formatDate pattern = "yyyy-MM-dd" value ="${event.date}" />
							</td>
							<td><c:out value="${event.location}"/></td>
							<td><c:out value="${event.host.firstName} "/><c:out value="${event.host.lastName}"/></td>
							<td class="d-flex">
								<c:if test="${event.host.id==user.id}">
								<a href="/events/${event.id}/edit">Edit</a>
								<form action="/delete/${event.id}" method="post">
									<input type="hidden" name="_method" value="delete"/>
									<input type="submit" value="Delete" style="text-decoration: none;"/>
								</form>
								</c:if>
								
								<c:if test="${event.host.id!=user.id}">
								
									<c:if test="${event.users.contains(user)}">
										<p style="margin-right: 3px;">Joining</p>
										<a href="/cancel/${event.id}"> Cancel</a>		
									</c:if>
									<c:if test="${!event.users.contains(user)}">
										<a href="/events/join/${event.id}">Join</a>		
									</c:if>
															
								</c:if>
								
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<p>Here are some of the events in other states:</p>
			<table class="table table-dark">
				<thead>
					<tr>
						<td>Name</td>
						<td>Date</td>
						<td>Location</td>
						<td>State</td>
						<td>Host</td>
						<td>Action/Status</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${events}" var="event">
						<c:if test="${event.state!=user.state}">
						<tr>
							<td><a href="/events/${event.id}"><c:out value="${event.eventName}"/></a></td>
							<td><fmt:formatDate pattern = "yyyy-MM-dd" value ="${event.date}" /></td>
							<td><c:out value="${event.location}"/></td>
							<td><c:out value="${event.state.state}"/></td>
							<td><c:out value="${event.host.firstName} "/><c:out value="${event.host.lastName}"/></td>
							<td class="d-flex">
								<c:if test="${event.host.id==user.id}">
								<a href="/events/${event.id}/edit">Edit</a>
								<form action="/delete/${event.id}" method="post">
									<input type="hidden" name="_method" value="delete"/>
									<input type="submit" value="Delete" style="text-decoration: none;"/>
								</form>
								</c:if>
								
								<c:if test="${event.host.id!=user.id}">
								
									<c:if test="${event.users.contains(user)}">
										<p style="margin-right: 3px;">Joining</p>
										<a href="/cancel/${event.id}">Cancel</a>		
									</c:if>
									<c:if test="${!event.users.contains(user)}">
										<a href="/events/join/${event.id}">Join</a>		
									</c:if>
															
								</c:if>
								
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="container">
			<h3>Create an Event</h3>
			<form:form action="/events" method="post" modelAttribute="event">
				<p>
		            <form:label path="eventName">Name:</form:label>
		            <form:input type="text" path="eventName"/>
					<form:errors path="eventName" style="color:red;"/>
		        </p>
				<p>
		            <form:label path="date">Date:</form:label>
		            <form:input type="date" path="date"/>
					<form:errors path="date" style="color:red;"/>
		        </p>
		        <p>
		            <form:label path="location">Location:</form:label>
		            <form:input type="text" path="location"/>
					<form:errors path="location" style="color:red;"/>
					
					<span>
			        	<form:select path="state">
			        			<form:options items="${listOfStates}" itemValue="id" itemLabel="state"></form:options>
			        	</form:select>
					</span>
		        </p>
		        <button>Create Event</button>
			</form:form>
		</div>
		<script src="/webjars/jquery/jquery.min.js"></script>
		<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/app.js"></script>
	</body>
</html>