<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderManager.inc.jsp" %>
<style type="text/css">
#storageReq{border:0px solid;}
#storageReq td{border:0px solid;}
#storageReq input{width:120px;}
#storageReq select{width:120px;}
</style>

<div class="ui-widget">
	<form id="storageReq" action="../wms/queryStorage.action" method="post">
		<table>
			<tr>
				<td><label>名称: </label></td><td><input type="text" name="storageReq.name" /></td>
				<td><label>编号: </label></td><td><input type="text" name="storageReq.code" /></td>
				<td><label>类别: </label></td>
				<td>
					<select name="storageReq.type">
						<option value="" >全部</option>
						<option value="0" >原材料</option>
						<option value="1" >半成品</option>
						<option value="2" >成品</option>
					</select>
				</td>
				<td>
					供货商：
				</td>
				<td>
					<select name="storageReq.supplier">
						<option value="" >全部</option>
						<s:iterator  value="supplierList" var="evt">
							<option value="<s:property value="#evt.name"/>"><s:property value="#evt.name"/></option>
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td>入库时间：</td>
				<td><input type="text" class="datepicker" name="storageReq.createTimeStart" /></td>
				<td>~</td>
				<td><input type="text" class="datepicker" name="storageReq.createTimeEnd" /></td>
				<td></td>
				<td></td>
				<td></td>
				<td><button id="clearStorage">重置</button><button id="queryStorage">查询</button></td>
			</tr>
		</table>
		<!-- 
		<button id="addStorage">新增</button>
		<button id="deleteStorage">删除</button>
		<button id="onStorage">启用</button>
		<button id="offStorage">禁用</button>
		 -->
	</form>
</div>

<div id="storageDiv"></div>

<div id="storageConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>记录将被删除且不可恢复，是否确认？</p>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var table=$.ajax({url:"../wms/queryStorage.action",async:false});
	$("#storageDiv").html(table.responseText);
	
	function query()
	{
		var table=$.ajax({url:"../wms/queryStorage.action", data:$("#storageReq").formSerialize(), async:false});
		$("#storageDiv").html(table.responseText);
	}
	
	 // 刷新按钮
	$( "#queryStorage" ).button().click(function() {
			query();
		return false;
	});
	 
	// 重置按钮
	$( "#clearStorage" ).button().click(function() {
			$("#storageReq").clearForm();
		return false;
	});
});
</script>
