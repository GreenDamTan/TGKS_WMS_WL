<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderManager.inc.jsp" %>
<style type="text/css">
#outboundOrderReq{border:0px solid;}
#outboundOrderReq td{border:0px solid;}
#outboundOrderReq input{width:120px;}
#outboundOrderReq select{width:120px;}
</style>
<input type="hidden" id="outboundOrderManagerSubmit" name="outboundOrderManagerSubmit" value="0" />
<div class="ui-widget">
	<form id="outboundOrderReq" action="../wms/queryOutboundOrder.action" method="post">
		<table>
			<tr>
				<td>编号：</td><td><input type="text" name="outboundOrderReq.id" /></td>
				<td>
					客户：
				</td>
				<td>
					<select name="outboundOrderReq.custom">
						<option value="" >全部</option>
						<s:iterator  value="customList" var="evt">
							<option value="<s:property value="#evt.name"/>"><s:property value="#evt.name"/></option>
						</s:iterator>
					</select>
				</td>
				<td>时间：</td>
				<td><input type="text" class="datepicker" name="outboundOrderReq.createTimeStart" /></td>
				<td>~</td>
				<td><input type="text" class="datepicker" name="outboundOrderReq.createTimeEnd" /></td>
				<td></td>
				<td>
				<button id="clearOutboundOrder">重置</button>
				<button id="queryOutboundOrder">查询</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<button id="checkOutboundOrder">生成对账单</button>
<!-- 
<button id="addOutboundOrder">新增</button>
<button id="onOutboundOrder">启用</button>
<button id="offOutboundOrder">禁用</button>
 -->
<div id="outboundOrderDiv"></div>

<div id="outboundOrderEdit" title="OutboundOrder Edit">
	<form id="outboundOrderForm" action="../wms/editOutboundOrder.action" method="post"></form>
</div>

<div id="outboundOrderConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>记录将生成对账单，是否确认？</p>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var table=$.ajax({url:"../wms/queryOutboundOrder.action",async:false});
	$("#outboundOrderDiv").html(table.responseText);
	
	function query()
	{
		var table=$.ajax({url:"../wms/queryOutboundOrder.action", data:$("#outboundOrderReq").formSerialize(), async:false});
		$("#outboundOrderDiv").html(table.responseText);
	}
	
	// 新增/更新窗口
	$( "#outboundOrderEdit" ).dialog({
		modal: true,
		height:500,
		width:750,
		autoOpen: false,
		show: "fold",
		hide: "fold",
		buttons:
		{ 
			"确定":function()
			{
				var form = $("#outboundOrderForm");
				form.submit();
			}, 
			"关闭": function()
			{
				$("#outboundOrderManagerSubmit").val("0");
				$("#outboundOrderEdit").dialog("close"); 
			} 
		}
	});
	
	// 提交表单
	$("#outboundOrderForm").submit(function()
	{
		if ($("#outboundOrderManagerSubmit").val() == "0")
		{
			return false;
		}
		
		$("#outboundOrderManagerSubmit").val("0");
		
		var options = { 
			url:"../wms/editOutboundOrder.action", // 提交给哪个执行
			type:'POST', 
			success: function(){
				$("#outboundOrderEdit").dialog("close");
				// 新增完毕刷新form
				query();
				alert("操作成功");
			},
			error:function(){ 
				$("#outboundOrderEdit").dialog("close"); 
				alert("操作失败"); 
			}
		};
		
		$("#outboundOrderForm").ajaxSubmit(options);
		
		return false; // 为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
	});  
	
	// 新增按钮
	$( "#addOutboundOrder" ).button({
		icons: {
			primary: "ui-icon-plus"
			}
		}).click(function() {
		// 请求提交标志
		$("#outboundOrderManagerSubmit").val("1");
		$( "#outboundOrderEdit" ).dialog( "open" );
		var edit=$.ajax({url:"../wms/editOutboundOrderPage.action",async:false});
		$("#outboundOrderForm").html(edit.responseText);
		return false;
	});
	
	 // 生成对账单按钮
	$( "#checkOutboundOrder" ).button().click(function() {
		$("#outboundOrderManagerSubmit").val("1");
		// 获取选中的记录ids
		var ids = "";
		var array = document.getElementsByName("outboundOrderId");
		for (var i=0; i<array.length; i++)
	   	{
	   		if (array[i].checked)
  			{
	   			if (ids == "")
   				{
	   				ids += array[i].value;
   				}
	   			else
	   			{
	   				ids += "," + array[i].value;
	   			}
  			}
	   	}
		
		// 操作验证
		if (ids == "")
		{
			alert("请选择至少一条记录");
			$("#outboundOrderManagerSubmit").val("0");
			return false;
		}
		
		/*
		// ajax调用删除action
		var options = { 
			url:"../wms/checkOutboundOrder.action?ids=" + ids , // 提交给哪个执行
			type:'POST', 
			success: function(){
				alert("删除成功");
				// 执行成功刷新form
				query();
			},
			error:function(){ 
				alert("删除失败"); 
			}
		};
		*/
		
		// 确认操作
		$("#outboundOrderConfirm").dialog({
			resizable: false,
            height:160,
            modal: true,
            buttons: {
                "确认": function() {
                	$( this ).dialog( "close" );
                	
                	// 跳转到对账单界面
                	window.open("../wms/checkOutboundOrder.action?ids=" + ids);
                },
                "取消": function() {
                    $( this ).dialog( "close" );
                }
            }
		});
		
		$("#outboundOrderManagerSubmit").val("0");
		return false;
	});
	 
	 // 启用按钮
	$( "#onOutboundOrder" ).button({
		icons: {
			primary: "ui-icon-check"
			}
		}).click(function() {
			$("#outboundOrderManagerSubmit").val("1");
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("outboundOrderId");
			for (var i=0; i<array.length; i++)
		   	{
		   		if (array[i].checked)
	  			{
		   			if (ids == "")
	   				{
		   				ids += array[i].value;
	   				}
		   			else
		   			{
		   				ids += "," + array[i].value;
		   			}
	  			}
		   	}
			
			// 操作验证
			if (ids == "")
			{
				alert("请选择至少一条记录");
				$("#outboundOrderManagerSubmit").val("0");
				return false;
			}
			
			// ajax调用删除action
			var options = { 
				url:"../wms/changeStatusOutboundOrder.action?status=1&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#outboundOrderConfirm").ajaxSubmit(options);
			$("#outboundOrderManagerSubmit").val("0");
			return false;
	});
	 
	 // 停用按钮
	$( "#offOutboundOrder" ).button({
		icons: {
			primary: "ui-icon-close"
			}
		}).click(function() {
			$("#outboundOrderManagerSubmit").val("1");
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("outboundOrderId");
			for (var i=0; i<array.length; i++)
		   	{
		   		if (array[i].checked)
	  			{
		   			if (ids == "")
	   				{
		   				ids += array[i].value;
	   				}
		   			else
		   			{
		   				ids += "," + array[i].value;
		   			}
	  			}
		   	}
			
			// 操作验证
			if (ids == "")
			{
				alert("请选择至少一条记录");
				$("#outboundOrderManagerSubmit").val("0");
				return false;
			}
			
			// ajax调用删除action
			var options = { 
				url:"../wms/changeStatusOutboundOrder.action?status=0&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#outboundOrderConfirm").ajaxSubmit(options);
			$("#outboundOrderManagerSubmit").val("0");
			return false;
	});
	
	 // 刷新按钮
	$( "#queryOutboundOrder" ).button().click(function() {
			query();
		return false;
	});
	 
	// 重置按钮
	$( "#clearOutboundOrder" ).button().click(function() {
			$("#outboundOrderReq").clearForm();
		return false;
	});
});
</script>
