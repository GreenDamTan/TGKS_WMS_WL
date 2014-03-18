<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<table>
	<input type="hidden" name="commodityEvt.id" id="commodityId" value="${commodityEvt.id }" />
	<input type="hidden" name="commodityEvt.status" id="commodityStatus" value="${commodityEvt.status }" />
	<input type="hidden" name="commodityEvt.number" id="commodityNumber" value="${commodityEvt.number }" />
	<tr>
		<td><label for="name">名称<a style="color:red">*</a></label></td>
		<td><input type="text" name="commodityEvt.name" id="commodityName" value="${commodityEvt.name }" /></td>
		<td><label for="categoryId">类别</label></td>
		<td>
			<select id="commodityType" name="commodityEvt.type">
				<option value="0" <s:if test="#commodityEvt.type == 0">selected="selected"</s:if>>
					原材料
				</option>
				<option value="1" <s:if test="#commodityEvt.type == 1">selected="selected"</s:if>>
					半成品
				</option>
				<option value="2" <s:if test="#commodityEvt.type == 2">selected="selected"</s:if>>
					成品
				</option>
			</select>
		</td>
		<td><label for="name">状态</label></td>
		<td><s:if test="#commodityEvt.status == 0">已入库</s:if><s:else>未入库</s:else></td>
	</tr>
	<tr>
		<td><label for="name">编号</label></td>
		<td><input type="text" name="commodityEvt.code" id="commodityCode" value="${commodityEvt.code }" /></td>
		<td><label for="material">材质</label></td>
		<td><input type="text" name="commodityEvt.material" id="commodityMaterial" value="${commodityEvt.material }" /></td>
		<td><label for="model">型号</label></td>
		<td><input type="text" name="commodityEvt.model" id="commodityModel" value="${commodityEvt.model }" /></td>
	</tr>
	<tr>
		
	</tr>
	<tr>
		<td><label for="spec">规格</label></td>
		<td><input type="text" name="commodityEvt.spec" id="commoditySpec" value="${commodityEvt.spec }" /></td>
		<td><label for="number">数量</label></td>
		<td>${commodityEvt.number }</td>
		<td><label for="unit">单位</label></td>
		<td><input type="text" name="commodityEvt.unit" id="commodityUnit" value="${commodityEvt.unit }" /></td>
	</tr>
	<tr>
		<td><label for="price">单价</label></td>
		<td><input type="text" name="commodityEvt.price" id="commodityPrice" value="${commodityEvt.price }" /></td>
		<td><label for="supplier">供货商</label></td>
		<td>
			<input type="text" name="commodityEvt.supplier" id="commoditySupplier" value="${commodityEvt.supplier }" />
		</td>
		<td colspan="3">
			<select id="supplierSelect">
				<option></option>
				<s:iterator  value="supplierList" var="evt">
					<option value="<s:property value="#evt.name"/>"><s:property value="#evt.name"/></option>
				</s:iterator>
			</select>
		</td>
	</tr>
	<tr>
		<td><label for="remark">备注</label></td>
		<td colspan="5"><textarea name="commodityEvt.remark" id="commodityRemark" cols="105" rows="5">${commodityEvt.remark }</textarea></td>
	</tr>
</table>
<script type="text/javascript">
$(function(){
	$("#supplierSelect").change(function(){
		$("#commoditySupplier").val($("#supplierSelect").val());
	});
});
</script>