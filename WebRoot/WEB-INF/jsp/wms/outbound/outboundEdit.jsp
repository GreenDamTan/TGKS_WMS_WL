<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" name="outboundEvt.commodityId" id="outboundCommodityId" value="${commodityEvt.id }" />
<input type="hidden" id="maxNumber" value="${commodityEvt.number }" />
<table>
	<tr>
		<td><label for="price">价格<a style="color:red">*</a></label></td>
		<td><input type="text" name="outboundEvt.price" id="outboundPrice" value="" /></td>
		<td><label for="commodityPrice">定价</label></td>
		<td>${commodityEvt.price }</td>
	</tr>
	<tr>
		<td><label for="tax">税率</label></td>
		<td><input type="text" name="outboundEvt.tax" id="outboundTax" value="0.17" /></td>
		<td>
			<input type="radio" id="outboundOnTax" name="outboundIfTax" checked="checked">
			未含税
		</td>
		<td>
			<input type="radio" id="outboundOffTax" name="outboundIfTax">
			已含税
		</td>
	</tr>
	<tr>
		<td><label for="price">数量<a style="color:red">*</a></label></td>
		<td><input type="text" name="outboundEvt.number" id="outboundNumber" value="" /></td>
		<td>${commodityEvt.unit }</td>
		<td><label for="maxNumber">当前库存 ${commodityEvt.number }</label></td>
	</tr>
	<tr>
		<td><label for="custom">客户</label></td>
		<td><input type="text" name="outboundEvt.custom" id="outboundCustom" value="" /></td>
		<td colspan="2">
			<select id="customSelect">
				<option></option>
				<s:iterator  value="customList" var="evt">
					<option value="<s:property value="#evt.name"/>"><s:property value="#evt.name"/></option>
				</s:iterator>
			</select>
		</td>
	</tr>
	<tr>
		<td><label for="remark">备注</label></td>
		<td colspan="3"><textarea name="outboundEvt.remark" id="outboundEvtRemark" cols="45" rows="3"></textarea></td>
	</tr>
</table>
<script type="text/javascript">
$(function(){
	$("#customSelect").change(function(){
		$("#outboundCustom").val($("#customSelect").val());
	});
	
	$("#outboundOnTax").click(function(){
		$("#outboundTax").val("0.17");
		$("#outboundTax").removeAttr("disabled");
	});
	
	$("#outboundOffTax").click(function(){
		$("#outboundTax").val("0");
		$("#outboundTax").attr("disabled","disabled");
	});
	
});
</script>
