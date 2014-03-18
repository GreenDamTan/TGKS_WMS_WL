<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<div id="outboundTableDiv" class="ui-widget">
    <table id="outboundTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th width="20"><input type="checkbox" id="allOutboundId" name="allOutboundIdX" /></th>
				<th>名称</th>
				<th>编号</th>
				<th>类别</th>
				<th>材料</th>
				<th>型号</th>
				<th>规格</th>
				<th>数量</th>
				<th>单位</th>
				<th>单价</th>
				<th>税点</th>
				<th>总价</th>
				<th>客户</th>
				<th>出库时间</th>
				<th>送货单</th>
				<th>备注</th>
				<th>操作</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr <s:if test="#evt.print == 1">style="background-color:#dddddd"</s:if>>
					<td width="20"><s:if test="#evt.print == 0"><input type="checkbox" name="outboundId" value="<s:property value='#evt.id'/>"/></s:if></td>
					<td><s:property value="#evt.name"/></td>
					<td><s:property value="#evt.code"/></td>
					<td><s:if test="#evt.type == 0">原材料</s:if><s:if test="#evt.type == 1">半成品</s:if><s:if test="#evt.type == 2">成品</s:if></td>
					<td><s:property value="#evt.material"/></td>
					<td><s:property value="#evt.model"/></td>
					<td><s:property value="#evt.spec"/></td>
					<td><s:property value="#evt.number"/></td>
					<td><s:property value="#evt.unit"/></td>
					<td><s:property value="#evt.price"/></td>
					<td><s:property value="#evt.tax"/></td>
					<td><s:property value="#evt.total"/></td>
					<td><s:property value="#evt.custom"/></td>
					<td><s:date name="#evt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<td><s:if test="#evt.print == 0">未生成</s:if><s:if test="#evt.print == 1">已生成</s:if></td>
					<td><s:property value="#evt.remark"/></td>
					<td><s:if test="#evt.print == 0"><button id="<s:property value='#evt.id'/>" class="cancelOutbound">取消出库</button></s:if></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>
<div id="cancelOutboundConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>取消出库将会把出库数量退回库存中，是否确认？</p>
</div>
<script type="text/javascript">
	$(function() {
		$('#outboundTable').longtable({
			'perPage' : 10
		});
		
		function query()
		{
			var table=$.ajax({url:"../wms/queryOutbound.action", data:$("#outboundReq").formSerialize(), async:false});
			$("#outboundDiv").html(table.responseText);
		}

		// 取消出库按钮
		$( ".cancelOutbound" ).button().click(function() {
			// ajax调用删除action
			var options = { 
				url:"../wms/cancelOutbound.action?id=" + this.id , // 提交给哪个执行
				type:'POST', 
				success: function(){
					alert("操作成功");
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			// 确认操作
			$("#cancelOutboundConfirm").dialog({
				resizable: false,
	            height:160,
	            modal: true,
	            buttons: {
	                "确认": function() {
	                	$( this ).dialog( "close" );
	                	// 异步请求删除操作
	                	$("#cancelOutboundConfirm").ajaxSubmit(options);
	                },
	                "取消": function() {
	                    $( this ).dialog( "close" );
	                }
	            }
			});
					
			return false;
		});
		/* 点击记录首栏进入更新操作
		$(".outboundUpdate").click(function() {
			$("#outboundEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editOutboundPage.action?id=" + this.id,
				async : false
			});
			$("#outboundForm").html(edit.responseText);
		});
		*/

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
