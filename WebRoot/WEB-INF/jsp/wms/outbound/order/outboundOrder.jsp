<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	
	<title>帝国业务管理系统</title>
	
	<meta charset="utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">	
	<meta http-equiv="keywords" content="幻影帝国,猫盟公社,帝国业务管理系统">
	<meta http-equiv="description" content="帝国业务管理系统">

<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/black-tie/jquery-ui-1.10.3.custom.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/black-tie/jquery-ui-1.10.3.custom.min.css"/>
<style type="text/css">
body {TEXT-ALIGN: center;}
#outboundOrderHeaderDiv { MARGIN-RIGHT: auto; MARGIN-LEFT: auto;
 margin:0 auto; padding:0px; border-spacing:0px; border-style:none; border-collapse:collapse;}
#outboundTableDiv { MARGIN-RIGHT: auto; MARGIN-LEFT: auto; }
#customDiv { MARGIN-RIGHT: auto; MARGIN-LEFT: auto; }
#outboundOrderHeaderDiv{border-style: none; }
#outboundOrderHeader td {border-style: none;}
#custom td{border-style: none;}
.noprint{display : none }
</style>
</head>
<body>
<div align="center">
<input id="btnPrint" type="button" value="打印" onclick="javascript:window.print();" />
</div>
<!--startprint1-->
<div id="outboundOrderHeaderDiv" style="width:90%">
	<table id="outboundOrderHeader">
		<tr>
			<th colspan="7" style="font-size:32px; text-align:center; background:#FFF">太仓伟丽金属制品有限公司出货单</th>
		</tr>
	</table>
</div>

<div id="customDiv" style="width:90%">
	<table id="custom">
		<tr>
			<td>编号：${outboundOrderEvt.id }</td>
			<td style="text-align:right"></td>
		</tr>
		<tr>
			<td>客户：${outboundOrderEvt.custom }</td>
			<td style="text-align:right">出货时间：<s:date name="outboundOrderEvt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
	</table>
</div>

<div id="outboundTableDiv" style="width:90%">
    <table id="outboundTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header">
          	 	<th>编号</th>
				<th>名称</th>
				<th>型号 | 规格</th>
				<th>出库数量</th>
				<th>单位</th>
				<th>备注</th>
				<!-- 
				<th>单价</th>
				<th>税点</th>
				<th>总价</th>
				 -->
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr>
					<td><s:property value="#evt.code"/></td>
					<td><s:property value="#evt.name"/></td>
					<td><s:property value="#evt.model"/> | <s:property value="#evt.spec"/></td>
					<td><s:property value="#evt.number"/></td>
					<td><s:property value="#evt.unit"/></td>
					<td><s:property value="#evt.remark"/></td>
					<!-- 
					<td><s:property value="#evt.price"/></td>
					<td><s:property value="#evt.tax"/></td>
					<td><s:property value="#evt.total"/></td>
					 -->
				</tr>
			</s:iterator>
			<!-- 
			<tr>
				<td colspan="5" style="text-align:right;">合计：</td><td>${totalPrice }</td>
			</tr>
			 -->
		</tbody>
    </table>
</div>
<!--endprint1-->
<script type="text/javascript">
	$(function() {
		// 点击记录首栏进入更新操作
		$(".outboundUpdate").click(function() {
			$("#outboundEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editOutboundPage.action?id=" + this.id,
				async : false
			});
			$("#outboundForm").html(edit.responseText);
		});

		// 全选
		$("#allOutboundId").click(function() {
			var checkbox = $("#outboundTable :checkbox");
			for ( var i = 1; i < checkbox.length; i++) {
				if (checkbox[i].hidden == "") {
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
	});
</script>
<script type="text/javascript">
function preview(oper)
{
	if (oper < 10)
	{
		bdhtml=window.document.body.innerHTML;//获取当前页的html代码
		sprnstr="<!--startprint"+oper+"-->";//设置打印开始区域
		eprnstr="<!--endprint"+oper+"-->";//设置打印结束区域
		prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
		
		prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
		window.document.body.innerHTML=prnhtml;
		window.print();
		window.document.body.innerHTML=bdhtml;
	} 
	else
	{
		window.print();
	}
}
</script>
</body>
</html>
