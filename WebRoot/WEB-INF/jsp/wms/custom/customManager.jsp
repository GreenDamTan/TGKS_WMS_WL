<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
#customReq{border:0px solid;}
#customReq td{border:0px solid;}
#customReq input{width:120px;}
#customReq select{width:120px;}
</style>
<input type="hidden" id="customManagerSubmit" name="customManagerSubmit" value="0" />
<div class="ui-widget">
	<form id="customReq" action="../wms/queryCustom.action" method="post">
		<table>
			<tr>
				<td><label>名称: </label></td><td><input type="text" name="customReq.name" /></td>
				<td><label>电话: </label></td><td><input type="text" name="customReq.tel" /></td>
				<td><label>传真: </label></td><td><input type="text" name="customReq.fax" /></td>
				<td>
				<button id="clearCustom">重置</button>
				<button id="queryCustom">查询</button>
				</td>
			</tr>
		</table>
		
	</form>
</div>

<button id="addCustom">新增</button>
<button id="deleteCustom">删除</button>

<div id="customDiv"></div>

<div id="customEdit" title="客户信息编辑">
	<form id="customForm" action="../wms/editCustom.action" method="post"></form>
</div>

<div id="customConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>记录将被删除且不可恢复，是否确认？</p>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var table=$.ajax({url:"../wms/queryCustom.action",async:false});
	$("#customDiv").html(table.responseText);
	
	function query()
	{
		var table=$.ajax({url:"../wms/queryCustom.action", data:$("#customReq").formSerialize(), async:false});
		$("#customDiv").html(table.responseText);
	}
	
	// 新增/更新窗口
	$( "#customEdit" ).dialog({
		modal: true,
		height:400,
		width:580,
		autoOpen: false,
		show: "fold",
		hide: "fold",
		buttons:
		{ 
			"确定":function()
			{
				//alert("按了确定");
				// 页面校验
				if (!customFormCheck())
				{
					return false;
				}
				var form = $("#customForm");
				form.submit();
			}, 
			"关闭": function()
			{
				$("#customManagerSubmit").val("0");
				$("#customEdit").dialog("close"); 
			} 
		}
	});
	
	// 提交表单
	$("#customForm").submit(function()
	{
		if ($("#customManagerSubmit").val() == "0")
		{
			return false;
		}
		
		$("#customManagerSubmit").val("0");
		
		var options = { 
			url:"../wms/editCustom.action", // 提交给哪个执行
			type:'POST', 
			success: function(){
				$("#customEdit").dialog("close");
				// 新增完毕刷新form
				query();
				alert("操作成功");
			},
			error:function(){ 
				$("#customEdit").dialog("close"); 
				alert("操作失败"); 
			}
		};
		
		$("#customForm").ajaxSubmit(options);
		return false; // 为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
	});  
	
	// 新增按钮
	$( "#addCustom" ).button({
		icons: {
			primary: "ui-icon-plus"
			}
		}).click(function() {
		$("#customManagerSubmit").val("1");
		$( "#customEdit" ).dialog( "open" );
		var edit=$.ajax({url:"../wms/editCustomPage.action",async:false});
		$("#customForm").html(edit.responseText);
		return false;
	});
	
	 // 删除按钮
	$( "#deleteCustom" ).button({
		icons: {
			primary: "ui-icon-minus"
			}
		}).click(function() {
		$("#customManagerSubmit").val("1");
		// 获取选中的记录ids
		var ids = "";
		var array = document.getElementsByName("customId");
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
			$("#customManagerSubmit").val("0");
			return false;
		}
		
		// ajax调用删除action
		var options = { 
			url:"../wms/deleteCustom.action?ids=" + ids , // 提交给哪个执行
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
		$("#customConfirm").dialog({
			resizable: false,
            height:160,
            modal: true,
            buttons: {
                "确认": function() {
                	$( this ).dialog( "close" );
                	// 异步请求删除操作
                	$("#customConfirm").ajaxSubmit(options);
                },
                "取消": function() {
                    $( this ).dialog( "close" );
                }
            }
		});
				
		return false;
	});
	 
	 // 启用按钮
	$( "#onCustom" ).button({
		icons: {
			primary: "ui-icon-check"
			}
		}).click(function() {
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("customId");
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
				url:"../wms/changeStatusCustom.action?status=1&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#customConfirm").ajaxSubmit(options);
			return false;
	});
	 
	 // 停用按钮
	$( "#offCustom" ).button({
		icons: {
			primary: "ui-icon-close"
			}
		}).click(function() {
			// 获取选中的记录ids
			var ids = "";
			var array = document.getElementsByName("customId");
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
				url:"../wms/changeStatusCustom.action?status=0&ids=" + ids , // 提交给哪个执行
				type:'POST', 
				success: function(){
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			$("#customConfirm").ajaxSubmit(options);
			return false;
	});
	
	 // 刷新按钮
	$( "#queryCustom" ).button().click(function() {
			query();
		return false;
	});
	 
	// 重置按钮
	$( "#clearCustom" ).button().click(function() {
			$("#customReq").clearForm();
		return false;
	});
	
	// 页面校验
	function customFormCheck()
	{
		//alert("页面校验");
		if ($("#customName").val() == "")
		{
			alert("名称不能为空！");
			$("#customName").focus();
			return false;
		}
		return true;
	}
});
</script>
