<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" name="customEvt.id" id="customId" value="${customEvt.id }" />
<table>
	<tr>
		<td width="50"><label for="name">名称<a style="color:red">*</a></label></td>
		<td colspan="3"><input type="text" name="customEvt.name" id="customName" class="text ui-widget-content ui-corner-all" value="${customEvt.name }" /></td>
	</tr>
	<tr>
		<td><label for="address">地址</label></td>
		<td colspan="3"><input type="text" name="customEvt.address" id="customAddress" class="text ui-widget-content ui-corner-all" value="${customEvt.address }" /></td>
	</tr>
	<tr>
		<td><label for="tel">电话</label></td>
		<td><input type="text" name="customEvt.tel" id="customTel" class="text ui-widget-content ui-corner-all" value="${customEvt.tel }" /></td>
		<td><label for="fax">传真</label></td>
		<td><input type="text" name="customEvt.fax" id="customFax" class="text ui-widget-content ui-corner-all" value="${customEvt.fax }" /></td>
	</tr>
	<tr>
		<td><label for="remark">备注</label></td>
		<td colspan="3"><textarea name="customEvt.remark" id="customRemark" class="text ui-widget-content ui-corner-all" cols="74" rows="5">${customEvt.remark }</textarea></td>
	</tr>
</table>
<script type="text/javascript">
</script>