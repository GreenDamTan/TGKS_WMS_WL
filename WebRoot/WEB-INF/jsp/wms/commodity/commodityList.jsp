<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<!-- 图片方法功能 -->
<script src="<%=basePath%>js/common/image/js-global/FancyZoomHTML.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=basePath%>js/common/image/js-global/FancyZoom.js" language="JavaScript" type="text/javascript"></script>
<script type="text/javascript">
setupZoom();
</script>
<input type="hidden" id="commodityListSubmit" name="commodityListSubmit" value="0" />
<div id="commodityTableDiv" class="ui-widget">
    <table id="commodityTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th width="20"><input type="checkbox" id="allCommodityId" name="allCommodityId"/></th>
				<th>名称</th>
				<th>编号</th>
				<th>类别</th>
				<th>材料</th>
				<th>型号</th>
				<th>规格</th>
				<th>数量</th>
				<th>单位</th>
				<th>单价</th>
				<th>供应商</th>
				<th>入库时间</th>
				<th>状态</th>
				<!-- <th>备注</th> -->
				<th>操作</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr>
					<td width="20"><input type="checkbox" name="commodityId" value="<s:property value='#evt.id'/>"/></td>
					<td><b id="<s:property value='#evt.id'/>" class="commodityUpdate"><s:property value="#evt.name"/></b></td>
					<td><s:property value="#evt.code"/></td>
					<td><s:if test="#evt.type == 0">原材料</s:if><s:if test="#evt.type == 1">半成品</s:if><s:if test="#evt.type == 2">成品</s:if></td>
					<td><s:property value="#evt.material"/></td>
					<td><s:property value="#evt.model"/></td>
					<td><s:property value="#evt.spec"/></td>
					<td><s:property value="#evt.number"/></td>
					<td><s:property value="#evt.unit"/></td>
					<td><s:property value="#evt.price"/></td>
					<td><s:property value="#evt.supplier"/></td>
					<td><s:date name="#evt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<td><s:if test="#evt.status == 0">未入库</s:if><s:if test="#evt.status == 1">已入库</s:if></td>
					<!-- <td><s:property value="#evt.remark"/></td> -->
					<td><button id="<s:property value='#evt.id'/>S" class="storage">入库</button><button id="<s:property value='#evt.id'/>O" class="outbound">出库</button></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>

<div id="storageEdit" title="库存入库" hidden="hidden">
	<form id="storageForm" action="../wms/storage.action" method="post"></form>
</div>

<div id="outboundEdit" title="库存出库" hidden="hidden">
	<form id="outboundForm" action="../wms/outbound.action" method="post"></form>
</div>

<script type="text/javascript">
$(function() {
	$("#commodityTable").longtable({
		'perPage' : 8
	});

	// 点击记录首栏进入更新操作
	$(".commodityUpdate").click(function() {
		$("#commodityManagerSubmit").val("1");
		$("#commodityEdit").dialog("open");
		var edit = $.ajax({
			url : "../wms/editCommodityPage.action?id=" + this.id,
			async : false
		});
		$("#commodityForm").html(edit.responseText);
	});
	
	// 入库操作
	$(".storage").click(function(){
		$("#commodityListSubmit").val("1");
		
		$("#storageEdit").dialog("open");
		var edit = $.ajax({
			url : "../wms/storagePage.action?id=" + this.id,
			async : false
		});
		$("#storageForm").html(edit.responseText);
	});
	
	// 入库操作窗口
	$( "#storageEdit" ).dialog({
		modal: true,
		height:320,
		width:330,
		autoOpen: false,
		show: "fold",
		hide: "fold",
		buttons:
		{ 
			"确定":function()
			{
				// 入库校验
				if (!storageCheck())
				{
					return false;
				}
				var form = $("#storageForm");
				form.submit();
			}, 
			"关闭": function()
			{
				$("#commodityListSubmit").val("0");
				$("#storageEdit").dialog("close"); 
			} 
		}
	});
	
	// 入库提交
	$("#storageForm").submit(function()
	{
		if ($("#commodityListSubmit").val() == "0")
		{
			return false;
		}
		
		$("#commodityListSubmit").val("0");
		
		var options = { 
			url:"../wms/storage.action", // 提交给哪个执行
			type:'POST', 
			success: function(){
				$("#storageEdit").dialog("close");
				// 新增完毕刷新form
				query();
				alert("操作成功");
			},
			error:function(){ 
				$("#storageEdit").dialog("close"); 
				alert("操作失败"); 
			}
		};
		
		$("#storageForm").ajaxSubmit(options);
		
		return false; // 为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
	});
	
	// 出库操作
	$(".outbound").click(function(){
		$("#commodityListSubmit").val("1");
		
		$("#outboundEdit").dialog("open");
		var edit = $.ajax({
			url : "../wms/outboundPage.action?id=" + this.id,
			async : false
		});
		$("#outboundForm").html(edit.responseText);
		return false;
	});
	
	// 出库操作窗口
	$( "#outboundEdit" ).dialog({
		modal: true,
		height:380,
		width:480,
		autoOpen: false,
		show: "fold",
		hide: "fold",
		buttons:
		{ 
			"确定":function()
			{
				// 出库校验
				if (!outboundCheck())
				{
					return false;
				}
				var form = $("#outboundForm");
				form.submit();
			}, 
			"关闭": function()
			{
				$("#commodityListSubmit").val("0");
				$("#outboundEdit").dialog("close"); 
			} 
		}
	});
	
	// 出库提交
	$("#outboundForm").submit(function()
	{
		if ($("#commodityListSubmit").val() == "0")
		{
			return false;
		}
		
		$("#commodityListSubmit").val("0");
		
		var options = { 
			url:"../wms/outbound.action", // 提交给哪个执行
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

	// 全选
	$("#allCommodityId").click(function(){
		var checkbox = $("#commodityTable :checkbox");
		for (var i = 1; i < checkbox.length; i++)
		{
			if (checkbox[i].hidden == "")
			{
				checkbox[i].checked = checkbox[0].checked;
			}
		}
	});
	
	function query()
	{
		var table=$.ajax({url:"../wms/queryCommodity.action", data:$("#commodityReq").formSerialize(),async:false});
		$("#commodityDiv").html(table.responseText);
	}
	
	function storageCheck()
	{
		var price = parseFloat($("#storagePrice").val());
		var number = parseFloat($("#storageNumber").val());
		//alert(number);
		
		// 价格校验
		if ($("#storagePrice").val() == "")
		{
			alert("价格不能为空！");
			$("#storagePrice").focus();
			return false;
		}
		
		if (price < 0)
		{
			alert("价格必须大于等于0！");
			$("#storagePrice").focus();
			return false;
		}
		
		// 数量校验
		if ($("#storageNumber").val() == "")
		{
			alert("出库数量不能为空！");
			$("#storageNumber").focus();
			return false;
		}
		
		if (number <= 0)
		{
			alert("入库数量必须大于0！");
			$("#storageNumber").focus();
			return false;
		}
		
		return true;
	}
	
	function outboundCheck()
	{
		var price = parseFloat($("#outboundPrice").val());
		var number = parseFloat($("#outboundNumber").val());
		var max = parseFloat($("#maxNumber").val());
		//alert(number);
		//alert(max);
		
		// 价格校验
		if ($("#outboundPrice").val() == "")
		{
			alert("价格不能为空！");
			$("#outboundPrice").focus();
			return false;
		}
		
		if (price < 0)
		{
			alert("价格必须大于等于0！");
			$("#outboundPrice").focus();
			return false;
		}
		
		// 数量校验
		if ($("#outboundNumber").val() == "")
		{
			alert("出库数量不能为空！");
			$("#outboundNumber").focus();
			return false;
		}
		if (number <= 0)
		{
			alert("出库数量必须大于0！");
			$("#outboundNumber").focus();
			return false;
		}
		if (number > max)
		{
			alert("出库数量不能大于当前库存！");
			$("#outboundNumber").focus();
			return false;
		}
		
		return true;
	}
});
</script>
