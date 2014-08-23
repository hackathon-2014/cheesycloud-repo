<%@ page import="foodrun.Run" %>



<div class="fieldcontain ${hasErrors(bean: runInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="run.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${runInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: runInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="run.items.label" default="Items" />
		
	</label>
	<g:select name="items" from="${foodrun.Item.list()}" multiple="multiple" optionKey="id" size="5" value="${runInstance?.items*.id}" class="many-to-many"/>

</div>

