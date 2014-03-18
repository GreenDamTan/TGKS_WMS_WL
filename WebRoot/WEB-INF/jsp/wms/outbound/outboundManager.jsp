<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderManager.inc.jsp" %>
<style type="text/css">
#outboundReq{border:0px solid;}
#outboundReq td{border:0px solid;}
#outboundReq input{width:120px;}
#outboundReq select{width:120px;}
</style>
<input type="hidden" id="outboundManagerSubmit" name="outboundManagerSubmit" value="0" />
<div class="ui-widget">
	<form id="outboundReq" action="../wms/queryOutbound.action" method="post">
		<table>
			<tr>
				<td><label>名称: </label></td><td><input type="text" name="outboundReq.name" /></td>
				<td><label>编号: </label></td><td><input type="text" name="outboundReq.code" /></td>
				<td><label>类别: </label></td>
				<td>
					<select name="outboundReq.type">
						<option value="" >全部</option>
						<option value="0" >原材料</option>
						<option value="1" >半成品</option>
						<option value="2" >成品</option>
					</select>
				</td>
				<td>
					客户：
				</td>
				<td>
					<select name="outboundReq.custom">
						<option value="" >全部</option>
						<s:iterator  value="customList" var="evt">
							<option value="<s:property value="#evt.name"/>"><s:property value="#evt.name"/></option>
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td>出库时间：</td>
				<td><input type="text" class="datepicker" name="outboundReq.createTimeStart" /></td>
				<td>~</td>
				<td><input type="text" class="datepicker" name="outboundReq.createTimeEnd" /></td>
				
				<td>送货单状态：</td>
				<td>
					<select name="outboundReq.print">
						<option value="" >全部</option>
						<option value="0" >未生成</option>
						<option value="1" >已生成</option>
					</select>
				</td>
				
				<td></td>
				<td><button id="clearOutbound">重置</button><button id="queryOutbound">查询</button></td>
			</tr>
		</table>
		<!-- 
		<button id="addOutbound">新增</button>
		<button id="deleteOutbound">删除</button>
		<button id="onOutbound">启用</button>
		<button id="offOutbound">禁用</button>
		 -->
	</form>
</div>

<button id="outboundOrder">生成出货单</button>
<div id="outboundDiv"></div>

<div id="outboundConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>记录将生成送货单，是否确认？</p>
</div>

<div id="outboundOrderOver" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>送货单已经生成！</p>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var table=$.ajax({url:"../wms/queryOutbound.action",async:false});
	$("#outboundDiv").html(table.responseText);
	
	function query()
	{
		var table=$.ajax({url:"../wms/queryOutbound.action", data:$("#outboundReq").formSerialize(), async:false});
		$("#outboundDiv").html(table.responseText);
	}
	
	/*
	// 新增/更新窗口
	$( "#outboundEdit" ).dialog({
		height:500,
		width:750,
		autoOpen: false,
		show: "fold",
		hide: "fold",
		buttons:
		{ 
			"确定":function()
			{
				var form = $("#outboundForm");
				form.submit();
			}, 
			"关闭": function()
			{
				$("#outboundEdit").dialog("close"); 
				$("#outboundManagerSubmit").val("0");
			} 
		}
	});
	*/
	/*
	// 提交表单
	$("#outboundForm").submit(function()
	{
		if ($("#outboundManagerSubmit").val() == "0")
		{
			return false;
		}
		
		$("#outboundManagerSubmit").val("0");
		
		var options = { 
			url:"../wms/editOutbound.action", // 提交给哪个执行
			type:'POST', 
			success: function(){
				$("#outboundEdit").dialog("close");
				// 新增完毕刷新form
				query();
				alert("操作成功");
			},
			error:function(){ 
				$("#outboundEdit").dialog("close"); 
				alert("操作失败"); 
			}
		};
		
		$("#outboundForm").ajaxSubmit(options);
		return false; // 为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
	});  
	
	// 新增按钮
	$( "#addOutbound" ).button({
		icons: {
			primary: "ui-icon-plus"
			}
		}).click(function() {
		$("#outboundManagerSubmit").val("1");
		$( "#outboundEdit" ).dialog( "open" );
		var edit=$.ajax({url:"../wms/editOutboundPage.action",async:false});
		$("#outboundForm").html(edit.responseText);
		return false;
	});
	
	 // 删除按钮
	$( "#deleteOutbound" ).button({
		icons: {
			primary: "ui-icon-minus"
			}
		}).click(function() {
		// 获取选中的记录ids
		var ids = "";
		var array = document.getElementsByName("outboundId");
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
			return false;
		}
		
		// ajax调用删除action
		var options = { 
			url:"../wms/deleteOutbound.action?ids=" + ids , // 提交给哪个执行
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
		
		// 确认操作
		$("#outboundConfirm").dialog({
			resizable: false,
            height:160,
            modal: true,
            buttons: {
                "确认": function() {
                	$( this ).dialog( "close" );
                	// 异步请求删除操作
                	$("#outboundConfirm").ajaxSubmit(options);
                },
                "取消": function() {
                    $( this ).dialog( "close" );
                }
            }
		});
				
		return false;
	});
	 
	 // 启用按钮
	$( "#onOutbound" ).button({
		icons: {
			primary: "ui-icon-check"
			}
		}).click(function() {
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("outboundId");
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
				return false;
			}
			
			// ajax调用删除action
			var options = { 
				url:"../wms/changeStatusOutbound.action?status=1&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#outboundConfirm").ajaxSubmit(options);
			return false;
	});
	 
	 // 停用按钮
	$( "#offOutbound" ).button({
		icons: {
			primary: "ui-icon-close"
			}
		}).click(function() {
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("outboundId");
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
				return false;
			}
			
			// ajax调用删除action
			var options = { 
				url:"../wms/changeStatusOutbound.action?status=0&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#outboundConfirm").ajaxSubmit(options);
			return false;
	});
	*/
	 // 刷新按钮
	$( "#queryOutbound" ).button().click(function() {
			query();
		return false;
	});
	 
	// 重置按钮
	$( "#clearOutbound" ).button().click(function() {
			$("#outboundReq").clearForm();
		return false;
	});
	
	$("#outboundOrder").button().click(function(){
		icons: {
			primary: "ui-icon-print"
			}
		}).click(function() {
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("outboundId");
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
				return false;
			}
			
			// 确认操作
			$("#outboundConfirm").dialog({
				resizable: false,
	            height:160,
	            modal: true,
	            buttons: {
	                "确认": function() {
	                	$( this ).dialog( "close" );
	                	
						window.open("../wms/outboundOrder.action?ids=" + ids);
						
						// 生成完毕后重新刷新列表使用
						$("#outboundOrderOver").dialog({
							resizable: false,
				            height:160,
				            modal: true,
				            buttons: {
				                "确认": function() {
				                	$( this ).dialog( "close" );
									query(); 
				                }
				            }
						});
	                },
	                "取消": function() {
	                    $( this ).dialog( "close" );
	                }
	            }
			});
			
			return false;
	});
	
});
</script>
