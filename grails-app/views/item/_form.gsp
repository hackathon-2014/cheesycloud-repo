<%@ page import="foodrun.Item" %>



<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="item.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" type="number" value="${itemInstance.amount}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="item.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${itemInstance?.name}"/>

</div>

