<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" id="outboundOrderListSubmit" name="outboundOrderListSubmit" value="0" />
<div id="outboundOrderTableDiv" class="ui-widget">
    <table id="outboundOrderTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th width="20"><input type="checkbox" id="allOutboundOrderId" name="allOutboundOrderId"  /></th>
				<th>送货单号</th>
				<th>客户</th>
				<th>打印日期</th>
				<th>操作</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="outboundOrderList" var="evt">
				<tr>
					<td width="20"><input type="checkbox" name="outboundOrderId" value="<s:property value='#evt.id'/>" /></td>
					<td><s:property value="#evt.id"/></td>
					<td><s:property value="#evt.custom"/></td>
					<td><s:date name="#evt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<td><button id="<s:property value='#evt.id'/>" class="outboundOrderOrder">查看</button></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>
<script type="text/javascript">
	$(function() {
		$('#outboundOrderTable').longtable({
			'perPage' : 10
		});

		// 点击记录首栏进入更新操作
		$(".outboundOrderUpdate").click(function() {
			$("#outboundOrderEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editOutboundOrderPage.action?id=" + this.id,
				async : false
			});
			$("#outboundOrderForm").html(edit.responseText);
		});

		// 全选
		$("#allOutboundOrderId").click(function() {
			var checkbox = $("#outboundOrderTable :checkbox");
			for ( var i = 1; i < checkbox.length; i++) {
				if (checkbox[i].hidden == "") {
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
		
		$(".outboundOrderOrder").click(function(){
			window.open("../wms/outboundOrderOrder.action?id=" + this.id);
		});
	});
</script>