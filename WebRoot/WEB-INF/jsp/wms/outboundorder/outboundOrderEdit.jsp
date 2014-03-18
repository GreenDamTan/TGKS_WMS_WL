<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" name="outboundOrderEvt.id" id="outboundOrderId" value="${outboundOrderEvt.id }" />
<table>
	<tr>
		<td><label for="name">outboundOrder</label></td>
		<td><input type="text" name="outboundOrderEvt.name" id="outboundOrderName" class="text ui-widget-content ui-corner-all" value="${outboundOrderEvt.name }" /></td>
	</tr>
</table>
<script type="text/javascript">
</script>