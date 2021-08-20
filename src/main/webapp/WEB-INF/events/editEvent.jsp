<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		<div class="container">
			<h3>Edit an Event: <c:out value="${event.eventName}"/></h3>
			<form:form action="/events/${event.id}/edit" method="post" modelAttribute="event">
				<input type="hidden" name="_method" value="put">
				<form:input type="hidden" path="host" value="${event.host.id}"/>
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