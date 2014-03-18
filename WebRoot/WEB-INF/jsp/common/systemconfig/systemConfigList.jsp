<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<table id="systemConfigTable" class="ui-widget ui-widget-content">
	<thead>
		<tr class="ui-widget-header ">
			<th width="20"><input type="checkbox" name="allSystemConfigId"/></th>
			<th>参数标签</th>
			<th>参数名</th>
			<th>参数值</th>
			<th>类型</th>
		</tr>
	</thead>
	<tbody>
		<s:iterator  value="list" var="evt">
			<tr>
				<td width="20"><input type="checkbox" name="systemConfigId" value="<s:property value='#evt.id'/>"/></td>
				<td><s:property value="#evt.tag"/></td>
				<td><s:property value="#evt.name"/></td>
				<td><s:property value="#evt.value"/></td>
				<td><s:property value="#evt.type"/></td>
			</tr>
		</s:iterator>
	</tbody>
</table>
<script type="text/javascript">
	$(function () {
		$('#systemConfigTable').longtable({'perPage': 5});
	});
</script>