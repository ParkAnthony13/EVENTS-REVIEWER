<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Date" import="java.time.format.DateTimeFormatter" import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<div class="container d-flex justify-content-end m-3"><a href="/events" class="btn btn-warning">Events Page</a></div>
		
		<div class="container d-flex justify-content-center">
			<div class="left container">
				<h1><c:out value="${event.eventName}"/></h1>
				<p>Host:<c:out value=" ${event.host.firstName} "/><c:out value="${event.host.lastName}"/></p>
				
				<p>Date: <c:out value=" ${eventDate}"/></p>
				
				<p>Location:<c:out value=" ${event.location} "/><c:out value="${event.state.state}"/></p>
				<p>People who are attending this event: <c:out value="${event.users.size()+1}"/></p>
				<div class="container">
					<table class="table">
						<thead>
							<tr>
								<td>Name</td>
								<td>Location</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${event.users}" var="attendee">
								<tr>
									<td><c:out value="${attendee.firstName} "/><c:out value="${attendee.lastName}"/></td>
									<td><c:out value="${attendee.location}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="right container">
				<h1>Message Wall</h1>
				<div style="outline: 2px solid black;overflow-y:auto; height:200px;">
					<c:forEach items="${log}" var="msg">
						<p><c:out value="${msg.name}: "/><c:out value="${msg.message}"/></p>
					</c:forEach>
				</div>
				<div>
					<form method="post" action="/messages/${event.id}">
						<p class="d-flex m-1"> <!-- hidden user id input -->
							<label>Add Comment:</label>
							<textarea rows="3" cols="60" name="message"></textarea>
						</p>
						<c:out value="${error}"/>
						<div class="container d-flex justify-content-end m-3">
							<button class="btn btn-warning">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<script src="/webjars/jquery/jquery.min.js"></script>
		<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/app.js"></script>
	</body>
</html>