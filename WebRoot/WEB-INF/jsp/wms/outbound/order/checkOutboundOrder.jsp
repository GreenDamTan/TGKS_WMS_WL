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
<input id="btnPrint" type="button" value="打印" onclick="preview(1);" />
</div>
<!--startprint1-->
<div id="outboundOrderHeaderDiv" style="width:90%">
	<table id="outboundOrderHeader">
		<tr>
			<th colspan="7" style="font-size:32px; text-align:center; background:#FFF">太仓伟丽金属制品有限公司对账单</th>
		</tr>
	</table>
</div>

<div id="customDiv" style="width:90%">
	<table id="custom">
		<tr>
			<td>客户：${outboundOrderEvt.custom }</td>
			<td style="text-align:right">打印时间：${printDate }</td>
		</tr>
	</table>
</div>

<div id="outboundTableDiv" style="width:90%">
    <table id="outboundTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header">
            	<th>送货单号</th>
          	 	<th>编号</th>
				<th>名称</th>
				<th>型号 | 规格</th>
				<th>出库数量</th>
				<th>单位</th>
				<th>单价</th>
				<th>税点</th>
				<th>总价</th>
				<th>备注</th>
            </tr>
        </thead>
        <tbody>
        	<s:iterator value="outboundOrderList" var="evt" status="index">
				<s:iterator  value="#evt.list" var="evt2" status="index2">
					<tr <s:if test="#index.Even">style="background-color:#dddddd"</s:if>>
       					<td><s:if test="#index2.First"><s:property value="#evt.id"/></s:if></td>
						<td><s:property value="#evt2.code"/></td>
						<td><s:property value="#evt2.name"/></td>
						<td><s:property value="#evt2.model"/> | <s:property value="#evt2.spec"/></td>
						<td><s:property value="#evt2.number"/></td>
						<td><s:property value="#evt2.unit"/></td>
						<td><s:property value="#evt2.price"/></td>
						<td><s:if test="#evt2.tax != 0"><s:property value="#evt2.tax"/></s:if><s:else>已含税</s:else></td>
						<td><s:property value="#evt2.total"/></td>
						<td><s:property value="#evt2.remark"/></td>
					</tr>
				</s:iterator>
			</s:iterator>
			<tr>
				<td colspan="8" style="text-align:right;">合计：</td><td colspan="2">${totalPrice }</td>
			</tr>
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
