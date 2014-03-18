<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<input type="hidden" name="storageEvt.commodityId" id="storageCommodityId" value="${commodityEvt.id }" />
<table>
	<tr>
		<td><label for="price">价格<a style="color:red">*</a></label></td>
		<td colspan="2"><input type="text" name="storageEvt.price" id="storagePrice"  value="${commodityEvt.price }" /></td>
	</tr>
	<tr>
		<td><label for="number">数量<a style="color:red">*</a></label></td>
		<td><input type="text" name="storageEvt.number" id="storageNumber"  value="" /></td>
		<td>${commodityEvt.unit }</td>
	</tr>
	<tr>
		<td><label for="supplier">供货商</label></td>
		<td colspan="2"><label for="supplier">${commodityEvt.supplier }</label></td>
	</tr>
	<tr>
		<td><label for="remark">备注</label></td>
		<td colspan="2"><textarea name="storageEvt.remark" id="storageEvtRemark" cols="30" rows="3"></textarea></td>
	</tr>
</table>

<script type="text/javascript">
$(function(){
	
});
</script>